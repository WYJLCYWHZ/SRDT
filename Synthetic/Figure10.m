output = ReadSegy('result_of_BPF.sgy');
cancha = ReadSegy('residual_of_BPF.sgy');


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
% -----------------------------------------------
output = ReadSegy('result_of_VMD.segy');


% load('matrix.mat');
% cancha = cancha .* matrix;% mask the missing trace

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


output = ReadSegy('result_of_WNNM.sgy');
cancha = ReadSegy('residual_of_WNNM.sgy');



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






output = ReadSegy('result_of_RPCA.sgy');

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



output = ReadSegy('result_of_UNet.sgy');

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


output = ReadSegy('result_of_Transformer.sgy');

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



output = ReadSegy('result_of_Diffusion.sgy');

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


output = ReadSegy('result_of_SRDT.sgy');

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