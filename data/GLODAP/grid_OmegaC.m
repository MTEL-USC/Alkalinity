% Grid GLODAP data to AO
clear all
load ../ao

% Mapped GLODAP data are downloaded from original paper
OmegaC_init = ncread('GLODAPv2.2016b.OmegaC.nc','OmegaC'); % 360*180*33
lat_init = ncread('GLODAPv2.2016b.OmegaC.nc','lat'); % 180*1
lon_init = ncread('GLODAPv2.2016b.OmegaC.nc','lon'); % 360*1
depth_init = ncread('GLODAPv2.2016b.OmegaC.nc','Depth'); % 33*1

% because lon range in GLODAP is from 20~380, we need to change to 0~360 
lon_init = lon_init-20;
OmegaC = NaN(360,180,33); 
OmegaC(1:20,:,:) = OmegaC_init(341:360,:,:); OmegaC(21:360,:,:) = OmegaC_init(1:340,:,:); 

% swap OmegaC dimensions from lon * lat * depth to lat * lon * depth
OmegaC_init = permute(OmegaC,[2 1 3]);

% meshgrid
[LON,LAT,DEPTH] = meshgrid(lon_init,lat_init,depth_init);
[LON_AO,LAT_AO,DEPTH_AO] =  meshgrid(ao.lon,ao.lat,ao.depth);

% interpolation
OmegaC_AO = interp3(LON,LAT,DEPTH,OmegaC_init,LON_AO,LAT_AO,DEPTH_AO);

% Interpolation
OmegaC =inpaint_nans3(OmegaC_AO,1);
OmegaC(isnan(ao.nanOCN))=NaN;

% Visualize surface data
figure(1)
subplot(3,1,1)
pcolor(OmegaC_init(:,:,18)); shading flat; title('GLODAP 180*360*33'); 
colorbar; set(gca,'CLim',[0 3]); hold on
subplot(3,1,2)
pcolor(OmegaC_AO(:,:,18)); shading flat; title('AO 91*180*24'); 
colorbar; set(gca,'CLim',[0 3]); hold on
subplot(3,1,3)
pcolor(OmegaC(:,:,18)); shading flat; title('Interp AO 91*180*24'); 
colorbar; set(gca,'CLim',[0 3]); hold off

save OmegaC.mat OmegaC