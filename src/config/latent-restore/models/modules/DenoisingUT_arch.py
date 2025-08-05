import torch
import torch.nn as nn
import torch.nn.functional as F
from einops import rearrange
from .local_arch import Local_Base
from .module_util import SinusoidalPosEmb, LayerNorm

import torch
import torch.nn as nn
import torch.nn.functional as F
from einops import rearrange
from .module_util import SinusoidalPosEmb, LayerNorm, exists

import torch
import torch.nn as nn
import torch.nn.functional as F
from einops import rearrange
from .module_util import SinusoidalPosEmb

class SimpleGate(nn.Module):
    def forward(self, x):
        x1, x2 = x.chunk(2, dim=1)
        return x1 * x2

class UViTBlock(nn.Module):
    def __init__(self, dim, mlp_ratio=2, time_emb_dim=None, dropout=0.):
        super().__init__()
        self.norm1 = nn.LayerNorm(dim)
        self.attn = nn.MultiheadAttention(embed_dim=dim, num_heads=4, batch_first=True)
        self.norm2 = nn.LayerNorm(dim)

        self.mlp = nn.Sequential(
            nn.Linear(dim, dim * mlp_ratio),
            nn.GELU(),
            nn.Linear(dim * mlp_ratio, dim),
        )

        self.time_proj = nn.Sequential(
            SimpleGate(),
            nn.Linear(time_emb_dim // 2, dim)
        ) if time_emb_dim else None

        self.dropout = nn.Dropout(dropout)
        self.beta = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)
        self.gamma = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)

    def forward(self, x, time):
        B, C, H, W = x.shape
        x_in = x

        # Flatten spatial dimensions for attention
        x = rearrange(x, 'b c h w -> b (h w) c')
        
        # LayerNorm expects last dim to match normalized_shape
        x = self.norm1(x)
        
        attn_out, _ = self.attn(x, x, x)
        x = x + self.dropout(attn_out)
        
        x = self.norm2(x)
        x = x + self.dropout(self.mlp(x))
        
        # Restore spatial dimensions
        x = rearrange(x, 'b (h w) c -> b c h w', h=H, w=W)

        if self.time_proj is not None:
            shift = self.time_proj(time)
            shift = rearrange(shift, 'b c -> b c 1 1')
            x = x + shift

        return x_in + x * self.beta + x * self.gamma

class ConditionalUT(nn.Module):
    def __init__(self, img_channel=3, width=16, middle_blk_num=1, 
                 enc_blk_nums=[], dec_blk_nums=[], upscale=1, window_size=8):
        super().__init__()
        self.upscale = upscale
        self.window_size = window_size
        fourier_dim = width
        time_dim = width * 4

        # Time embedding
        self.time_mlp = nn.Sequential(
            SinusoidalPosEmb(fourier_dim),
            nn.Linear(fourier_dim, time_dim * 2),
            SimpleGate(),
            nn.Linear(time_dim, time_dim)
        )

        # Input/output convolutions
        self.intro = nn.Conv2d(img_channel * 2, width, kernel_size=3, padding=1)
        self.ending = nn.Conv2d(width, img_channel, kernel_size=3, padding=1)

        # Encoder/decoder structures
        self.encoders = nn.ModuleList()
        self.decoders = nn.ModuleList()
        self.downsamples = nn.ModuleList()
        self.upsamples = nn.ModuleList()

        # Build encoder
        chan = width
        for num in enc_blk_nums:
            # UViT blocks
            self.encoders.append(
                nn.Sequential(*[
                    UViTBlock(dim=chan, time_emb_dim=time_dim) 
                    for _ in range(num)
                ])
            )
            # Downsample layer (with channel increase)
            self.downsamples.append(
                nn.Sequential(
                    nn.Conv2d(chan, chan*2, kernel_size=3, stride=2, padding=1),
                )
            )
            chan *= 2

        # Middle blocks
        self.middle_blks = nn.Sequential(
            *[UViTBlock(dim=chan, time_emb_dim=time_dim) 
              for _ in range(middle_blk_num)]
        )

        # Build decoder - ensure symmetry with encoder
        for i, num in enumerate(dec_blk_nums):
            # Calculate input and output channels for upsampling
            in_chan = chan
            out_chan = chan // 2
            
            # Upsample layer
            self.upsamples.append(
                nn.Sequential(
                    nn.Conv2d(in_chan, in_chan * 4, kernel_size=1),  # Prepare for PixelShuffle
                    nn.PixelShuffle(2),
                    nn.Conv2d(in_chan, out_chan, kernel_size=3, padding=1)
                )
            )
            
            # UViT blocks
            self.decoders.append(
                nn.Sequential(*[
                    UViTBlock(dim=out_chan, time_emb_dim=time_dim) 
                    for _ in range(num)
                ])
            )
            chan = out_chan

        self.padder_size = 2 ** len(enc_blk_nums)

    def forward(self, inp, cond, time):
        # Process time
        if isinstance(time, (int, float)):
            time = torch.tensor([time], device=inp.device)
        if time.dim() == 0:
            time = time.unsqueeze(0)
        time = time.float()
        t = self.time_mlp(time)

        # Prepare input
        x = inp - cond
        x = torch.cat([x, cond], dim=1)
        B, C, H, W = x.shape
        x = self.check_image_size(x)

        # Initial convolution
        x = self.intro(x)
        enc_features = [x]  # Store all encoder features for skip connections

        # Encoder path
        for encoder, downsample in zip(self.encoders, self.downsamples):
            # UViT blocks
            for block in encoder:
                x = block(x, t)
            enc_features.append(x)  # Store pre-downsample feature
            
            # Downsample
            x = downsample(x)
            enc_features.append(x)  # Store post-downsample feature

        # Middle blocks
        for block in self.middle_blks:
            x = block(x, t)

        # Decoder path
        skip_idx = len(enc_features) - 1  # Start from the last encoder feature
        for decoder, upsample in zip(self.decoders, self.upsamples):
            # Upsample
            x = upsample(x)
            
            # Skip connection (use corresponding encoder feature)
            skip_idx -= 2  # Move to pre-downsample feature
            skip = enc_features[skip_idx]
            
            # Ensure spatial dimensions match
            if skip.shape[-2:] != x.shape[-2:]:
                skip = F.interpolate(skip, size=x.shape[-2:], mode='bilinear', align_corners=False)
            
            x = x + skip
            
            # UViT blocks
            for block in decoder:
                x = block(x, t)

        # Final output (add initial feature)
        if enc_features[0].shape[-2:] != x.shape[-2:]:
            enc_features[0] = F.interpolate(enc_features[0], size=x.shape[-2:], mode='bilinear', align_corners=False)
        x = x + enc_features[0]
        
        x = self.ending(x)
        return x[..., :H, :W]

    def check_image_size(self, x):
        _, _, h, w = x.size()
        mod_pad_h = (self.padder_size - h % self.padder_size) % self.padder_size
        mod_pad_w = (self.padder_size - w % self.padder_size) % self.padder_size
        x = F.pad(x, (0, mod_pad_w, 0, mod_pad_h))
        return x

class CNAFUTLocal(Local_Base, ConditionalUT):
    def __init__(self, *args, train_size=(1, 3, 128, 128), fast_imp=False, **kwargs):
        Local_Base.__init__(self)
        ConditionalUT.__init__(self, *args, **kwargs)
        N, C, H, W = train_size
        base_size = (int(H * 1.5), int(W * 1.5))
        self.eval()
        with torch.no_grad():
            self.convert(base_size=base_size, train_size=train_size, fast_imp=fast_imp)












'''
# #The Second ConditionalUT Implementation for window-attention UViTBlock

# class UViTBlock(nn.Module):
#     def __init__(self, dim, window_size=8, mlp_ratio=2, time_emb_dim=None, dropout=0.):
#         super().__init__()
#         self.window_size = window_size
#         self.norm1 = nn.LayerNorm(dim)
#         self.attn = nn.MultiheadAttention(embed_dim=dim, num_heads=4, batch_first=True)
#         self.norm2 = nn.LayerNorm(dim)

#         self.mlp = nn.Sequential(
#             nn.Linear(dim, dim * mlp_ratio),
#             nn.GELU(),
#             nn.Linear(dim * mlp_ratio, dim),
#         )

#         self.time_proj = nn.Sequential(
#             SimpleGate(),
#             nn.Linear(time_emb_dim // 2, dim)
#         ) if time_emb_dim else None

#         self.dropout = nn.Dropout(dropout)
#         self.beta = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)
#         self.gamma = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)

#     def forward(self, x, time):
#         B, C, H, W = x.shape
#         ws = self.window_size
#         assert H % ws == 0 and W % ws == 0, "Input size must be divisible by window size"

#         x_in = x

#         # [B, C, H, W] → [B*ws*ws, n_wins, C]
#         x = rearrange(x, 'b c (h ws1) (w ws2) -> (b h w) (ws1 ws2) c', ws1=ws, ws2=ws)

#         x = self.norm1(x)
#         attn_out, _ = self.attn(x, x, x)
#         x = x + self.dropout(attn_out)

#         x = self.norm2(x)
#         x = x + self.dropout(self.mlp(x))

#         x = rearrange(x, '(b h w) (ws1 ws2) c -> b c (h ws1) (w ws2)', 
#                       b=B, h=H//ws, w=W//ws, ws1=ws, ws2=ws)

#         if self.time_proj is not None:
#             shift = self.time_proj(time)
#             shift = rearrange(shift, 'b c -> b c 1 1')
#             x = x + shift

#         return x_in + x * self.beta + x * self.gamma


# from .module_util import SinusoidalPosEmb, LayerNorm

# class ConditionalUT(nn.Module):
#     def __init__(self, img_channel=3, width=16, middle_blk_num=1, enc_blk_nums=[], dec_blk_nums=[], upscale=1, window_size=8):
#         super().__init__()
#         self.upscale = upscale
#         self.window_size = window_size
#         fourier_dim = width
#         time_dim = width * 4

#         self.time_mlp = nn.Sequential(
#             SinusoidalPosEmb(fourier_dim),
#             nn.Linear(fourier_dim, time_dim * 2),
#             SimpleGate(),
#             nn.Linear(time_dim, time_dim)
#         )

#         self.intro = nn.Conv2d(img_channel * 2, width, 3, 1, 1)
#         self.ending = nn.Conv2d(width, img_channel, 3, 1, 1)

#         self.encoders = nn.ModuleList()
#         self.downs = nn.ModuleList()
#         self.middle_blks = nn.ModuleList()
#         self.ups = nn.ModuleList()
#         self.decoders = nn.ModuleList()

#         chan = width
#         for num in enc_blk_nums:
#             self.encoders.append(
#                 nn.Sequential(*[UViTBlock(chan, window_size=window_size, time_emb_dim=time_dim) for _ in range(num)])
#             )
#             self.downs.append(nn.Conv2d(chan, chan * 2, 2, 2))
#             chan *= 2

#         self.middle_blks = nn.Sequential(
#             *[UViTBlock(chan, window_size=window_size, time_emb_dim=time_dim) for _ in range(middle_blk_num)]
#         )

#         for num in dec_blk_nums:
#             self.ups.append(
#                 nn.Sequential(
#                     nn.Conv2d(chan, chan * 2, 1, bias=False),
#                     nn.PixelShuffle(2)
#                 )
#             )
#             chan = chan // 2
#             self.decoders.append(
#                 nn.Sequential(*[UViTBlock(chan, window_size=window_size, time_emb_dim=time_dim) for _ in range(num)])
#             )

#         self.padder_size = 2 ** len(self.encoders)

#     def forward(self, inp, cond, time):
#         if isinstance(time, (int, float)):
#             time = torch.tensor([time], device=inp.device)
#         if time.dim() == 0:
#             time = time.unsqueeze(0)
#         time = time.float()

#         x = inp - cond
#         x = torch.cat([x, cond], dim=1)
#         t = self.time_mlp(time)

#         B, C, H, W = x.shape
#         x = self.check_image_size(x)

#         x = self.intro(x)

#         encs = [x]
#         for encoder, down in zip(self.encoders, self.downs):
#             for block in encoder:
#                 x = block(x, t)
#             encs.append(x)
#             x = down(x)

#         for block in self.middle_blks:
#             x = block(x, t)

#         for decoder, up, enc_skip in zip(self.decoders, self.ups, encs[::-1]):
#             x = up(x)
#             x = x + enc_skip
#             for block in decoder:
#                 x = block(x, t)

#         x = self.ending(x + encs[0])
#         x = x[..., :H, :W]
#         return x

#     def check_image_size(self, x):
#         _, _, h, w = x.size()
#         mod_pad_h = (self.padder_size - h % self.padder_size) % self.padder_size
#         mod_pad_w = (self.padder_size - w % self.padder_size) % self.padder_size
#         x = F.pad(x, (0, mod_pad_w, 0, mod_pad_h))
#         return x

'''









'''
# #The Third ConditionalUT Implementation for TransformerBlock instead of  UViTBlock

# class TransformerBlock(nn.Module):
#     def __init__(self, dim, heads=8, mlp_ratio=2, time_emb_dim=None, dropout=0.):
#         super().__init__()
#         # self.norm1 = LayerNorm(dim)
#         self.attn = nn.MultiheadAttention(embed_dim=dim, num_heads=heads, batch_first=True)
#         # self.norm2 = LayerNorm(dim)
#         # 替换原始定义
#         self.norm1 = nn.LayerNorm(dim)
#         self.norm2 = nn.LayerNorm(dim)
#         # 添加 patch_embed 前置模块
#         self.patch_embed = nn.Conv2d(in_channels=C, out_channels=dim, kernel_size=4, stride=4)



#         self.mlp = nn.Sequential(
#             nn.Linear(dim, dim * mlp_ratio),
#             nn.GELU(),
#             nn.Linear(dim * mlp_ratio, dim),
#         )

#         self.time_proj = nn.Sequential(
#             SimpleGate(),
#             nn.Linear(time_emb_dim // 2, dim)
#         ) if time_emb_dim is not None else None

#         self.dropout = nn.Dropout(dropout)
#         self.beta = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)
#         self.gamma = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)

#     def time_forward(self, time, mlp):
#         time_emb = mlp(time)
#         return rearrange(time_emb, 'b c -> b c 1 1')

#     def forward(self, x, time):
#         B, C, H, W = x.shape
#         x_in = x

#         x = rearrange(x, 'b c h w -> b (h w) c')
#         x = self.norm1(x)
#         attn_out, _ = self.attn(x, x, x)
#         x = x + self.dropout(attn_out)

#         x = self.norm2(x)
#         mlp_out = self.dropout(self.mlp(x))
#         x = x + mlp_out
#         x = rearrange(x, 'b (h w) c -> b c h w', h=H, w=W)

#         if self.time_proj is not None:
#             shift = self.time_forward(time, self.time_proj)
#             x = x + shift

#         return x_in + x * self.beta + x * self.gamma

# class ConditionalUT(nn.Module):
#     def __init__(self, img_channel=3, width=16, middle_blk_num=1, enc_blk_nums=[], dec_blk_nums=[], upscale=1):
#         super().__init__()
#         self.upscale = upscale
#         fourier_dim = width
#         time_dim = width * 4

#         self.time_mlp = nn.Sequential(
#             SinusoidalPosEmb(fourier_dim),
#             nn.Linear(fourier_dim, time_dim * 2),
#             SimpleGate(),
#             nn.Linear(time_dim, time_dim)
#         )

#         self.intro = nn.Conv2d(img_channel * 2, width, 3, 1, 1)
#         self.ending = nn.Conv2d(width, img_channel, 3, 1, 1)

#         self.encoders = nn.ModuleList()
#         self.downs = nn.ModuleList()
#         self.middle_blks = nn.ModuleList()
#         self.ups = nn.ModuleList()
#         self.decoders = nn.ModuleList()

#         chan = width
#         for num in enc_blk_nums:
#             self.encoders.append(
#                 nn.Sequential(*[TransformerBlock(chan, time_emb_dim=time_dim) for _ in range(num)])
#             )
#             self.downs.append(nn.Conv2d(chan, chan * 2, 2, 2))
#             chan *= 2

#         self.middle_blks = nn.Sequential(
#             *[TransformerBlock(chan, time_emb_dim=time_dim) for _ in range(middle_blk_num)]
#         )

#         for num in dec_blk_nums:
#             self.ups.append(
#                 nn.Sequential(
#                     nn.Conv2d(chan, chan * 2, 1, bias=False),
#                     nn.PixelShuffle(2)
#                 )
#             )
#             chan = chan // 2
#             self.decoders.append(
#                 nn.Sequential(*[TransformerBlock(chan, time_emb_dim=time_dim) for _ in range(num)])
#             )

#         self.padder_size = 2 ** len(self.encoders)

#     def forward(self, inp, cond, time):
#         # if isinstance(time, (int, float)):
#         #     time = torch.tensor([time], device=inp.device)

#         if isinstance(time, (int, float)):
#             time = torch.tensor([time], device=inp.device)
#         if time.dim() == 0:
#             time = time.unsqueeze(0)
#         time = time.float()
            

#         x = inp - cond
#         x = torch.cat([x, cond], dim=1)
#         t = self.time_mlp(time)

#         B, C, H, W = x.shape
#         x = self.check_image_size(x)

#         x = self.intro(x)

#         encs = [x]
#         for encoder, down in zip(self.encoders, self.downs):
#             for block in encoder:
#                 x = block(x, t)
#             encs.append(x)
#             x = down(x)

#         for block in self.middle_blks:
#             x = block(x, t)

#         for decoder, up, enc_skip in zip(self.decoders, self.ups, encs[::-1]):
#             x = up(x)
#             x = x + enc_skip
#             for block in decoder:
#                 x = block(x, t)

#         x = self.ending(x + encs[0])
#         x = x[..., :H, :W]

#         return x

#     def check_image_size(self, x):
#         _, _, h, w = x.size()
#         mod_pad_h = (self.padder_size - h % self.padder_size) % self.padder_size
#         mod_pad_w = (self.padder_size - w % self.padder_size) % self.padder_size
#         x = F.pad(x, (0, mod_pad_w, 0, mod_pad_h))
#         return x

'''