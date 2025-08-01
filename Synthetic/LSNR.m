
pure=ReadSegy('clean.sgy');
kk=output;
I=kk;
In=pure;
heng=size(I,1);
zong=size(I,2);
snrs=[];
bc=4;%bc��0Ϊ˲ʱ����ȼ��㣬bcΪ4��ʾ����Ϊ5�ľֲ������
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