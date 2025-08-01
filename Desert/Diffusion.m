% 山地地带数据处理与显示

data = ReadSegy('original_data.sgy');
figure(2); imagesc(data); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Original Record');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1000, 1000]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);

data_sdrt = ReadSegy('result_of_Diffusion.sgy');
figure(4); imagesc(data_sdrt); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Diffusion Result');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1000, 1000]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


noise = ReadSegy('residual_of_Diffusion.sgy');
figure(6); imagesc(noise); colorbar;
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Diffusion Residual');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);
colormap("gray");
caxis([-1000, 1000]);
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);
