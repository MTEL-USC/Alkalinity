% Different methods to account for TA0 component
clear all; close all
load ../data/ao
load ../data/GLODAP/Sal
load ../data/Preformed/NO3_0
load ../data/Preformed/TAc_AO
load ../data/Preformed/TA0_carter
carter_regress = TA0_carter;
load ../data/Preformed/TA0_carterinterp
carter_interp = preformed;

AO0ATL = squeeze(TA0_AO(:,166,:)); AO0ATL(isnan(AO0ATL))=0; AO0ATL(find(~ao.OCN(:,166,:))) = NaN;
AO0PAC = squeeze(TA0_AO(:,100,:)); AO0PAC(isnan(AO0PAC))=0; AO0PAC(find(~ao.OCN(:,100,:))) = NaN;

CregressATL = squeeze(carter_regress(:,166,:)); CregressATL(isnan(CregressATL))=0; CregressATL(find(~ao.OCN(:,166,:))) = NaN;
CregressPAC = squeeze(carter_regress(:,100,:)); CregressPAC(isnan(CregressPAC))=0; CregressPAC(find(~ao.OCN(:,100,:))) = NaN;

CinterpATL = squeeze(carter_interp(:,166,:)); CinterpATL(isnan(CinterpATL))=0; CinterpATL(find(~ao.OCN(:,166,:))) = NaN;
CinterpPAC = squeeze(carter_interp(:,100,:)); CinterpPAC(isnan(CinterpPAC))=0; CinterpPAC(find(~ao.OCN(:,100,:))) = NaN;

SATL = squeeze(Sal(:,166,:)); SATL(isnan(SATL))=0; SATL(find(~ao.OCN(:,166,:))) = NaN;
SPAC = squeeze(Sal(:,100,:)); SPAC(isnan(SPAC))=0; SPAC(find(~ao.OCN(:,100,:))) = NaN;

NATL = squeeze(NO30_AO(:,166,:)); NATL(isnan(NATL))=0; NATL(find(~ao.OCN(:,166,:))) = NaN;
NPAC = squeeze(NO30_AO(:,100,:)); NPAC(isnan(NPAC))=0; NPAC(find(~ao.OCN(:,100,:))) = NaN;

% plot options
addpath otherFUN
addpath cmocean

%  opt3 for difference
opt3.grid.yt = ao.lat ;
opt3.grid.zt = ao.depth ;
opt3.grid.dzt = ao.height ;
opt3.clevs = -75:15:75 ;
opt3.dash_clevs = [];%-75:15:75 ;
opt3.yTicks = [] ;
opt3.yTickLabels = [] ;
opt3.xTicks = [-89 -45 0 45 89];
opt3.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt3.ylabel = [] ;
opt3.xlabel = [];
opt3.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt3.grid.yv = ao.lat + opt3.grid.dyt / 2 ;
opt3.grid.dzt = ao.height ;
opt3.grid.zw = ao.depth - ao.height / 2;

firstATL = 66.4*SATL-1.26*NATL - AO0ATL; firstPAC = 66.4*SPAC-1.26*NPAC - AO0PAC;
secondATL = 66.4*SATL - AO0ATL; secondPAC = 66.4*SPAC - AO0PAC;
thirdATL = CregressATL - AO0ATL; thirdPAC = CregressPAC - AO0PAC;
fourthATL = CinterpATL - AO0ATL; fourthPAC = CinterpPAC - AO0PAC;

figure(1)
papersize = [30 30];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

% 1
subplot('position', [0.1, 0.74, 0.35, 0.15])
h=yzplot(firstATL', opt3) ;
cmocean('balance'); xlim([-89 89])
set(gca,'xdir','reverse','FontSize',20,'CLim',[-75 75]);
text(85,-5500,'ATL','FontSize',19); 
ylabel('Depth (km)'); %title('66.4×S - 1.26×[NO_3]_0');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position',[0.45, 0.74, 0.39, 0.15])
yzplot(firstPAC', opt3); xlim([-89 89])
colorbar; cmocean('balance')
text(58,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-75 75]);set(gca,'box','off')

% 2
subplot('position', [0.1, 0.51, 0.35, 0.15])
h=yzplot(secondATL', opt3); xlim([-89 89])
cmocean('balance');
set(gca,'xdir','reverse','FontSize',20,'CLim',[-75 75]);
text(85,-5500,'ATL','FontSize',19);
ylabel('Depth (km)'); %title('66.4×S');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position',[0.45, 0.51, 0.39, 0.15])
yzplot(secondPAC', opt3); xlim([-89 89])
colorbar; cmocean('balance')
text(58,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-75 75]);set(gca,'box','off')

%3
subplot('position', [0.1, 0.28, 0.35, 0.15])
h=yzplot(thirdATL', opt3); xlim([-89 89])
cmocean('balance');
set(gca,'xdir','reverse','FontSize',20,'CLim',[-75 75]);
text(85,-5500,'ATL','FontSize',19);
ylabel('Depth (km)'); %title('TA_0 Carter_{regression}');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position',[0.45, 0.28, 0.39, 0.15])
yzplot(thirdPAC', opt3); xlim([-89 89])
colorbar; cmocean('balance')
text(58,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-75 75]);set(gca,'box','off')

%4
subplot('position', [0.1, 0.05, 0.35, 0.15])
h=yzplot(fourthATL', opt3); xlim([-89 89])
cmocean('balance');
set(gca,'xdir','reverse','FontSize',20,'CLim',[-75 75]);
text(85,-5500,'ATL','FontSize',19);
ylabel('Depth (km)'); %title('TA_0 Carter_{interpolation}');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position',[0.45, 0.05, 0.39, 0.15])
yzplot(fourthPAC', opt3); xlim([-89 89])
colorbar; cmocean('balance')
text(58,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-75 75]);set(gca,'box','off')

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
