% Full transects plots of TA0 and TA*
% Full: both Atlantic and Pacific in one figure

clear all; close all
load ../data/ao
load ../data/GLODAP/Sal
load ../data/Preformed/TAc_AO
addpath cmocean

load ../output/Base_M3
modelEs = E.*Sal./35-E0; modelE0 = E0;
modelE0(isnan(modelE0))=0;modelE0(find(~ao.OCN)) = NaN;
modelEs(isnan(modelEs))=0;modelEs(find(~ao.OCN)) = NaN;
TA0_AO(isnan(TA0_AO))=0; TA0_AO(find(~ao.OCN)) = NaN;
TAs_AO(isnan(TAs_AO))=0; TAs_AO(find(~ao.OCN)) = NaN;

model_sPAC = squeeze(modelEs(:,100,:))';
model_sATL = squeeze(modelEs(:,166,:))';

model_0PAC = squeeze(modelE0(:,100,:))';
model_0ATL = squeeze(modelE0(:,166,:))';

obs_sPAC = squeeze(TAs_AO(:,100,:))';
obs_sATL = squeeze(TAs_AO(:,166,:))';

obs_0PAC = squeeze(TA0_AO(:,100,:))';
obs_0ATL = squeeze(TA0_AO(:,166,:))';

diff_sPAC = model_sPAC - obs_sPAC;
diff_sATL = model_sATL - obs_sATL;
diff_0PAC = model_0PAC - obs_0PAC;
diff_0ATL = model_0ATL - obs_0ATL;

% plot options
addpath otherFUN

%  opt for TA*
opt.grid.yt = ao.lat;
opt.grid.zt = ao.depth ;
opt.grid.dzt = ao.height ;
opt.clevs = -50:10:150 ;
opt.dash_clevs = -50:50:150 ;
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

%  opt2 for TA0
opt2.grid.yt = ao.lat ;
opt2.grid.zt = ao.depth ;
opt2.grid.dzt = ao.height ;
opt2.clevs = 2200:10:2400 ;
opt2.dash_clevs = 2200:50:2400 ;
opt2.yTicks = []; 
opt2.yTickLabels = [];
opt2.xTicks = -90:45:90;
opt2.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt2.ylabel = []; 
opt2.xlabel = [];
opt2.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt2.grid.yv = ao.lat + opt2.grid.dyt / 2 ;
opt2.grid.dzt = ao.height ;
opt2.grid.zw = ao.depth - ao.height / 2;

%  opt3 for difference
opt3.grid.yt = ao.lat ;
opt3.grid.zt = ao.depth ;
opt3.grid.dzt = ao.height ;
opt3.clevs = -75:10:75 ; 
opt3.dash_clevs = [];
opt3.yTicks = []; 
opt3.yTickLabels = [];
opt3.xTicks = -90:45:90;
opt3.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt3.ylabel = []; 
opt3.xlabel = []; 
opt3.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt3.grid.yv = ao.lat + opt3.grid.dyt / 2 ;
opt3.grid.dzt = ao.height ;
opt3.grid.zw = ao.depth - ao.height / 2;

%%
figure(1)
papersize = [60 30];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

% TA0_obs
subplot('position', [0.05, 0.7, 0.16, 0.2])
h=yzplot(obs_0ATL, opt2) ; hold on
cmocean('-deep')
set(gca,'FontSize',20,'CLim',[2200 2400],'xdir','reverse');
text(85,-5500,'ATL','FontSize',19);
ylabel('Depth (km)');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position',[0.21, 0.7, 0.19, 0.2])
yzplot(obs_0PAC, opt2) ;
colorbar; cmocean('deep')
text(60,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[2200 2400]);set(gca,'box','off')

% TA*_obs
subplot('position', [0.55, 0.7, 0.16, 0.2])
yzplot(obs_sATL, opt) ;
cmocean('deep')
set(gca,'xdir','reverse');
set(gca,'FontSize',20,'CLim',[-50 150])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',19);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.71, 0.7, 0.19, 0.2])
yzplot(obs_sPAC, opt) ;
colorbar; cmocean('deep')
text(60,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-50 150]);set(gca,'box','off')

% TA0_model
subplot('position', [0.05, 0.4, 0.16, 0.2])
yzplot(model_0ATL, opt2) ;
cmocean('deep')
set(gca,'xdir','reverse');
set(gca,'FontSize',20,'CLim',[2200 2400])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',19);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.21, 0.4, 0.19, 0.2])
yzplot(model_0PAC, opt2) ;
colorbar;cmocean('deep')
text(60,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[2200 2400]);set(gca,'box','off')

% TA*_model
subplot('position', [0.55, 0.4, 0.16, 0.2])
yzplot(model_sATL, opt) ;
cmocean('deep')
set(gca,'xdir','reverse');
set(gca,'FontSize',20,'CLim',[-50 150])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',19);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.71, 0.4, 0.19, 0.2])
yzplot(model_sPAC, opt) ;
colorbar; cmocean('deep')
text(60,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-50 150]);set(gca,'box','off')

% diff TA0
subplot('position', [0.05, 0.1, 0.16, 0.2])
yzplot(diff_0ATL, opt3) ;
cmocean('balance')
set(gca,'xdir','reverse');
set(gca,'FontSize',20,'CLim',[-70 70])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',19);
xlabel('Latitude(°)');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.21, 0.1, 0.19, 0.2])
yzplot(diff_0PAC, opt3) ;
colorbar; cmocean('balance')
text(60,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-70 70])
xlabel('Latitude(°)');set(gca,'box','off')

% diff TA*
subplot('position', [0.55, 0.1, 0.16, 0.2])
yzplot(diff_sATL, opt3) ;
cmocean('balance')
set(gca,'FontSize',20,'CLim',[-70 70],'xdir','reverse');
xlabel('Latitude(°)');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',19);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.71, 0.1, 0.19, 0.2])
yzplot(diff_sPAC, opt3) ;
colorbar; cmocean('balance')
text(60,-5500,'PAC','FontSize',19);
set(gca,'FontSize',20,'CLim',[-70 70])
xlabel('Latitude(°)');set(gca,'box','off')

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
