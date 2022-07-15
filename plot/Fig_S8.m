% Supplementary figure: sinking speed tests of M3
% 3 groups: 50, 100, 200 m d-1
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
load ../output/Speed_M3_50
s50 = E.*Sal./35-E0; p50 = E0; % s = star(TA*); p = preformed (TA0)
s50(isnan(s50))=0;s50(find(~ao.OCN)) = NaN;
p50(isnan(p50))=0;p50(find(~ao.OCN)) = NaN;
diffs50PAC = squeeze(s50(:,100,:))' - obs_sPAC;
diffs50ATL = squeeze(s50(:,166,:))' - obs_sATL;
diffp50PAC = squeeze(p50(:,100,:))' - obs_0PAC;
diffp50ATL = squeeze(p50(:,166,:))' - obs_0ATL;

load ../output/Speed_M3_100
s100 = E.*Sal./35-E0; p100 = E0; 
s100(isnan(s100))=0;s100(find(~ao.OCN)) = NaN;
p100(isnan(p100))=0;p100(find(~ao.OCN)) = NaN;
diffs100PAC = squeeze(s100(:,100,:))' - obs_sPAC;
diffs100ATL = squeeze(s100(:,166,:))' - obs_sATL;
diffp100PAC = squeeze(p100(:,100,:))' - obs_0PAC;
diffp100ATL = squeeze(p100(:,166,:))' - obs_0ATL;

load ../output/Speed_M3_200
s200 = E.*Sal./35-E0; p200 = E0; 
s200(isnan(s200))=0;s200(find(~ao.OCN)) = NaN;
p200(isnan(p200))=0;p200(find(~ao.OCN)) = NaN;
diffs200PAC = squeeze(s200(:,100,:))' - obs_sPAC;
diffs200ATL = squeeze(s200(:,166,:))' - obs_sATL;
diffp200PAC = squeeze(p200(:,100,:))' - obs_0PAC;
diffp200ATL = squeeze(p200(:,166,:))' - obs_0ATL;

%  opt for difference
addpath otherFUN
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

figure(1)
papersize = [45 30];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

% TA0

% 50 m d-1
subplot('position', [0.1, 0.7, 0.17, 0.2])
yzplot(diffp50ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.27, 0.7, 0.17, 0.2])
yzplot(diffp50PAC, opt) ;
cmocean('balance'); 
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 100 m d-1
subplot('position', [0.1, 0.4, 0.17, 0.2])
yzplot(diffp100ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
ylabel('Depth (km)');
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.27, 0.4, 0.17, 0.2])
yzplot(diffp100PAC, opt) ;
cmocean('balance');
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 200 m d-1
subplot('position', [0.1, 0.1, 0.17, 0.2])
yzplot(diffp200ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
ylabel('Depth (km)');
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.27, 0.1, 0.17, 0.2])
yzplot(diffp200PAC, opt) ;
cmocean('balance'); 
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% TA*

% 50 m d-1
subplot('position', [0.5, 0.7, 0.17, 0.2])
yzplot(diffs50ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.67, 0.7, 0.2, 0.2])
yzplot(diffs50PAC, opt) ;
cmocean('balance'); colorbar
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 100 m d-1
subplot('position', [0.5, 0.4, 0.17, 0.2])
yzplot(diffs100ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);
yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.67, 0.4, 0.2, 0.2])
yzplot(diffs100PAC, opt) ;
cmocean('balance'); colorbar
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

% 200 m d-1
subplot('position', [0.5, 0.1, 0.17, 0.2])
yzplot(diffs200ATL, opt); cmocean('balance')
set(gca,'FontSize',15,'CLim',[-70 70],'xdir','reverse');
text(85,-5500,'ATL','FontSize',15);

yticks([-6000 -4000 -2000 0]);
yticklabels({'6','4','2','0'}) ;
set(gca,'box','off')

subplot('position', [0.67, 0.1, 0.2, 0.2])
yzplot(diffs200PAC, opt) ;
cmocean('balance'); colorbar
text(60,-5500,'PAC','FontSize',15);
set(gca,'FontSize',15,'CLim',[-70 70])
set(gca,'box','off')

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)
