% Supplementary Figure: CaCO3 export maps
% Four maps: a) P uptake; b) C:P; c) PIC:POC; d) total CaCO3 export

clear all; close all;
% load data
addpath ../data
load ao
load P_UP
load PICPOC_TW
load CtoP_nitrate
addpath cmocean

SURFACE = ao.nanOCN(:,:,1);

figure(1)
papersize = [60 50];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

subplot(2,2,1)
pcolor(ao.lon,ao.lat,P_UP_WJ18(:,:,1).*SURFACE./1.026); shading flat;
title('P uptake')
xticks([1 90 180 270 359])
xticklabels({'0°','90°E','180°','90°W','0°'})
yticks([-89 -45 0 45 89])
yticklabels({'90°S','45°S','0°','45°N','90°N'})
c=colorbar; title(c,' \mumol kg^{-1} yr^{-1}');
set(gca,'CLim',[0 10],'FontSize',22);
cmocean('matter')

subplot(2,2,2)
pcolor(ao.lon,ao.lat,CtoP(:,:,1).*SURFACE); shading flat;
title('C:P ratios')
xticks([1 90 180 270 359])
xticklabels({'0°','90°E','180°','90°W','0°'})
yticks([-89 -45 0 45 89])
yticklabels({'90°S','45°S','0°','45°N','90°N'})
c=colorbar; 
set(gca,'FontSize',22);
cmocean('matter')

subplot(2,2,3)
pcolor(ao.lon,ao.lat,PICPOC_TW(:,:,1).*SURFACE); shading flat;
title('PIC:POC ratios')
xticks([1 90 180 270 359])
xticklabels({'0°','90°E','180°','90°W','0°'})
yticks([-89 -45 0 45 89])
yticklabels({'90°S','45°S','0°','45°N','90°N'})
c=colorbar; 
set(gca,'FontSize',22);
cmocean('matter')

subplot(2,2,4)
CaCO3export = P_UP_WJ18.*CtoP.*PICPOC_TW./1.026;
pcolor(ao.lon,ao.lat,CaCO3export(:,:,1).*SURFACE); shading flat;
title('CaCO_3 export')
xticks([1 90 180 270 359])
xticklabels({'0°','90°E','180°','90°W','0°'})
yticks([-89 -45 0 45 89])
yticklabels({'90°S','45°S','0°','45°N','90°N'})
c=colorbar; title(c,' \mumol kg^{-1} yr^{-1}');
set(gca,'CLim',[0 100],'FontSize',22);
cmocean('matter')

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
