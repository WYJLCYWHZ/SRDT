output = ReadSegy('result_of_BPF.sgy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of BPF');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);

output = ReadSegy('result_of_VMD.segy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of VMD');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);

output = ReadSegy('result_of_WNNM.sgy');
cancha = ReadSegy('residual_of_WNNM.sgy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of WNNM');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);

output = ReadSegy('result_of_RPCA.sgy');
cancha = ReadSegy('residual_of_RPCA.sgy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of RPCA');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


% UNet 结果
output = ReadSegy('result_of_UNet.sgy');
cancha = ReadSegy('residual_of_UNet.sgy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of UNet');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);

% Transformer 结果
output = ReadSegy('result_of_Transformer.sgy');
cancha = ReadSegy('residual_of_Transformer.sgy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of Transformer');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);

% Diffusion 结果
output = ReadSegy('result_of_Diffusion.sgy');
cancha = ReadSegy('residual_of_Diffusion.sgy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of Diffusion');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);

% SRDT 结果
output = ReadSegy('result_of_SRDT.sgy');
cancha = ReadSegy('residual_of_SRDT.sgy');

figure;
imagesc(output);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Result of SRDT');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);
