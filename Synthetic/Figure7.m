cancha = ReadSegy('residual_of_BPF.sgy');


load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('BPF Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


cancha = ReadSegy('residual_of_VMD.segy');

load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('VMD Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


output = ReadSegy('result_of_WNNM.sgy');
cancha = ReadSegy('residual_of_WNNM.sgy');


load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('WNNM Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


output = ReadSegy('result_of_RPCA.sgy');
cancha = ReadSegy('residual_of_RPCA.sgy');


load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('RPCA Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


cancha = ReadSegy('residual_of_UNet.sgy');

load('matrix.mat');
cancha = cancha .* matrix; % mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('UNet Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


cancha = ReadSegy('residual_of_Transformer.sgy');

load('matrix.mat');
cancha = cancha .* matrix; % mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Transformer Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


cancha = ReadSegy('residual_of_Diffusion.sgy');

load('matrix.mat');
cancha = cancha .* matrix; % mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('Diffusion Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


cancha = ReadSegy('residual_of_SRDT.sgy');

load('matrix.mat');
cancha = cancha .* matrix; % mask the missing trace

figure;
imagesc(cancha);
xlabel('Trace'); ylabel('Time (ms)');
set(gca, 'xticklabel', get(gca, 'xtick') * 1);
set(gca, 'yticklabel', get(gca, 'ytick') * 2);
title('SRDT Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap('gray');
caxis([-0.1, 0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);




