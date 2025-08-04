
data_sdrt = ReadSegy('result_of_BPF.segy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('BPF Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);



data_sdrt = ReadSegy('result_of_VMD.segy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('VMD Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


data_sdrt = ReadSegy('result_of_WNNM.sgy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('WNNM Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




data_sdrt = ReadSegy('result_of_RPCA.sgy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('RPCA Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);



data_sdrt = ReadSegy('result_of_UNet.sgy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('UNet Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




data_sdrt = ReadSegy('result_of_Transformer.segy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Transformer Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);



data_sdrt = ReadSegy('result_of_Diffusion.segy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Diffusion Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




data_sdrt = ReadSegy('result_of_SRDT.sgy');
figure; imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('SDRT Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1, 1]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




