
noise = ReadSegy('residual_of_BPF.sgy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('BPF Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);





noise = ReadSegy('residual_of_VMD.sgy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('VMD Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




noise = ReadSegy('residual_of_WNNM.segy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('WNNM Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




noise = ReadSegy('residual_of_RPCA.sgy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('RPCA Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);





noise = ReadSegy('residual_of_UNet.sgy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('UNet Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);





noise = ReadSegy('residual_of_Transformer.sgy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Transformer Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




noise = ReadSegy('residual_of_Diffusion.sgy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Diffusion Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);





noise = ReadSegy('residual_of_SRDT.sgy');
figure; imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('SDRT Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);



