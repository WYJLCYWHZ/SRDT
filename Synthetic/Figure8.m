output = ReadSegy('result_of_BPF.sgy');
cancha = ReadSegy('residual_of_BPF.sgy');


load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace


dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of BPF');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);

% % ----------------------------------------------
output = ReadSegy('result_of_VMD.segy');
cancha = ReadSegy('residual_of_VMD.segy');


load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace

dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of VMD');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);


output = ReadSegy('result_of_WNNM.sgy');
cancha = ReadSegy('residual_of_WNNM.sgy');





dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of WNNM');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);



output = ReadSegy('result_of_RPCA.sgy');
cancha = ReadSegy('residual_of_RPCA.sgy');
load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace



dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of RPCA');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);





output = ReadSegy('result_of_UNet.sgy');
cancha = ReadSegy('residual_of_UNet.sgy');
load('matrix.mat');
cancha = cancha .* matrix; % mask the missing trace

dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of UNet');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);



output = ReadSegy('result_of_Transformer.sgy');
cancha = ReadSegy('residual_of_Transformer.sgy');
load('matrix.mat');
cancha = cancha .* matrix;

dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of Transformer');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);




output = ReadSegy('result_of_Diffusion.sgy');
cancha = ReadSegy('residual_of_Diffusion.sgy');
load('matrix.mat');
cancha = cancha .* matrix;

dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of Diffusion');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);




output = ReadSegy('result_of_SRDT.sgy');
cancha = ReadSegy('residual_of_SRDT.sgy');
load('matrix.mat');
cancha = cancha .* matrix;

dx = 0.002;

[S4, f4, k4] = fk(output, dx, 5, 9);
figure;
imagesc(k4, f4, S4);
axis([-0.1 0.1 0 100]);
xlabel('Wavenumber (c/m)');
ylabel('Frequency (Hz)');
colorbar;
caxis([1, 3000]);
set(gca, 'YDir', 'normal');
title('Result of SRDT');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);








