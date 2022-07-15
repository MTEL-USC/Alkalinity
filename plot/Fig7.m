% Figure 7: 
% export converge to a similar value if the "export depth" is deeper than 73 m

clear all
load ../data/ao
depth = ao.depth(2:9)+ao.height(2:9)/2;

% Constant model (mid)
load ../output/export_M4_mid
prod1 = ao.Vol' * op.constantKdiss.prodb * 1026*6/1e21; % 73 m
REMIN1 = ao.OCN*0; REMIN1(ao.iocn)=op.constantKdiss.reminb;
SEDREMIN1 = ao.OCN*0; SEDREMIN1(ao.iocn)=op.constantKdiss.sedreminb - op.external.burialb;

% Layer 3 to 9
REMIN1_3 = REMIN1; REMIN1_3(:,:,4:24)=0; 
remin1_3 = ao.Vol' * REMIN1_3(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN1_3 = SEDREMIN1; SEDREMIN1_3(:,:,4:24)=0; 
sedremin1_3 = ao.Vol' * SEDREMIN1_3(ao.iocn) * 1026*6/1e21; % water dissolution
export1_3 = prod1 - remin1_3 - sedremin1_3;

REMIN1_4 = REMIN1; REMIN1_4(:,:,5:24)=0; 
remin1_4 = ao.Vol' * REMIN1_4(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN1_4 = SEDREMIN1; SEDREMIN1_4(:,:,5:24)=0; 
sedremin1_4 = ao.Vol' * SEDREMIN1_4(ao.iocn) * 1026*6/1e21; % water dissolution
export1_4 = prod1 - remin1_4 - sedremin1_4;

REMIN1_5 = REMIN1; REMIN1_5(:,:,6:24)=0; 
remin1_5 = ao.Vol' * REMIN1_5(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN1_5 = SEDREMIN1; SEDREMIN1_5(:,:,6:24)=0; 
sedremin1_5 = ao.Vol' * SEDREMIN1_5(ao.iocn) * 1026*6/1e21; % water dissolution
export1_5 = prod1 - remin1_5 - sedremin1_5;

REMIN1_6 = REMIN1; REMIN1_6(:,:,7:24)=0; 
remin1_6 = ao.Vol' * REMIN1_6(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN1_6 = SEDREMIN1; SEDREMIN1_6(:,:,7:24)=0; 
sedremin1_6 = ao.Vol' * SEDREMIN1_6(ao.iocn) * 1026*6/1e21; % water dissolution
export1_6 = prod1 - remin1_6 - sedremin1_6;

REMIN1_7 = REMIN1; REMIN1_7(:,:,8:24)=0; 
remin1_7 = ao.Vol' * REMIN1_7(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN1_7 = SEDREMIN1; SEDREMIN1_7(:,:,8:24)=0; 
sedremin1_7 = ao.Vol' * SEDREMIN1_7(ao.iocn) * 1026*6/1e21; % water dissolution
export1_7 = prod1 - remin1_7 - sedremin1_7;

REMIN1_8 = REMIN1; REMIN1_8(:,:,9:24)=0; 
remin1_8 = ao.Vol' * REMIN1_8(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN1_8 = SEDREMIN1; SEDREMIN1_8(:,:,9:24)=0; 
sedremin1_8 = ao.Vol' * SEDREMIN1_8(ao.iocn) * 1026*6/1e21; % water dissolution
export1_8 = prod1 - remin1_8 - sedremin1_8;

REMIN1_9 = REMIN1; REMIN1_9(:,:,10:24)=0; 
remin1_9 = ao.Vol' * REMIN1_9(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN1_9 = SEDREMIN1; SEDREMIN1_9(:,:,10:24)=0; 
sedremin1_9 = ao.Vol' * SEDREMIN1_9(ao.iocn) * 1026*6/1e21; % water dissolution
export1_9 = prod1 - remin1_9 - sedremin1_9;

EXPORT1 = [prod1 export1_3 export1_4 export1_5 export1_6 export1_7 export1_8  export1_9];

% Prem model (mid)
load ../output/export_M3_mid
prod2 = ao.Vol' * (op.calc.prodb+op.arag.prodb) * 1026*6/1e21; % 73 m
REMIN2 = ao.OCN*0; REMIN2(ao.iocn)=op.calc.reminb + op.arag.reminb;
SEDREMIN2 = ao.OCN*0; SEDREMIN2(ao.iocn)=op.calc.sedreminb + op.arag.sedreminb - op.external.burialb;

% Layer 3 to 9
REMIN2_3 = REMIN2; REMIN2_3(:,:,4:24)=0; 
remin2_3 = ao.Vol' * REMIN2_3(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN2_3 = SEDREMIN2; SEDREMIN2_3(:,:,4:24)=0; 
sedremin2_3 = ao.Vol' * SEDREMIN2_3(ao.iocn) * 1026*6/1e21; % water dissolution
export2_3 = prod2 - remin2_3 - sedremin2_3;

REMIN2_4 = REMIN2; REMIN2_4(:,:,5:24)=0; 
remin2_4 = ao.Vol' * REMIN2_4(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN2_4 = SEDREMIN2; SEDREMIN2_4(:,:,5:24)=0; 
sedremin2_4 = ao.Vol' * SEDREMIN2_4(ao.iocn) * 1026*6/1e21; % water dissolution
export2_4 = prod2 - remin2_4 - sedremin2_4;

REMIN2_5 = REMIN2; REMIN2_5(:,:,6:24)=0; 
remin2_5 = ao.Vol' * REMIN2_5(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN2_5 = SEDREMIN2; SEDREMIN2_5(:,:,6:24)=0; 
sedremin2_5 = ao.Vol' * SEDREMIN2_5(ao.iocn) * 1026*6/1e21; % water dissolution
export2_5 = prod2 - remin2_5 - sedremin2_5;

REMIN2_6 = REMIN2; REMIN2_6(:,:,7:24)=0; 
remin2_6 = ao.Vol' * REMIN2_6(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN2_6 = SEDREMIN2; SEDREMIN2_6(:,:,7:24)=0; 
sedremin2_6 = ao.Vol' * SEDREMIN2_6(ao.iocn) * 1026*6/1e21; % water dissolution
export2_6 = prod2 - remin2_6 - sedremin2_6;

REMIN2_7 = REMIN2; REMIN2_7(:,:,8:24)=0; 
remin2_7 = ao.Vol' * REMIN2_7(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN2_7 = SEDREMIN2; SEDREMIN2_7(:,:,8:24)=0; 
sedremin2_7 = ao.Vol' * SEDREMIN2_7(ao.iocn) * 1026*6/1e21; % water dissolution
export2_7 = prod2 - remin2_7 - sedremin2_7;

REMIN2_8 = REMIN2; REMIN2_8(:,:,9:24)=0; 
remin2_8 = ao.Vol' * REMIN2_8(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN2_8 = SEDREMIN2; SEDREMIN2_8(:,:,9:24)=0; 
sedremin2_8 = ao.Vol' * SEDREMIN2_8(ao.iocn) * 1026*6/1e21; % water dissolution
export2_8 = prod2 - remin2_8 - sedremin2_8;

REMIN2_9 = REMIN2; REMIN2_9(:,:,10:24)=0; 
remin2_9 = ao.Vol' * REMIN2_9(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN2_9 = SEDREMIN2; SEDREMIN2_9(:,:,10:24)=0; 
sedremin2_9 = ao.Vol' * SEDREMIN2_9(ao.iocn) * 1026*6/1e21; % water dissolution
export2_9 = prod2 - remin2_9 - sedremin2_9;

EXPORT2 = [prod2 export2_3 export2_4 export2_5 export2_6 export2_7 export2_8  export2_9];

% Prem model (high)
load ../output/export_M3_high
prod3 = ao.Vol' * (op.calc.prodb+op.arag.prodb) * 1026*6/1e21; % 73 m
REMIN3 = ao.OCN*0; REMIN3(ao.iocn)=op.calc.reminb + op.arag.reminb;
SEDREMIN3 = ao.OCN*0; SEDREMIN3(ao.iocn)=op.calc.sedreminb + op.arag.sedreminb - op.external.burialb;

% Layer 3 to 9
REMIN3_3 = REMIN3; REMIN3_3(:,:,4:24)=0; 
remin3_3 = ao.Vol' * REMIN3_3(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN3_3 = SEDREMIN3; SEDREMIN3_3(:,:,4:24)=0; 
sedremin3_3 = ao.Vol' * SEDREMIN3_3(ao.iocn) * 1026*6/1e21; % water dissolution
export3_3 = prod3 - remin3_3 - sedremin3_3;

REMIN3_4 = REMIN3; REMIN3_4(:,:,5:24)=0; 
remin3_4 = ao.Vol' * REMIN3_4(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN3_4 = SEDREMIN3; SEDREMIN3_4(:,:,5:24)=0; 
sedremin3_4 = ao.Vol' * SEDREMIN3_4(ao.iocn) * 1026*6/1e21; % water dissolution
export3_4 = prod3 - remin3_4 - sedremin3_4;

REMIN3_5 = REMIN3; REMIN3_5(:,:,6:24)=0; 
remin3_5 = ao.Vol' * REMIN3_5(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN3_5 = SEDREMIN3; SEDREMIN3_5(:,:,6:24)=0; 
sedremin3_5 = ao.Vol' * SEDREMIN3_5(ao.iocn) * 1026*6/1e21; % water dissolution
export3_5 = prod3 - remin3_5 - sedremin3_5;

REMIN3_6 = REMIN3; REMIN3_6(:,:,7:24)=0; 
remin3_6 = ao.Vol' * REMIN3_6(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN3_6 = SEDREMIN3; SEDREMIN3_6(:,:,7:24)=0; 
sedremin3_6 = ao.Vol' * SEDREMIN3_6(ao.iocn) * 1026*6/1e21; % water dissolution
export3_6 = prod3 - remin3_6 - sedremin3_6;

REMIN3_7 = REMIN3; REMIN3_7(:,:,8:24)=0; 
remin3_7 = ao.Vol' * REMIN3_7(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN3_7 = SEDREMIN3; SEDREMIN3_7(:,:,8:24)=0; 
sedremin3_7 = ao.Vol' * SEDREMIN3_7(ao.iocn) * 1026*6/1e21; % water dissolution
export3_7 = prod3 - remin3_7 - sedremin3_7;

REMIN3_8 = REMIN3; REMIN3_8(:,:,9:24)=0; 
remin3_8 = ao.Vol' * REMIN3_8(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN3_8 = SEDREMIN3; SEDREMIN3_8(:,:,9:24)=0; 
sedremin3_8 = ao.Vol' * SEDREMIN3_8(ao.iocn) * 1026*6/1e21; % water dissolution
export3_8 = prod3 - remin3_8 - sedremin3_8;

REMIN3_9 = REMIN3; REMIN3_9(:,:,10:24)=0; 
remin3_9 = ao.Vol' * REMIN3_9(ao.iocn) * 1026*6/1e21; % water dissolution
SEDREMIN3_9 = SEDREMIN3; SEDREMIN3_9(:,:,10:24)=0; 
sedremin3_9 = ao.Vol' * SEDREMIN3_9(ao.iocn) * 1026*6/1e21; % water dissolution
export3_9 = prod3 - remin3_9 - sedremin3_9;

EXPORT3 = [prod3 export3_3 export3_4 export3_5 export3_6 export3_7 export3_8  export3_9];

%% Plotting
figure(1)
papersize = [25 25];
set(gcf,'Renderer','opengl','color', 'w','PaperUnits','centimeters','PaperSize', [papersize(1) papersize(2)],'PaperPosition',[1 1 papersize(1)-1 papersize(2)-1],'position', [100 100 500 500]);

plot(EXPORT2,depth,'Color',[94 119 3]/255,'LineWidth',3,'Marker','o'); hold on
plot(EXPORT3,depth,'Color',[106 125 142]/255,'LineWidth',3,'Marker','o'); hold on
plot(EXPORT1,depth,'Color',[176 11 96]/255,'LineWidth',3,'Marker','o'); hold on
xlabel('Export (Gt PIC y^{-1})'); ylabel('Depth (m)');
legend({'M3 (mid)','M3 (high)','M4 (mid)'},'Location','northwest')
set(gca,'ydir','reverse','fontsize',20)
xlim([0 2])

pdfname=['/Users/hengdi/Desktop/untitled.pdf']; print('-dpdf','-r300',pdfname); open (pdfname)

