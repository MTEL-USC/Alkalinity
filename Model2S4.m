% Model 2 Step 4 Calculate cost (model vs observation)

% load data
load data/ao.mat;
load data/Preformed/TAc_AO % TAc_AO: TA from Carter et al (2021), re-gridded to AO
load data/GLODAP/Sal
% load model output
filename = 'output/Base_M2.mat';
load(filename)

% Data mask: exclude land cells and keep ocean cells
MSK = nan(size(ao.OCN)); MSK(isfinite(TAs_AO)) = 1; 
MSK = MSK.*ao.nanOCN; 

% Masked TA data
TAs_AO = TAs_AO.*MSK; % TAs = TAstar (TA*)
model_star = (E.*Sal./35-E0).*MSK; % Modeled TA corrected by salinity
TA0_AO = TA0_AO.*MSK;
model_0 = E0.*MSK;
VOL = ao.VOL.*MSK; % Ocean volume

% Exclude datapoints at high latitudes and surface from cost calculations
data = TAs_AO(11:81,:,3:24); 
model = model_star(11:81,:,3:24); 
data0 = TA0_AO(11:81,:,3:24); 
model0 = model_0(11:81,:,3:24); 
VOLlim = VOL(11:81,:,3:24);

% Calculate the cost of TA* and TA0, separately
TAscost = nansum(nansum(nansum(((model-data).^2).*VOLlim)))/nansum(nansum(nansum(VOLlim)));
TA0cost = nansum(nansum(nansum(((model0-data0).^2).*VOLlim)))/nansum(nansum(nansum(VOLlim)));

% Equally weights of TA0 and TA* 
totalcost = TA0cost+TAscost ;
fprintf('%s%d\n%s%d\n%s%d\n%s%d\n','total cost=',totalcost)

cost = totalcost;
save (filename,'cost','-append');
