output = ReadSegy('result_of_BPF.sgy');
cancha = ReadSegy('residual_of_BPF.sgy');


load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace


dx = 0.002;


[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('BPF Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);

output = ReadSegy('result_of_VMD.segy');
cancha = ReadSegy('residual_of_VMD.segy');


load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace

dx = 0.002;



[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('VMD Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);    

% -------------------------------------------------------


output = ReadSegy('result_of_WNNM.sgy');
cancha = ReadSegy('residual_of_WNNM.sgy');


dx = 0.002;


[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('WNNM Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);


output = ReadSegy('result_of_RPCA.sgy');
cancha = ReadSegy('residual_of_RPCA.sgy');
load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace




dx = 0.002;



[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('RPCA Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);






output = ReadSegy('result_of_UNet.sgy');
cancha = ReadSegy('residual_of_UNet.sgy');
load('matrix.mat');
cancha = cancha .* matrix; % mask the missing trace

dx = 0.002;

[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('UNet Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);


output = ReadSegy('result_of_Transformer.sgy');
cancha = ReadSegy('residual_of_Transformer.sgy');
load('matrix.mat');
cancha = cancha .* matrix;

dx = 0.002;

[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Transformer Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);


output = ReadSegy('result_of_Diffusion.sgy');
cancha = ReadSegy('residual_of_Diffusion.sgy');
load('matrix.mat');
cancha = cancha .* matrix;

dx = 0.002;

[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Diffusion Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);



output = ReadSegy('result_of_SRDT.sgy');
cancha = ReadSegy('residual_of_SRDT.sgy');
load('matrix.mat');
cancha = cancha .* matrix;

dx = 0.002;

[S5, f5, k5] = fk(cancha, dx, 5, 9);
figure;
imagesc(k5, f5, S5);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('SRDT Residual');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);




