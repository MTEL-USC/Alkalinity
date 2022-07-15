% Model 1 Step 3: solve modeled TA0 based on the modeled TA (E)
% Method to calculate preformed TA based on Carter et al (2021)

load data/ao
load data/Preformed/OCIMPrefProps.mat
load data/Preformed/BoundID.mat
load data/water_transport.mat

filename = 'output/Base_M1.mat';
load(filename)
load data/GLODAP/Sal
TA = E.*Sal./35; % salinity-normalized TA (E) to TA

A = water_transport; % the whole A (water transport) of 200160*200160
AI = A(10442:200160,10442:200160); % I = interior
AB = A(10442:200160,1:10441); % B = boundary 

ind = find(~isnan(X)); % index of the boundary layer boxes, stored in X from BoundID.mat
BoundaryTA = nan(91,180,24); BoundaryTA(ind)=TA(ind);
boundTA = nansum(BoundaryTA,3); boundTA = repmat(boundTA,1,1,24);
bTA = boundTA(ao.isurf); % move the boundary TA (at the mixed layer bottom) to the surface, serve as the "surface TA"

e0 = - AI\(AB*bTA); % solve modeled TA0 following Carter et al (2021) Eqn S4
E0 = NaN(91,180,24);
E0(masks.ckeep)=e0;

save (filename,'E0','-append');

% Move to Model 1 Step 4
Model1S4;