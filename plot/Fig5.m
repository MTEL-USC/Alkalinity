% Fig. 5 CaCO3 dissolution 

clear all; close all
load ../data/ao
load ../data/GLODAP/OmegaC
load ../data/GLODAP/OmegaA
OC = OmegaC; OA = OmegaA;
OC(isnan(OmegaC))=0; OC(find(~ao.OCN)) = NaN; 
OCATL = squeeze(OC(:,166,:))'; OCPAC = squeeze(OC(:,100,:))';
OA(isnan(OmegaA))=0; OA(find(~ao.OCN)) = NaN;
OAATL = squeeze(OA(:,166,:))'; OAPAC = squeeze(OA(:,100,:))';

load ../data/burial/BUR
BUR(isnan(BUR))=0; % umol/kg/y

load ../output/Base_M1
t1 = op.seafloorOnly.reminb + op.seafloorOnly.sedreminb;
T1 = ao.nanOCN*0; T1(ao.iocn)=t1/2; % /2 : alkalinity to CaCO3
waterDiss1 = op.seafloorOnly.reminb;
sedDepo1 = op.seafloorOnly.sedreminb;

load ../output/Base_M2
c2 = op.kinetic_c.reminb + op.kinetic_c.sedreminb;
a2 = op.kinetic_a.reminb + op.kinetic_a.sedreminb;
t2 = c2+a2; T2 = ao.nanOCN*0; T2(ao.iocn)=t2/2;
waterDiss2 = op.kinetic_c.reminb + op.kinetic_a.reminb;
sedDepo2 = op.kinetic_c.sedreminb + op.kinetic_a.sedreminb;

load ../output/Base_M3
c3 = op.calc.reminb + op.calc.sedreminb; 
a3 = op.arag.reminb + op.arag.sedreminb; 
t3 = c3+a3; T3 = ao.nanOCN*0; T3(ao.iocn)=t3/2;
waterDiss3 = op.calc.reminb + op.arag.reminb;
sedDepo3 = op.calc.sedreminb + op.arag.sedreminb;

load ../output/Base_M4
t4 = op.constantKdiss.reminb + op.constantKdiss.sedreminb; 
T4 = ao.nanOCN*0; T4(ao.iocn)=t4/2;
waterDiss4 = op.constantKdiss.reminb;
sedDepo4 = op.constantKdiss.sedreminb;

PAC1 = squeeze(T1(:,100,:))'; ATL1 = squeeze(T1(:,166,:))';
PAC2 = squeeze(T2(:,100,:))'; ATL2 = squeeze(T2(:,166,:))';
PAC3 = squeeze(T3(:,100,:))'; ATL3 = squeeze(T3(:,166,:))';
PAC4 = squeeze(T4(:,100,:))'; ATL4 = squeeze(T4(:,166,:))';

opt.grid.yt = ao.lat;
opt.grid.zt = ao.depth ;
opt.grid.dzt = ao.height ;
opt.clevs = 0:0.01:0.8 ;
opt.dash_clevs = [];
opt.yTicks = []; 
opt.yTickLabels = []; 
opt.xTicks = -90:45:90;
opt.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt.ylabel = [];
opt.xlabel = []; 
opt.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt.grid.yv = ao.lat + opt.grid.dyt / 2 ;
opt.grid.dzt = ao.height ;
opt.grid.zw = ao.depth - ao.height / 2;

figure(1)
papersize = [45 30];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

addpath otherFUN
addpath cmocean
% Model 1
subplot('position', [0.1, 0.76, 0.23, 0.2])
h=yzplot(ATL1, opt) ;
cmocean('deep');
set(gca,'xdir','reverse');
text(85,-5500,'ATL','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6])
ylabel('Depth (km)');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')
contour(ao.lat,-ao.depth,OAATL,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCATL,[1 1],'k','LineWidth',2);

subplot('position',[0.33, 0.76, 0.27, 0.2])
yzplot(PAC1, opt) ;
colorbar; cmocean('deep');
text(65,-5500,'PAC','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6]);set(gca,'box','off')
contour(ao.lat,-ao.depth,OAPAC,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCPAC,[1 1],'k','LineWidth',2);

% Model 2
subplot('position', [0.1, 0.52, 0.23, 0.2])
h=yzplot(ATL2, opt) ;
cmocean('deep');
set(gca,'xdir','reverse');
text(85,-5500,'ATL','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6])
ylabel('Depth (km)');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')
contour(ao.lat,-ao.depth,OAATL,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCATL,[1 1],'k','LineWidth',2);

subplot('position',[0.33, 0.52, 0.27, 0.2])
yzplot(PAC2, opt) ;
colorbar; cmocean('deep');
text(65,-5500,'PAC','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6]);set(gca,'box','off')
contour(ao.lat,-ao.depth,OAPAC,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCPAC,[1 1],'k','LineWidth',2);

% Model 3
subplot('position', [0.1, 0.28, 0.23, 0.2])
h=yzplot(ATL3, opt) ;
cmocean('deep');
set(gca,'xdir','reverse');
text(85,-5500,'ATL','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6])
ylabel('Depth (km)');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off');
contour(ao.lat,-ao.depth,OAATL,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCATL,[1 1],'k','LineWidth',2);

subplot('position',[0.33, 0.28, 0.27, 0.2])
yzplot(PAC3, opt) ;
colorbar; cmocean('deep');
text(65,-5500,'PAC','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6]);set(gca,'box','off')
contour(ao.lat,-ao.depth,OAPAC,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCPAC,[1 1],'k','LineWidth',2);

% Model 4
subplot('position', [0.1, 0.04, 0.23, 0.2])
h=yzplot(ATL4, opt) ;
cmocean('deep');
set(gca,'xdir','reverse');
text(85,-5500,'ATL','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6])
ylabel('Depth (km)');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')
contour(ao.lat,-ao.depth,OAATL,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCATL,[1 1],'k','LineWidth',2);

subplot('position',[0.33, 0.04, 0.27, 0.2])
yzplot(PAC4, opt) ;
colorbar; cmocean('deep');
text(65,-5500,'PAC','FontSize',16);
set(gca,'FontSize',16,'CLim',[0 0.6]);set(gca,'box','off')
contour(ao.lat,-ao.depth,OAPAC,[1 1],'k--','LineWidth',2); hold on
contour(ao.lat,-ao.depth,OCPAC,[1 1],'k','LineWidth',2);

%% vertical profiles
% Unit from umol/kg/y to mol/m/y
AREA = ao.VOL./ao.HEIGHT; CONVERTER = 1e-6 * 1026 *AREA/2; % mol/kg/y * 1026 kg/m3 * m2 ; alkalinity/2 --> CaCO3

% Model 1
WATERDISS1 = ao.OCN*0; WATERDISS1(ao.iocn)=waterDiss1; 
DATAMASK=ao.OCN; DATAMASK(isnan(WATERDISS1))=NaN;
SEDDEPO1 = ao.OCN*0; SEDDEPO1(ao.iocn)=sedDepo1; 
SEDDISS1 = SEDDEPO1 - BUR; 

% Unit from umol/kg/y to mol/m/y
WATERDISS1 = WATERDISS1.*CONVERTER; SEDDISS1 = SEDDISS1.*CONVERTER;

ATLw1 = squeeze(nansum(nansum(WATERDISS1.*ao.OCN)));
ATLsed1 = squeeze(nansum(nansum(SEDDISS1.*ao.OCN)));

subplot('position', [0.65, 0.76, 0.18, 0.18])
d = ao.depth/1000; ATLw1(1:2)=NaN; 
plot(ATLw1/1e9,d,'k','LineWidth',2); hold on;
plot(ATLsed1/1e9,d,'r','LineWidth',2); hold on;

set(gca,'Ydir','reverse','xaxisLocation','top','FontSize',16); 
ylim([0 5200]/1000);xlim([-5 40])
xlabel('Dissolution (Gmol m^{-1} y^{-1})'); 
legend({'Water column','Benthic'},'Location','northeast');

% Model 2
WATERDISS2 = ao.OCN*0; WATERDISS2(ao.iocn)=waterDiss2; 
SEDDEPO2 = ao.OCN*0; SEDDEPO2(ao.iocn)=sedDepo2; 
SEDDISS2 = SEDDEPO2 - BUR; 

% Unit from umol/kg/y to mol/m/y
WATERDISS2 = WATERDISS2.*CONVERTER; SEDDISS2 = SEDDISS2.*CONVERTER;

ATLw2 = squeeze(nansum(nansum(WATERDISS2.*ao.OCN)));
ATLsed2 = squeeze(nansum(nansum(SEDDISS2.*ao.OCN)));

subplot('position', [0.65, 0.52, 0.18, 0.18])
d = ao.depth/1000; ATLw2(1:2)=NaN; 
plot(ATLw2/1e9,d,'k','LineWidth',2); hold on;
plot(ATLsed2/1e9,d,'r','LineWidth',2); hold on;

set(gca,'Ydir','reverse','xaxisLocation','top','FontSize',16); 
ylim([0 5200]/1000);xlim([-5 40])

% Model 3
WATERDISS3 = ao.OCN*0; WATERDISS3(ao.iocn)=waterDiss3; 
SEDDEPO3 = ao.OCN*0; SEDDEPO3(ao.iocn)=sedDepo3; 
SEDDISS3 = SEDDEPO3 - BUR;

WATERDISS3 = WATERDISS3.*CONVERTER; SEDDISS3 = SEDDISS3.*CONVERTER;

ATLw3 = squeeze(nansum(nansum(WATERDISS3.*ao.OCN)));
ATLsed3 = squeeze(nansum(nansum(SEDDISS3.*ao.OCN)));

subplot('position', [0.65, 0.28, 0.18, 0.18])
d = ao.depth/1000; ATLw3(1:2)=NaN; 
plot(ATLw3/1e9,d,'k','LineWidth',2); hold on;
plot(ATLsed3/1e9,d,'r','LineWidth',2); hold on;

set(gca,'Ydir','reverse','xaxisLocation','top','FontSize',16); 
ylim([0 5200]/1000);
xlim([-5 40])

% Model 4
WATERDISS4 = ao.OCN*0; WATERDISS4(ao.iocn)=waterDiss4; 
SEDDEPO4 = ao.OCN*0; SEDDEPO4(ao.iocn)=sedDepo4; 
SEDDISS4 = SEDDEPO4 - BUR; 

% Unit from umol/kg/y to mol/m/y
WATERDISS4 = WATERDISS4.*CONVERTER; SEDDISS4 = SEDDISS4.*CONVERTER;

ATLw4 = squeeze(nansum(nansum(WATERDISS4.*ao.OCN)));
ATLsed4 = squeeze(nansum(nansum(SEDDISS4.*ao.OCN)));

subplot('position', [0.65, 0.04, 0.18, 0.18])
d = ao.depth/1000; ATLw4(1:2)=NaN; 
plot(ATLw4/1e9,d,'k','LineWidth',2); hold on;
plot(ATLsed4/1e9,d,'r','LineWidth',2); hold on;

set(gca,'Ydir','reverse','xaxisLocation','top','FontSize',16); 
ylim([0 5200]/1000);
xlim([-5 40])

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
