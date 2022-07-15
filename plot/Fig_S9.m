% Supplementary figure: enedmember tests 
% 100 % calcite, GFDL calc:arag, 100% aragonite

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

% plot options
addpath otherFUN

%  opt3 for difference
opt3.grid.yt = ao.lat ;
opt3.grid.zt = ao.depth ;
opt3.grid.dzt = ao.height ;
opt3.clevs = -150:10:150 ;
opt3.dash_clevs = [];
opt3.yTicks = []; 
opt3.yTickLabels = [];
opt3.xTicks = [ao.lat(1) -45 0 45 ao.lat(91)];
opt3.xTickLabels = {'SP';'45°S';'EQ';'45°N';'NP'} ;
opt3.ylabel = []; 
opt3.xlabel = []; 
opt3.grid.dyt = (ao.lat(2) - ao.lat(1)) * ones(1,length(ao.lat)) ;
opt3.grid.yv = ao.lat + opt3.grid.dyt / 2 ;
opt3.grid.dzt = ao.height ;
opt3.grid.zw = ao.depth - ao.height / 2;

% Load model (Left: calcite; Middle: GFDL; Right: aragonite)

%% 
figure(1)
papersize = [75 60];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

% 1 (left 1)
load ../output/AllCalc_M2_Speed1
s1 = E.*Sal./35-E0; % s = star(TA*); 
s1(isnan(s1))=0;s1(find(~ao.OCN)) = NaN;
diffP1 = squeeze(s1(:,100,:))' - obs_sPAC;
diffA1 = squeeze(s1(:,166,:))' - obs_sATL;

subplot('position', [0.06, 0.8, 0.125, 0.18])
yzplot(diffA1, opt3);
cmocean('balance')
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)'); xlim([ao.lat(1) ao.lat(91)]);
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.185, 0.8, 0.16, 0.18])
yzplot(diffP1, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 2 (middle 1)
load ../output/Speed_M2_1 
s2 = E.*Sal./35-E0;  
s2(isnan(s2))=0;s2(find(~ao.OCN)) = NaN;
diffP2 = squeeze(s2(:,100,:))' - obs_sPAC;
diffA2 = squeeze(s2(:,166,:))' - obs_sATL;

subplot('position', [0.38, 0.8, 0.125, 0.18])
yzplot(diffA2, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.505, 0.8, 0.16, 0.18])
yzplot(diffP2, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 3 (right 1)
load ../output/AllArag_M2_Speed1 
s3 = E.*Sal./35-E0;  
s3(isnan(s3))=0;s3(find(~ao.OCN)) = NaN;
diffP3 = squeeze(s3(:,100,:))' - obs_sPAC;
diffA3 = squeeze(s3(:,166,:))' - obs_sATL;

subplot('position', [0.7, 0.8, 0.125, 0.18])
yzplot(diffA3, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.825, 0.8, 0.16, 0.18])
yzplot(diffP3, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 4 (left 2)
load ../output/AllCalc_M2_Speed10
s4 = E.*Sal./35-E0; 
s4(isnan(s4))=0;s4(find(~ao.OCN)) = NaN;
diffP4 = squeeze(s4(:,100,:))' - obs_sPAC;
diffA4 = squeeze(s4(:,166,:))' - obs_sATL;

subplot('position', [0.06, 0.55, 0.125, 0.18])
yzplot(diffA4, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.185, 0.55, 0.16, 0.18])
yzplot(diffP4, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 5 (middle 2)
load ../output/Speed_M2_10 
s5 = E.*Sal./35-E0;  
s5(isnan(s5))=0;s5(find(~ao.OCN)) = NaN;
diffP5 = squeeze(s5(:,100,:))' - obs_sPAC;
diffA5 = squeeze(s5(:,166,:))' - obs_sATL;

subplot('position', [0.38, 0.55, 0.125, 0.18])
yzplot(diffA5, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.505, 0.55, 0.16, 0.18])
yzplot(diffP5, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 6 (right 2)
load ../output/AllArag_M2_Speed10
s6 = E.*Sal./35-E0; 
s6(isnan(s6))=0;s6(find(~ao.OCN)) = NaN;
diffP6 = squeeze(s6(:,100,:))' - obs_sPAC;
diffA6 = squeeze(s6(:,166,:))' - obs_sATL;

subplot('position', [0.7, 0.55, 0.125, 0.18])
yzplot(diffA6, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.825, 0.55, 0.16, 0.18])
yzplot(diffP6, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 7 (left 3)
load ../output/AllCalc_M2_Speed100
s7 = E.*Sal./35-E0; 
s7(isnan(s7))=0;s7(find(~ao.OCN)) = NaN;
diffP7 = squeeze(s7(:,100,:))' - obs_sPAC;
diffA7 = squeeze(s7(:,166,:))' - obs_sATL;

subplot('position', [0.06, 0.3, 0.125, 0.18])
yzplot(diffA7, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.185, 0.3, 0.16, 0.18])
yzplot(diffP7, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 8 (middle 3)
load ../output/Speed_M2_100 
s8 = E.*Sal./35-E0;  
s8(isnan(s8))=0;s8(find(~ao.OCN)) = NaN;
diffP8 = squeeze(s8(:,100,:))' - obs_sPAC;
diffA8 = squeeze(s8(:,166,:))' - obs_sATL;

subplot('position', [0.38, 0.3, 0.125, 0.18])
yzplot(diffA8, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.505, 0.3, 0.16, 0.18])
yzplot(diffP8, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 9 (right 3)
load ../output/AllArag_M2_Speed100 
s9 = E.*Sal./35-E0;  
s9(isnan(s9))=0;s9(find(~ao.OCN)) = NaN;
diffP9 = squeeze(s9(:,100,:))' - obs_sPAC;
diffA9 = squeeze(s9(:,166,:))' - obs_sATL;

subplot('position', [0.7, 0.3, 0.125, 0.18])
yzplot(diffA9, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.825, 0.3, 0.16, 0.18])
yzplot(diffP9, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 10 (left 4)
load ../output/AllCalc_M2_Speed150 
s10 = E.*Sal./35-E0; 
s10(isnan(s10))=0;s10(find(~ao.OCN)) = NaN;
diffP10 = squeeze(s10(:,100,:))' - obs_sPAC;
diffA10 = squeeze(s10(:,166,:))' - obs_sATL;

subplot('position', [0.06, 0.05, 0.125, 0.18])
yzplot(diffA10, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.185, 0.05, 0.16, 0.18])
yzplot(diffP10, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 11 (middle 4)
load ../output/Speed_M2_150 
s11 = E.*Sal./35-E0;  
s11(isnan(s11))=0;s11(find(~ao.OCN)) = NaN;
diffP11 = squeeze(s11(:,100,:))' - obs_sPAC;
diffA11 = squeeze(s11(:,166,:))' - obs_sATL;

subplot('position', [0.38, 0.05, 0.125, 0.18])
yzplot(diffA11, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.505, 0.05, 0.16, 0.18])
yzplot(diffP11, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

% 12 (right 4)
load ../output/AllArag_M2_Speed150
s12 = E.*Sal./35-E0;  
s12(isnan(s12))=0;s12(find(~ao.OCN)) = NaN;
diffP12 = squeeze(s12(:,100,:))' - obs_sPAC;
diffA12 = squeeze(s12(:,166,:))' - obs_sATL;

subplot('position', [0.7, 0.05, 0.125, 0.18])
yzplot(diffA12, opt3);
cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
set(gca,'box','off','FontSize',18,'CLim',[-75 75],'xdir','reverse');
ylabel('Depth (km)');
text(85,-5500,'ATL','FontSize',18);
yticks([-6000 -5000 -4000 -3000 -2000 -1000 0]);
yticklabels({'6','5','4','3','2','1','0'}) ;

subplot('position', [0.825, 0.05, 0.16, 0.18])
yzplot(diffP12, opt3);
colorbar; cmocean('balance'); xlim([ao.lat(1) ao.lat(91)]);
text(60,-5500,'PAC','FontSize',18);
set(gca,'box','off','FontSize',18,'CLim',[-75 75])

%pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)

