% Supplementary figure: sinking speed tests in the omega-dependent model
% 4 groups: 1, 10, 100, 1000 m d-1
% Plot TA0 and TA* transects

clear all; close all
load ../data/ao
load ../data/GLODAP/Sal
load ../data/Preformed/TAc_AO
addpath cmocean
TA0_AO(isnan(TA0_AO))=0; TA0_AO(find(~ao.OCN)) = NaN;
TAs_AO(isnan(TAs_AO))=0; TAs_AO(find(~ao.OCN)) = NaN;
obs_sPAC = squeeze(TAs_AO(:,100,:))';
obs_sATL = squeeze(TAs_AO(:,166,:))';
obs_0PAC = squeeze(TA0_AO(:,100,:))';
obs_0ATL = squeeze(TA0_AO(:,166,:))';

% Sinking speed represented by the number (e.g. s1 means when sinking speed = 1 m/d)
load ../output/Speed_M2_1
s1 = E.*Sal./35-E0; p1 = E0; % s = star(TA*); p = preformed (TA0)
s1(isnan(s1))=0;s1(find(~ao.OCN)) = NaN;
p1(isnan(p1))=0;p1(find(~ao.OCN)) = NaN;
diffs1PAC = squeeze(s1(:,100,:))' - obs_sPAC;
diffs1ATL = squeeze(s1(:,166,:))' - obs_sATL;
diffp1PAC = squeeze(p1(:,100,:))' - obs_0PAC;
diffp1ATL = squeeze(p1(:,166,:))' - obs_0ATL;

load ../output/Speed_M2_10
s10 = E.*Sal./35-E0; p10 = E0; 
s10(isnan(s10))=0;s10(find(~ao.OCN)) = NaN;
p10(isnan(p10))=0;p10(find(~ao.OCN)) = NaN;
diffs10PAC = squeeze(s10(:,100,:))' - obs_sPAC;
diffs10ATL = squeeze(s10(:,166,:))' - obs_sATL;
diffp10PAC = squeeze(p10(:,100,:))' - obs_0PAC;
diffp10ATL = squeeze(p10(:,166,:))' - obs_0ATL;

load ../output/Speed_M2_100
s100 = E.*Sal./35-E0; p100 = E0; 
s100(isnan(s100))=0;s100(find(~ao.OCN)) = NaN;
p100(isnan(p100))=0;p100(find(~ao.OCN)) = NaN;
diffs100PAC = squeeze(s100(:,100,:))' - obs_sPAC;
diffs100ATL = squeeze(s100(:,166,:))' - obs_sATL;
diffp100PAC = squeeze(p100(:,100,:))' - obs_0PAC;
diffp100ATL = squeeze(p100(:,166,:))' - obs_0ATL;

load ../output/Speed_M2_1000
s1000 = E.*Sal./35-E0; p1000 = E0; 
s1000(isnan(s1000))=0;s1000(find(~ao.OCN)) = NaN;
p1000(isnan(p1000))=0;p1000(find(~ao.OCN)) = NaN;
diffs1000PAC = squeeze(s1000(:,100,:))' - obs_sPAC;
diffs1000ATL = squeeze(s1000(:,166,:))' - obs_sATL;
diffp1000PAC = squeeze(p1000(:,100,:))' - obs_0PAC;
diffp1000ATL = squeeze(p1000(:,166,:))' - obs_0ATL;

% plot options
addpath otherFUN

%  opt for difference
opt.grid.yt = ao.lat ;
opt.grid.zt = ao.depth ;
opt.grid.dzt = ao.height ;
opt.clevs = -100:10:100 ;
opt.dash_clevs = []; 
opt.yTicks = []; 
opt.yTickLabels = [];
opt.xTicks = -90:90:90;
opt.xTickLabels = {'SP';'EQ';'NP'} ;
opt.ylabel = []; 
opt.xlabel = [];
opt.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt.grid.yv = ao.lat + opt.grid.dyt / 2 ;
opt.grid.dzt = ao.height ;
opt.grid.zw = ao.depth - ao.height / 2;

%%
figure(1)
papersize = [40 30];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

% TA0

% 1 m d-1
subplot('position', [0.1, 0.8, 0.19, 0.15])
yzplot(diffp1ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.29, 0.8, 0.19, 0.15])
yzplot(diffp1PAC, opt) ;
cmocean('balance'); 
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 10 m d-1
subplot('position', [0.1, 0.55, 0.19, 0.15])
yzplot(diffp10ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
ylabel('Depth (km)');
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.29, 0.55, 0.19, 0.15])
yzplot(diffp10PAC, opt) ;
cmocean('balance');
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 100 m d-1
subplot('position', [0.1, 0.3, 0.19, 0.15])
yzplot(diffp100ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
ylabel('Depth (km)');
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.29, 0.3, 0.19, 0.15])
yzplot(diffp100PAC, opt) ;
cmocean('balance'); 
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 1000 m d-1
subplot('position', [0.1, 0.05, 0.19, 0.15])
yzplot(diffp1000ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
ylabel('Depth (km)');
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.29, 0.05, 0.19, 0.15])
yzplot(diffp1000PAC, opt) ;
cmocean('balance');
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% TA*

% 1 m d-1
subplot('position', [0.52, 0.8, 0.19, 0.15])
yzplot(diffs1ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.71, 0.8, 0.23, 0.15])
yzplot(diffs1PAC, opt) ;
cmocean('balance'); colorbar
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 10 m d-1
subplot('position', [0.52, 0.55, 0.19, 0.15])
yzplot(diffs10ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.71, 0.55, 0.23, 0.15])
yzplot(diffs10PAC, opt) ;
cmocean('balance'); colorbar
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 100 m d-1
subplot('position', [0.52, 0.3, 0.19, 0.15])
yzplot(diffs100ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.71, 0.3, 0.23, 0.15])
yzplot(diffs100PAC, opt) ;
cmocean('balance'); colorbar
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 1000 m d-1
subplot('position', [0.52, 0.05, 0.19, 0.15])
yzplot(diffs1000ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse'); 
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.71, 0.05, 0.23, 0.15])
yzplot(diffs1000PAC, opt) ;
cmocean('balance'); colorbar
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
