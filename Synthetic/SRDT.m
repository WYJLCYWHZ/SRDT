output = ReadSegy('result_of_SRDT.sgy', output);
cancha = ReadSegy('residual_of_SRDT.sgy', cancha);

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

load('matrix.mat');
cancha = cancha .* matrix;% mask the missing trace

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



pure=ReadSegy('clean.sgy');
kk=output;
I=kk;
In=pure;
heng=size(I,1);
zong=size(I,2);
snrs=[];
bc=4;%bc是0为瞬时信噪比计算，bc为4表示步长为5的局部信噪比
for i=1:1:heng-bc
    for j=1:1:zong-bc

        snr=0;
        Ps=I(i:i+bc,j:j+bc);
        Pn=In(i:i+bc,j:j+bc);           
        snr=SNR_singlech(Pn,Ps);
        snrs(i,j)=snr;
    end
end


figure;imagesc(snrs,[-10,30]);
ylabel('Time(ms)');
xlabel('Trace Number');
set(gca,'xticklabel',(get(gca,'xtick').*1))
set(gca,'yticklabel',(get(gca,'ytick').*2))
colorbar;
colormap("hot")
caxis([-10,30]);
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);
xticklabels({'50', '100', '150', '200', '250'});
h = colorbar;
set(h, 'FontSize', 20);            