close all
clc
clear 
data=ReadSegy('clean.sgy');
figure;imagesc(data);
xlabel('Trace'); ylabel('Time (ms)'); 
set(gca,'xticklabel',(get(gca,'xtick').*1))
set(gca,'yticklabel',(get(gca,'ytick').*0.20))
title('Theoretical Seismic Data')
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap("gray")
caxis([-0.1,0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20); 



noisy=ReadSegy('noisy.sgy');
figure;imagesc(noisy);
xlabel('Trace'); ylabel('Time (ms)'); 
set(gca,'xticklabel',(get(gca,'xtick').*1))
set(gca,'yticklabel',(get(gca,'ytick').*0.20))
title('Noisy Seismic Data')
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap("gray")
caxis([-0.1,0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20);


load('matrix.mat')
degraded=noisy.*matrix;


figure;imagesc(degraded);
xlabel('Trace'); ylabel('Time (ms)'); 
set(gca,'xticklabel',(get(gca,'xtick').*1))
set(gca,'yticklabel',(get(gca,'ytick').*0.20))
title('Degraded Seismic Data')
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
colormap("gray")
caxis([-0.1,0.1]);
xticklabels({'50', '100', '150', '200', '250'});
yticklabels({'1000', '2000', '3000', '4000'});
h = colorbar;
set(h, 'FontSize', 20); 

 


dx=0.002;
[S1,f1,k1] = fk(data,dx,5,9);                            
figure,imagesc(k1,f1,S1);axis([-0.1 0.1 0 100]);xlabel('Wavenumber(c/m)');ylabel('Frequency(Hz)');colorbar;caxis([1,3000]);set(gca,'YDir','normal');title('Theoretical Seismic Data')
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);

[S2,f2,k2] = fk(noisy,dx,5,9);                             
figure,imagesc(k2,f2,S2);axis([-0.1 0.1 0 100]);xlabel('Wavenumber(c/m)');ylabel('Frequency(Hz)');colorbar;caxis([1,3000]);set(gca,'YDir','normal');title('Noisy Seismic Data')
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);

[S3,f3,k3] = fk(degraded,dx,5,9);                            
figure,imagesc(k3,f3,S3);axis([-0.1 0.1 0 100]);xlabel('Wavenumber(c/m)');ylabel('Frequency(Hz)');colorbar;caxis([1,3000]);set(gca,'YDir','normal');title('Degraded Seismic Data')
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);