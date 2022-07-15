% Fig 4: TA0 and TA* error, with 1:1 plots aside

clear all; close all
load ../data/ao
load ../data/GLODAP/Sal
addpath cmocean
addpath cbrewer

% Load observation
load ../data/Preformed/TAc_AO
TA0_AO(isnan(TA0_AO))=0; TA0_AO(find(~ao.OCN)) = NaN;
TAs_AO(isnan(TAs_AO))=0; TAs_AO(find(~ao.OCN)) = NaN;

obs_sPAC = squeeze(TAs_AO(:,100,:))'; obs_sATL = squeeze(TAs_AO(:,166,:))';
obs_0PAC = squeeze(TA0_AO(:,100,:))'; obs_0ATL = squeeze(TA0_AO(:,166,:))';

os = TAs_AO(ao.iocn); o0 = TA0_AO(ao.iocn);

% Load model outputs
load ../output/Base_M1
E01 = E0; E01(isnan(E01))=0;E01(find(~ao.OCN)) = NaN; 
Es1 = E.*Sal./35-E0; Es1(isnan(Es1))=0;Es1(find(~ao.OCN)) = NaN;
e01 = E01(ao.iocn); es1 = Es1(ao.iocn);
diffs1 = Es1 - TAs_AO; diff01 = E01 - TA0_AO;
load ../output/Base_M2
E02 = E0; E02(isnan(E02))=0;E02(find(~ao.OCN)) = NaN;
Es2 = E.*Sal./35-E0; Es2(isnan(Es2))=0;Es2(find(~ao.OCN)) = NaN;
e02 = E02(ao.iocn); es2 = Es2(ao.iocn);
diffs2 = Es2 - TAs_AO; diff02 = E02 - TA0_AO;
load ../output/Base_M3
E03 = E0; E03(isnan(E03))=0;E03(find(~ao.OCN)) = NaN;
Es3 = E.*Sal./35-E0; Es3(isnan(Es3))=0;Es3(find(~ao.OCN)) = NaN;
e03 = E03(ao.iocn); es3 = Es3(ao.iocn);
diffs3 = Es3 - TAs_AO; diff03 = E03 - TA0_AO;
load ../output/Base_M4
E04 = E0; E04(isnan(E04))=0;E04(find(~ao.OCN)) = NaN;
Es4 = E.*Sal./35-E0; Es4(isnan(Es4))=0;Es4(find(~ao.OCN)) = NaN;
e04 = E04(ao.iocn); es4 = Es4(ao.iocn);
diffs4 = Es4 - TAs_AO; diff04 = E04 - TA0_AO;

PACs1 = squeeze(diffs1(:,100,:))'; ATLs1 = squeeze(diffs1(:,166,:))';
PAC01 = squeeze(diff01(:,100,:))'; ATL01 = squeeze(diff01(:,166,:))';
PACs2 = squeeze(diffs2(:,100,:))'; ATLs2 = squeeze(diffs2(:,166,:))';
PAC02 = squeeze(diff02(:,100,:))'; ATL02 = squeeze(diff02(:,166,:))';
PACs3 = squeeze(diffs3(:,100,:))'; ATLs3 = squeeze(diffs3(:,166,:))';
PAC03 = squeeze(diff03(:,100,:))'; ATL03 = squeeze(diff03(:,166,:))';
PACs4 = squeeze(diffs4(:,100,:))'; ATLs4 = squeeze(diffs4(:,166,:))';
PAC04 = squeeze(diff04(:,100,:))'; ATL04 = squeeze(diff04(:,166,:))';

% plot options
addpath otherFUN

%  opt3 for difference
opt3.grid.yt = ao.lat ;
opt3.grid.zt = ao.depth ;
opt3.grid.dzt = ao.height ;
opt3.clevs = -75:10:75 ;
opt3.dash_clevs = [];
opt3.yTicks = []; 
opt3.yTickLabels = [];
opt3.xTicks = [-89 -45 0 45 89];
opt3.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt3.ylabel = []; 
opt3.xlabel = []; 
opt3.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt3.grid.yv = ao.lat + opt3.grid.dyt / 2 ;
opt3.grid.dzt = ao.height ;
opt3.grid.zw = ao.depth - ao.height / 2;


%% Plot
figure(1)
papersize = [50 30];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);
CT = cbrewer('seq','YlOrBr',9); clevs = 0:5:100;

% Model 1

subplot('position', [0.36, 0.825, 0.12, 0.12])
jointPDF(o0, e01,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA_0'); ylabel('Model TA_0'); xlim([2250 2400]); ylim([2250 2400]);
c=colorbar;  title(c,'percentile'); colormap(CT);
set(gca,'FontSize',15,'Clim',[0 1])
line([2200 2450],[2200 2450],'Color','k','LineStyle','--','LineWidth',2);
text(2310,2265,'R^2=0.75','FontSize',15);

jpdf = subplot('position', [0.84, 0.825, 0.12, 0.12])
jointPDF(os, es1,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA^*'); ylabel('Model TA^*'); xlim([-50 225]); ylim([-50 225]);
c=colorbar;  title(c,'percentile'); colormap(CT)
set(gca,'FontSize',15,'Clim',[0 1])
line([-50 250],[-50 250],'Color','k','LineStyle','--','LineWidth',2);
text(65,-20,'R^2=0.68','FontSize',15);

% Model 2

jpdf = subplot('position', [0.36, 0.575, 0.12, 0.12])
jointPDF(o0, e02,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA_0'); ylabel('Model TA_0'); xlim([2250 2400]); ylim([2250 2400]);
c=colorbar;  title(c,'percentile'); colormap(CT)
set(gca,'FontSize',15,'Clim',[0 1])
line([2200 2450],[2200 2450],'Color','k','LineStyle','--','LineWidth',2);
text(2310,2265,'R^2=0.75','FontSize',15);

jpdf = subplot('position', [0.84, 0.575, 0.12, 0.12])
jointPDF(os, es2,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA^*'); ylabel('Model TA^*'); xlim([-50 225]); ylim([-50 225]);
c=colorbar;  title(c,'percentile'); colormap(CT)
set(gca,'FontSize',15,'Clim',[0 1])
line([-50 250],[-50 250],'Color','k','LineStyle','--','LineWidth',2);
text(65,-20,'R^2=0.71','FontSize',15);

% Model 3

jpdf = subplot('position', [0.36, 0.325, 0.12, 0.12])
jointPDF(o0, e03,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA_0'); ylabel('Model TA_0'); xlim([2250 2400]); ylim([2250 2400]);
c=colorbar;  title(c,'percentile'); colormap(CT)
set(gca,'FontSize',15,'Clim',[0 1])
line([2200 2450],[2200 2450],'Color','k','LineStyle','--','LineWidth',2);
text(2310,2265,'R^2=0.62','FontSize',15);

jpdf = subplot('position', [0.84, 0.325, 0.12, 0.12])
jointPDF(os, es3,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA^*'); ylabel('Model TA^*'); xlim([-50 225]); ylim([-50 225]);
c=colorbar;  title(c,'percentile'); colormap(CT)
set(gca,'FontSize',15,'Clim',[0 1])
line([-50 250],[-50 250],'Color','k','LineStyle','--','LineWidth',2);
text(65,-20,'R^2=0.87','FontSize',15);

% Model 4

jpdf = subplot('position', [0.36, 0.075, 0.12, 0.12])
jointPDF(o0, e04,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA_0'); ylabel('Model TA_0'); xlim([2250 2400]); ylim([2250 2400]);
c=colorbar;  title(c,'percentile'); colormap(CT)
set(gca,'FontSize',15,'Clim',[0 1])
line([2200 2450],[2200 2450],'Color','k','LineStyle','--','LineWidth',2);
text(2310,2265,'R^2=0.56','FontSize',15);

jpdf = subplot('position', [0.84, 0.075, 0.12, 0.12])
jointPDF(os, es4,ao.Vol,'clevs',clevs/100); hold on
axis square
xlabel('Obs TA^*'); ylabel('Model TA^*'); xlim([-50 225]); ylim([-50 225]);
c=colorbar;  title(c,'percentile'); colormap(CT)
set(gca,'FontSize',15,'Clim',[0 1])
line([-50 250],[-50 250],'Color','k','LineStyle','--','LineWidth',2);
text(65,-20,'R^2=0.88','FontSize',15);

%% Misfit

% Model 1
subplot('position', [0.05, 0.8, 0.11, 0.15])
yzplot(ATL01, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)'); xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.16, 0.8, 0.15, 0.15])
yzplot(PAC01, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

% diff TA*

subplot('position', [0.53, 0.8, 0.11, 0.15])
yzplot(ATLs1, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)'); xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.64, 0.8, 0.15, 0.15])
yzplot(PACs1, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

% Model 2

subplot('position', [0.05, 0.55, 0.11, 0.15])
yzplot(ATL02, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)'); xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.16, 0.55, 0.15, 0.15])
yzplot(PAC02, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

% diff TA*

subplot('position', [0.53, 0.55, 0.11, 0.15])
yzplot(ATLs2, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)');  xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.64, 0.55, 0.15, 0.15])
yzplot(PACs2, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

% Model 3
subplot('position', [0.05, 0.3, 0.11, 0.15])
yzplot(ATL03, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)'); xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.16, 0.3, 0.15, 0.15])
yzplot(PAC03, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

% diff TA*
subplot('position', [0.53, 0.3, 0.11, 0.15])
yzplot(ATLs3, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)'); xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.64, 0.3, 0.15, 0.15])
yzplot(PACs3, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

% Model 4
subplot('position', [0.05, 0.05, 0.11, 0.15])
yzplot(ATL04, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)'); xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.16, 0.05, 0.15, 0.15])
yzplot(PAC04, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

% diff TA*
subplot('position', [0.53, 0.05, 0.11, 0.15])
yzplot(ATLs4, opt3) ; hold on
cmocean('balance')
ylabel('Depth (km)'); xlim([-89 89]);
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]) ;
yticklabels({'6','4','2','0'}) ;
set(gca,'xdir','reverse','FontSize',15,'CLim',[-70 70],'box','off')

subplot('position', [0.64, 0.05, 0.15, 0.15])
yzplot(PACs4, opt3) ; hold on
colorbar; cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70],'box','off')

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)

