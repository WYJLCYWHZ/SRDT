import torch
import torch.nn as nn
import torch.nn.functional as F
from einops import rearrange
from .local_arch import Local_Base
from .module_util import SinusoidalPosEmb, LayerNorm


class SimpleGate(nn.Module):
    def forward(self, x):
        x1, x2 = x.chunk(2, dim=1)
        return x1 * x2


class TransformerBlock(nn.Module):
    def __init__(self, dim, time_emb_dim=None, num_heads=4, mlp_ratio=2., drop=0.):
        super().__init__()
        self.time_mlp = nn.Sequential(
            SimpleGate(),
            nn.Linear(time_emb_dim // 2, dim * 4)
        ) if time_emb_dim else None

        self.norm1 = LayerNorm(dim)
        self.attn = nn.MultiheadAttention(embed_dim=dim, num_heads=num_heads, batch_first=True)
        self.dropout1 = nn.Dropout(drop)

        self.norm2 = LayerNorm(dim)
        self.ffn = nn.Sequential(
            nn.Linear(dim, int(dim * mlp_ratio)),
            nn.GELU(),
            nn.Linear(int(dim * mlp_ratio), dim),
            nn.Dropout(drop)
        )

        self.beta = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)
        self.gamma = nn.Parameter(torch.zeros((1, dim, 1, 1)), requires_grad=True)

    def time_forward(self, time):
        time_emb = self.time_mlp(time)
        time_emb = rearrange(time_emb, 'b c -> b c 1 1')
        return time_emb.chunk(4, dim=1)

    def forward(self, x):
        inp, time = x  # inp: [B, C, H, W], time: [B, time_dim]
        B, C, H, W = inp.shape

        shift_att, scale_att, shift_ffn, scale_ffn = self.time_forward(time)

        x = inp.view(B, C, -1).transpose(1, 2)  # [B, N, C]
        x = self.norm1(x)
        x = x * (scale_att.view(B, 1, C) + 1) + shift_att.view(B, 1, C)

        attn_out, _ = self.attn(x, x, x)
        x = x + self.dropout1(attn_out)
        y = x

        x = self.norm2(x)
        x = x * (scale_ffn.view(B, 1, C) + 1) + shift_ffn.view(B, 1, C)
        x = self.ffn(x)
        x = y + x

        x = x.transpose(1, 2).view(B, C, H, W)
        x = inp + x * self.beta
        x = x + x * self.gamma
        return x, time


class ConditionalUT(nn.Module):
    def __init__(self, img_channel=3, width=16, middle_blk_num=1, enc_blk_nums=[], dec_blk_nums=[], upscale=1):
        super().__init__()
        self.upscale = upscale
        fourier_dim = width
        sinu_pos_emb = SinusoidalPosEmb(fourier_dim)
        time_dim = width * 4

        self.time_mlp = nn.Sequential(
            sinu_pos_emb,
            nn.Linear(fourier_dim, time_dim * 2),
            SimpleGate(),
            nn.Linear(time_dim, time_dim)
        )

        self.intro = nn.Conv2d(img_channel * 2, width, kernel_size=3, padding=1)
        self.ending = nn.Conv2d(width, img_channel, kernel_size=3, padding=1)

        self.encoders = nn.ModuleList()
        self.decoders = nn.ModuleList()
        self.middle_blks = nn.Sequential()
        self.ups = nn.ModuleList()
        self.downs = nn.ModuleList()

        chan = width
        for num in enc_blk_nums:
            self.encoders.append(nn.Sequential(*[TransformerBlock(chan, time_emb_dim=time_dim) for _ in range(num)]))
            self.downs.append(nn.Conv2d(chan, chan * 2, kernel_size=2, stride=2))
            chan *= 2

        self.middle_blks = nn.Sequential(*[TransformerBlock(chan, time_emb_dim=time_dim) for _ in range(middle_blk_num)])

        for num in dec_blk_nums:
            self.ups.append(nn.Sequential(
                nn.Conv2d(chan, chan * 2, kernel_size=1),
                nn.PixelShuffle(2)
            ))
            chan //= 2
            self.decoders.append(nn.Sequential(*[TransformerBlock(chan, time_emb_dim=time_dim) for _ in range(num)]))

        self.padder_size = 2 ** len(self.encoders)

    def forward(self, inp, cond, time):
        if isinstance(time, (int, float)):
            time = torch.tensor([time], device=inp.device, dtype=torch.float32)

        x = inp - cond
        x = torch.cat([x, cond], dim=1)
        t = self.time_mlp(time)

        B, C, H, W = x.shape
        x = self.check_image_size(x)

        x = self.intro(x)
        encs = [x]

        for encoder, down in zip(self.encoders, self.downs):
            x, _ = encoder([x, t])
            encs.append(x)
            x = down(x)

        x, _ = self.middle_blks([x, t])

        for decoder, up, skip in zip(self.decoders, self.ups, reversed(encs[:-1])):
            x = up(x)
            x = x + skip
            x, _ = decoder([x, t])

        x = self.ending(x + encs[0])
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





