% Grid GLODAP data to AO
clear all
load ../ao

% Mapped GLODAP data are downloaded from original paper
OmegaA_init = ncread('GLODAPv2.2016b.OmegaA.nc','OmegaA'); % 360*180*33
lat_init = ncread('GLODAPv2.2016b.OmegaA.nc','lat'); % 180*1
lon_init = ncread('GLODAPv2.2016b.OmegaA.nc','lon'); % 360*1
depth_init = ncread('GLODAPv2.2016b.OmegaA.nc','Depth'); % 33*1

% because lon range in GLODAP is from 20~380, we need to change to 0~360 
lon_init = lon_init-20;
OmegaA = NaN(360,180,33); 
OmegaA(1:20,:,:) = OmegaA_init(341:360,:,:); OmegaA(21:360,:,:) = OmegaA_init(1:340,:,:); 

% swap OmegaA dimensions from lon * lat * depth to lat * lon * depth
OmegaA_init = permute(OmegaA,[2 1 3]);

% meshgrid
[LON,LAT,DEPTH] = meshgrid(lon_init,lat_init,depth_init);
[LON_AO,LAT_AO,DEPTH_AO] = meshgrid(ao.lon,ao.lat,ao.depth);

% interpolation
OmegaA_AO = interp3(LON,LAT,DEPTH,OmegaA_init,LON_AO,LAT_AO,DEPTH_AO);

% Interpolation
OmegaA =inpaint_nans3(OmegaA_AO,1);
OmegaA(isnan(ao.nanOCN))=NaN;

save OmegaA.mat OmegaA