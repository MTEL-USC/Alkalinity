% Full transects plots of TA0 and TA*
% Full: both Atlantic and Pacific in one figure
% Top down: obs, M1, M2, M3, M4

clear all; close all
load ../data/ao
load ../data/GLODAP/Sal
addpath cmocean

load ../data/Preformed/TAc_AO
TA0_AO(isnan(TA0_AO))=0; TA0_AO(find(~ao.OCN)) = NaN;
TAs_AO(isnan(TAs_AO))=0; TAs_AO(find(~ao.OCN)) = NaN;

obs_sPAC = squeeze(TAs_AO(:,100,:))'; obs_sATL = squeeze(TAs_AO(:,166,:))';
obs_0PAC = squeeze(TA0_AO(:,100,:))'; obs_0ATL = squeeze(TA0_AO(:,166,:))';

% Load model outputs
load ../output/Base_M1
E01 = E0; E01(isnan(E01))=0;E01(find(~ao.OCN)) = NaN; 
Es1 = E.*Sal./35-E0; Es1(isnan(Es1))=0;Es1(find(~ao.OCN)) = NaN;

load ../output/Base_M2
E02 = E0; E02(isnan(E02))=0;E02(find(~ao.OCN)) = NaN;
Es2 = E.*Sal./35-E0; Es2(isnan(Es2))=0;Es2(find(~ao.OCN)) = NaN;

load ../output/Base_M3
E03 = E0; E03(isnan(E03))=0;E03(find(~ao.OCN)) = NaN;
Es3 = E.*Sal./35-E0; Es3(isnan(Es3))=0;Es3(find(~ao.OCN)) = NaN;

load ../output/Base_M4
E04 = E0; E04(isnan(E04))=0;E04(find(~ao.OCN)) = NaN;
Es4 = E.*Sal./35-E0; Es4(isnan(Es4))=0;Es4(find(~ao.OCN)) = NaN;

PACs1 = squeeze(Es1(:,100,:))'; ATLs1 = squeeze(Es1(:,166,:))';
PAC01 = squeeze(E01(:,100,:))'; ATL01 = squeeze(E01(:,166,:))';
PACs2 = squeeze(Es2(:,100,:))'; ATLs2 = squeeze(Es2(:,166,:))';
PAC02 = squeeze(E02(:,100,:))'; ATL02 = squeeze(E02(:,166,:))';
PACs3 = squeeze(Es3(:,100,:))'; ATLs3 = squeeze(Es3(:,166,:))';
PAC03 = squeeze(E03(:,100,:))'; ATL03 = squeeze(E03(:,166,:))';
PACs4 = squeeze(Es4(:,100,:))'; ATLs4 = squeeze(Es4(:,166,:))';
PAC04 = squeeze(E04(:,100,:))'; ATL04 = squeeze(E04(:,166,:))';

% plot options
addpath otherFUN

%  opt for TA*
opt.grid.yt = ao.lat;
opt.grid.zt = ao.depth ;
opt.grid.dzt = ao.height ;
opt.clevs = -50:10:200 ;
opt.dash_clevs = -50:50:200 ;
opt.yTicks = []; %-6000:1000:0 ;
opt.yTickLabels = []; %cellstr(num2str((6:-1:0)')) ;
opt.xTicks = -90:45:90;
opt.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt.ylabel = []; %'Depth (km)' ;
opt.xlabel = []; %'Latitude(°)' ;
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
opt2.yTicks = []; %-6000:1000:0 ;
opt2.yTickLabels = []; %cellstr(num2str((6:-1:0)')) ;
opt2.xTicks = -90:45:90;
opt2.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt2.ylabel = []; %'Depth (km)';
opt2.xlabel = []; %'Latitude(°)' ;
opt2.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt2.grid.yv = ao.lat + opt2.grid.dyt / 2 ;
opt2.grid.dzt = ao.height ;
opt2.grid.zw = ao.depth - ao.height / 2;

%%
figure(1)
papersize = [50 50];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

% TA0_obs
subplot('position', [0.1, 0.84, 0.15, 0.15])
h=yzplot(obs_0ATL, opt2) ; hold on
cmocean('-deep');
set(gca,'FontSize',18,'CLim',[2200 2400],'xdir','reverse');
text(85,-5500,'ATL','FontSize',18);
ylabel('Depth (km)');
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position',[0.25, 0.84, 0.19, 0.15])
yzplot(obs_0PAC, opt2) ;
colorbar; cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[2200 2400]);set(gca,'box','off')

% TA*_obs
subplot('position', [0.6, 0.84, 0.15, 0.15])
yzplot(obs_sATL, opt) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[-50 200])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.75, 0.84, 0.19, 0.15])
yzplot(obs_sPAC, opt) ;
colorbar; cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-50 200]);set(gca,'box','off')

% TA0 M1
subplot('position', [0.1, 0.64, 0.15, 0.15])
yzplot(ATL01, opt2) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[2200 2400])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.25, 0.64, 0.19, 0.15])
yzplot(PAC01, opt2) ;
colorbar;cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[2200 2400]);set(gca,'box','off')

% TA* M1
subplot('position', [0.6, 0.64, 0.15, 0.15])
yzplot(ATLs1, opt) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[-50 200])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.75, 0.64, 0.19, 0.15])
yzplot(PACs1, opt) ;
colorbar; cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-50 200]);set(gca,'box','off')

% TA0 M2
subplot('position', [0.1, 0.44, 0.15, 0.15])
yzplot(ATL02, opt2) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[2200 2400])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.25, 0.44, 0.19, 0.15])
yzplot(PAC02, opt2) ;
colorbar;cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[2200 2400]);set(gca,'box','off')

% TA* M2
subplot('position', [0.6, 0.44, 0.15, 0.15])
yzplot(ATLs2, opt) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[-50 200])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.75, 0.44, 0.19, 0.15])
yzplot(PACs2, opt) ;
colorbar; cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-50 200]);set(gca,'box','off')

% TA0 M3
subplot('position', [0.1, 0.24, 0.15, 0.15])
yzplot(ATL03, opt2) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[2200 2400])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.25, 0.24, 0.19, 0.15])
yzplot(PAC03, opt2) ;
colorbar;cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[2200 2400]);set(gca,'box','off')

% TA* M3
subplot('position', [0.6, 0.24, 0.15, 0.15])
yzplot(ATLs3, opt) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[-50 200])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.75, 0.24, 0.19, 0.15])
yzplot(PACs3, opt) ;
colorbar; cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-50 200]);set(gca,'box','off')

% TA0 M4
subplot('position', [0.1, 0.04, 0.15, 0.15])
yzplot(ATL04, opt2) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[2200 2400])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.25, 0.04, 0.19, 0.15])
yzplot(PAC04, opt2) ;
colorbar;cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[2200 2400]);set(gca,'box','off')

% TA* M4
subplot('position', [0.6, 0.04, 0.15, 0.15])
yzplot(ATLs4, opt) ;
cmocean('-deep');
set(gca,'xdir','reverse');
set(gca,'FontSize',18,'CLim',[-50 200])
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]) ;
yticklabels({'6','5','4','3','2','1','0'}) ;
set(gca,'box','off')

subplot('position', [0.75, 0.04, 0.19, 0.15])
yzplot(PACs4, opt) ;
colorbar; cmocean('-deep');
text(52,-5500,'PAC','FontSize',18);
set(gca,'FontSize',18,'CLim',[-50 200]);set(gca,'box','off')

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
