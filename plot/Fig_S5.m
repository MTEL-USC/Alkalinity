% Supplementary figure: low/mid/high export model comparisons
% obs, model, misfits
% For M3
clear all
load ../data/ao
load ../data/GLODAP/Sal
addpath cmocean

% Load observation
load ../data/Preformed/TAc_AO
TA0_AO(isnan(TA0_AO))=0; TA0_AO(find(~ao.OCN)) = NaN;
TAs_AO(isnan(TAs_AO))=0; TAs_AO(find(~ao.OCN)) = NaN;

obs_sPAC = squeeze(TAs_AO(:,100,:))'; obs_sATL = squeeze(TAs_AO(:,166,:))';
obs_0PAC = squeeze(TA0_AO(:,100,:))'; obs_0ATL = squeeze(TA0_AO(:,166,:))';

% Load model outputs
load ../output/export_M3_low.mat % low
E01 = E0; E01(isnan(E01))=0;E01(find(~ao.OCN)) = NaN; 
Es1 = E.*Sal./35-E0; Es1(isnan(Es1))=0;Es1(find(~ao.OCN)) = NaN;
diffs1 = Es1 - TAs_AO; diff01 = E01 - TA0_AO;

load ../output/export_M3_mid.mat % mid
E02 = E0; E02(isnan(E02))=0;E02(find(~ao.OCN)) = NaN; 
Es2 = E.*Sal./35-E0; Es2(isnan(Es2))=0;Es2(find(~ao.OCN)) = NaN;
diffs2 = Es2 - TAs_AO; diff02 = E02 - TA0_AO;

load ../output/export_M3_high.mat % high
E03 = E0; E03(isnan(E03))=0;E03(find(~ao.OCN)) = NaN; 
Es3 = E.*Sal./35-E0; Es3(isnan(Es3))=0;Es3(find(~ao.OCN)) = NaN;
diffs3 = Es3 - TAs_AO; diff03 = E03 - TA0_AO;

Ps1 = squeeze(Es1(:,100,:))'; As1 = squeeze(Es1(:,166,:))';
P01 = squeeze(E01(:,100,:))'; A01 = squeeze(E01(:,166,:))';
PACs1 = squeeze(diffs1(:,100,:))'; ATLs1 = squeeze(diffs1(:,166,:))';
PAC01 = squeeze(diff01(:,100,:))'; ATL01 = squeeze(diff01(:,166,:))';

Ps2 = squeeze(Es2(:,100,:))'; As2 = squeeze(Es2(:,166,:))';
P02 = squeeze(E02(:,100,:))'; A02 = squeeze(E02(:,166,:))';
PACs2 = squeeze(diffs2(:,100,:))'; ATLs2 = squeeze(diffs2(:,166,:))';
PAC02 = squeeze(diff02(:,100,:))'; ATL02 = squeeze(diff02(:,166,:))';

Ps3 = squeeze(Es3(:,100,:))'; As3 = squeeze(Es3(:,166,:))';
P03 = squeeze(E03(:,100,:))'; A03 = squeeze(E03(:,166,:))';
PACs3 = squeeze(diffs3(:,100,:))'; ATLs3 = squeeze(diffs3(:,166,:))';
PAC03 = squeeze(diff03(:,100,:))'; ATL03 = squeeze(diff03(:,166,:))';

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
opt.xTicks = [-89 -45 0 45 89];
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
opt2.xTicks = [-89 -45 0 45 89];
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
opt3.clevs = -90:10:90 ;
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

%%
figure(1)
papersize = [90 50];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

% Obs
subplot('position', [0.1, 0.8, 0.08, 0.18])
yzplot(obs_0ATL, opt2); cmocean('deep')
set(gca,'FontSize',18,'CLim',[2200 2400],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.18, 0.8, 0.1, 0.18])
yzplot(obs_0PAC, opt2) ;
cmocean('deep')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[2200 2400])
set(gca,'box','off')
colorbar

subplot('position', [0.54, 0.8, 0.08, 0.18])
yzplot(obs_sATL, opt); cmocean('deep')
set(gca,'FontSize',18,'CLim',[-50 150],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.62, 0.8, 0.1, 0.18])
yzplot(obs_sPAC, opt) ;
cmocean('deep'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-50 150])
set(gca,'box','off')
colorbar

%% Low
% TA0
subplot('position', [0.1, 0.55, 0.08, 0.18])
yzplot(A01, opt2); cmocean('deep')
set(gca,'FontSize',18,'CLim',[2200 2400],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.18, 0.55, 0.1, 0.18])
yzplot(P01, opt2) ;
cmocean('deep')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[2200 2400])
set(gca,'box','off')
colorbar

subplot('position', [0.32, 0.55, 0.08, 0.18])
yzplot(ATL01, opt3); cmocean('balance')
set(gca,'FontSize',18,'CLim',[-90 90],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.4, 0.55, 0.1, 0.18])
yzplot(PAC01, opt3) ;
cmocean('balance')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[-90 90])
set(gca,'box','off')
colorbar

% TA*
subplot('position', [0.54, 0.55, 0.08, 0.18])
yzplot(As1, opt); cmocean('deep')
set(gca,'FontSize',18,'CLim',[-50 150],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.62, 0.55, 0.1, 0.18])
yzplot(Ps1, opt) ;
cmocean('deep')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[-50 150])
set(gca,'box','off')
colorbar

subplot('position', [0.76, 0.55, 0.08, 0.18])
yzplot(ATLs1, opt3); cmocean('balance')
set(gca,'FontSize',18,'CLim',[-90 90],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.84, 0.55, 0.1, 0.18])
yzplot(PACs1, opt3) ;
cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-90 90])
set(gca,'box','off')
colorbar

%% Mid
% TA0
subplot('position', [0.1, 0.3, 0.08, 0.18])
yzplot(A02, opt2); cmocean('deep')
set(gca,'FontSize',18,'CLim',[2200 2400],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.18, 0.3, 0.1, 0.18])
yzplot(P02, opt2) ;
cmocean('deep')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[2200 2400])
set(gca,'box','off')
colorbar

subplot('position', [0.32, 0.3, 0.08, 0.18])
yzplot(ATL02, opt3); cmocean('balance')
set(gca,'FontSize',18,'CLim',[-90 90],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.4, 0.3, 0.1, 0.18])
yzplot(PAC02, opt3);
cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-90 90])
set(gca,'box','off')
colorbar

% TA*
subplot('position', [0.54, 0.3, 0.08, 0.18])
yzplot(As2, opt); cmocean('deep')
set(gca,'FontSize',18,'CLim',[-50 150],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.62, 0.3, 0.1, 0.18])
yzplot(Ps2, opt) ;
cmocean('deep')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[-50 150])
set(gca,'box','off')
colorbar

subplot('position', [0.76, 0.3, 0.08, 0.18])
yzplot(ATLs2, opt3); cmocean('balance')
set(gca,'FontSize',18,'CLim',[-90 90],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.84, 0.3, 0.1, 0.18])
yzplot(PACs2, opt3);
cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-90 90])
set(gca,'box','off')
colorbar

%% high
% TA0
subplot('position', [0.1, 0.05, 0.08, 0.18])
yzplot(A03, opt2); cmocean('deep')
set(gca,'FontSize',18,'CLim',[2200 2400],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.18, 0.05, 0.1, 0.18])
yzplot(P03, opt2) ;
cmocean('deep')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[2200 2400])
set(gca,'box','off')
colorbar

subplot('position', [0.32, 0.05, 0.08, 0.18])
yzplot(ATL03, opt3); cmocean('balance')
set(gca,'FontSize',18,'CLim',[-90 90],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.4, 0.05, 0.1, 0.18])
yzplot(PAC03, opt3);
cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-90 90])
set(gca,'box','off')
colorbar

% TA*
subplot('position', [0.54, 0.05, 0.08, 0.18])
yzplot(As3, opt); cmocean('deep')
set(gca,'FontSize',18,'CLim',[-50 150],'xdir','reverse');
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.62, 0.05, 0.1, 0.18])
yzplot(Ps3, opt) ;
cmocean('deep')
text(50,-5500,'PAC','FontSize',18); xlim([-89 89]);
set(gca,'FontSize',18,'CLim',[-50 150])
set(gca,'box','off')
colorbar

subplot('position', [0.76, 0.05, 0.08, 0.18])
yzplot(ATLs3, opt3); cmocean('balance')
set(gca,'FontSize',18,'CLim',[-90 90],'xdir','reverse'); 
ylabel('Depth (km)'); xlim([-89 89]);
text(82,-5500,'ATL','FontSize',18);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.84, 0.05, 0.1, 0.18])
yzplot(PACs3, opt3);
cmocean('balance'); xlim([-89 89]);
text(50,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-90 90])
set(gca,'box','off')
colorbar

%pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
