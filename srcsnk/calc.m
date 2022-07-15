function [A,b,output] = calc(A,b,do)
% Calcite dissolution: kinetics + respiration (M3)
fprintf('%s','calc...')

% unpack the key parameters
SF = do.calc.SF;
x = do.calc.x;
m = do.calc.m;
sedremin = do.calc.sedremin;

% load the grid and the model output for P uptake (productivity)
load data/ao.mat
load data/P_UP.mat
load data/P_REM_WJ18.mat
load data/GLODAP/OmegaC.mat
load data/PICPOC_TW.mat
load data/CtoP_nitrate.mat

% get the productivity of P (P uptake rate in mmole m-3 y-1)
PPROD = P_UP_WJ18./1.026; % mmol m-3 y-1 = 1/1.026 umol kg-1 y-1
PREM = abs(P_REM_WJ18)./1.026;

% determine the uptake rate of your element
EPROD = PPROD.*CtoP.*CALCPOC_TW.*SF.*2; % 106 is the  C:P ratio; 2 is to double ALK from PIC
eprod = EPROD(ao.iocn);

% create the b matrix for loss of E by biological uptake
prodb = eprod;

% Kdiss with pre-defined PREM, k and n values
Kdiss = 0*ao.nanOCN;

% Calcite
OCeff = OmegaC;

ind1=find(OCeff<1 & OCeff>=0.85); 
Kdiss(ind1) = 0.016.*(1-OCeff(ind1)).^0.33;

ind2=find(OCeff<0.85 & OCeff>=0);
Kdiss(ind2) = 0.5.*(1-OCeff(ind2)).^2.2;

Kdiss = Kdiss + x.*PREM.^m; 

% Define fPFD_n, the fraction of dissolution in each box
fPFD_n = 1-exp(-Kdiss.*ao.HEIGHT./100); 

% Define PARTICLE, a 91*180*25 matrix with fractional particle
% amount at each boundary (top or bottom)
PARTICLES =  zeros(91,180,25);
PARTICLES(:,:,3)=1; % at the bottom of the 2nd layer, fraction = 1
for i = 4:25
    % the particle in the ith layer = the particle in the (i-1)th layer *
    % the fraction not dissolved in the (i-1)th layer
    PARTICLES(:,:,i) = PARTICLES(:,:,i-1).*(1-fPFD_n(:,:,i-1));
end

% Particle flux divergence
PFD = -diff(PARTICLES,1,3); % PFD in a layer = top - bottom
PFD(:,:,1:2)=0; % No dissolution in the top 2 layers
PFD = PFD.*ao.OCN;

% Remineralization
EPROD1 = repmat(EPROD(:,:,1),1,1,24); EPROD2 = repmat(EPROD(:,:,2),1,1,24);
remin1 = EPROD1(ao.iocn).*PFD(ao.iocn).*ao.height(1)./ao.HEIGHT(ao.iocn); remin2 = EPROD2(ao.iocn).*PFD(ao.iocn).*ao.height(2)./ao.HEIGHT(ao.iocn);
reminb = remin1 + remin2;

% modify the b matrix for productivity and water-column remineralization
b = b + prodb - reminb;

% the remineralization flux back into the bottom cell
PBTM = PARTICLES(:,:,2:25);
SED = ao.nanOCN*0;
SED(ao.ibtm)=PBTM(ao.ibtm);
sed = squeeze(nansum(SED,3));
SEDREMIN = repmat(sed,1,1,24);
SEDREMIN = ao.SEAFLOOR.*SEDREMIN;

sedremin1 = EPROD1(ao.iocn).*SEDREMIN(ao.iocn).*ao.height(1)./ao.HEIGHT(ao.iocn); sedremin2 = EPROD2(ao.iocn).*SEDREMIN(ao.iocn).*ao.height(2)./ao.HEIGHT(ao.iocn);
sedreminb = sedremin1 + sedremin2;
if sedremin;
    b = b - sedreminb;
end

% package outputs
output.SF = SF;
output.x = x;
output.m = m;
output.fPFD=fPFD_n;
output.Kdiss=Kdiss;
output.PFD=PFD;
output.PARTICLES=PARTICLES;
output.prodb=prodb;
output.reminb=reminb;
if sedremin
    output.PBTM = PBTM;
    output.sedremin1=sedremin1;
    output.sedremin2=sedremin2;
    output.sedreminb=sedremin1+sedremin2; 
end
output.b=b;
output.A=A;