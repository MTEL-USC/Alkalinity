% Supplementary Figure: boundary conditions 
% CaCO3 export maps; burial (pelagic, neritic); river
% Row 1: Four maps a) P uptake; b) C:P; c) PIC:POC; d) total CaCO3 export
% Row 2: Four maps e) river; f) pelagic burial; g) coastal burial; h) total burial

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
papersize = [80 50];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

subplot(2,4,1)
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,P_UP_WJ18(:,:,1).*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'clim',[0 10],'fontsize',15);
title('P uptake')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); title(c,'\mumol kg^{-1} yr^{-1}');
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

subplot(2,4,2)
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,CtoP(:,:,1).*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'fontsize',15);
title('C:P ratios')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); 
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

subplot(2,4,3)
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,PICPOC_TW(:,:,1).*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'fontsize',15);
title('PIC:POC ratios')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); 
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

subplot(2,4,4)
CaCO3export = P_UP_WJ18.*CtoP.*PICPOC_TW./1.026;
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,CaCO3export(:,:,1).*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'clim',[0 100],'fontsize',15);
title('CaCO_3 export')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); title(c,'\mumol CaCO_3 kg^{-1} yr^{-1}');
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

% river (Unit: umol ALK kg-1 yr-1)
load ../data/RIVER
subplot(2,4,5)
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,RIVER(:,:,1).*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'clim',[0 80],'fontsize',15);
title('River (unadjusted)')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); title(c,'\mumol ALK kg^{-1} yr^{-1}');
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

load ../data/burial/BUR
indbtm = find(ao.BTM>0); % final bottom grids
buro_map = squeeze(nansum(BURo,3)); % open ocean burial
burc_map = squeeze(nansum(BURc,3)); % coastal ocean burial
bur_map = squeeze(nansum(BUR,3)); % total burial

% pelagic burial
subplot(2,4,6)
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,buro_map.*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'clim',[0 5],'fontsize',15);
title('Pelagic burial')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); title(c,'\mumol ALK kg^{-1} yr^{-1}');
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

% coastal burial
subplot(2,4,7)
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,burc_map.*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'clim',[0 5],'fontsize',15);
title('Coastal burial')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); title(c,'\mumol ALK kg^{-1} yr^{-1}');
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

% total burial
subplot(2,4,8)
worldmap([-80 80],[1 359])
contourfm(ao.lat,ao.lon,bur_map.*SURFACE,120,'LineStyle','none'); hold on;
set(gca,'clim',[0 5],'fontsize',15);
title('Total burial')
setm(gca,'MapProjection','miller','MLabelParallel','south','FontSize',15)
geoshow('landareas.shp','FaceColor', [0.7 0.7 0.7]); hold on;
c=colorbar;  cmocean('-matter'); title(c,'\mumol ALK kg^{-1} yr^{-1}');
setm(gca,'MLabelLocation',90,'PLabelLocation',45);

%pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
