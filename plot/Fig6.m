% Fig. 6 CaCO3 dissolution
clear all; close all
load ../data/ao

load ../output/Base_M2
c2 = op.kinetic_c.reminb;
a2 = op.kinetic_a.reminb;
C2 = ao.nanOCN*0; C2(ao.iocn)=c2/2;
A2 = ao.nanOCN*0; A2(ao.iocn)=a2/2;

load ../output/Base_M3
c3 = op.calc.reminb;
a3 = op.arag.reminb; 
C3 = ao.nanOCN*0; C3(ao.iocn)=c3/2;
A3 = ao.nanOCN*0; A3(ao.iocn)=a3/2;

DATAMASK=ao.OCN; DATAMASK(isnan(E))=NaN;

c2prof = squeeze(nansum(nansum(C2.*ao.VOL.*ao.OCN))./nansum(nansum(DATAMASK.*ao.VOL.*ao.OCN)));
a2prof = squeeze(nansum(nansum(A2.*ao.VOL.*ao.OCN))./nansum(nansum(DATAMASK.*ao.VOL.*ao.OCN)));
c3prof = squeeze(nansum(nansum(C3.*ao.VOL.*ao.OCN))./nansum(nansum(DATAMASK.*ao.VOL.*ao.OCN)));
a3prof = squeeze(nansum(nansum(A3.*ao.VOL.*ao.OCN))./nansum(nansum(DATAMASK.*ao.VOL.*ao.OCN)));

%%

c2prof(1:2)=NaN; c3prof(1:2)=NaN;  
a2prof(1:2)=NaN; a3prof(1:2)=NaN; 

figure(1)
papersize = [40 20];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

subplot(1,2,1)
plot(c2prof,ao.depth/1000,'Color','b','LineWidth',3); hold on
plot(a2prof,ao.depth/1000,'Color','r','LineWidth',3);

ylim([0 5]); yticks([0 2 4]); yticklabels({'0','2','4'})
legend({'calcite','aragonite'},'location','northeast')
xlabel('Dissolution (\mumol kg^{-1} y^{-1})');ylabel('Depth (km)');
set(gca,'ydir','reverse','FontSize',24,'LineWidth',2)
title('M2');
xlim([0 0.05])

subplot(1,2,2)
plot(c3prof,ao.depth/1000,'Color','b','LineWidth',3); hold on
plot(a3prof,ao.depth/1000,'Color','r','LineWidth',3);

ylim([0 5]); yticks([0 2 4]); yticklabels({'0','2','4'})
xlabel('Dissolution (\mumol kg^{-1} y^{-1})');
set(gca,'ydir','reverse','FontSize',24,'LineWidth',2)
title('M3');
xlim([0 0.05])

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
