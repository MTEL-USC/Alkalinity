% Grid GLODAP data to AO
clear all
load ../ao

% Mapped GLODAP data are downloaded from original paper
salinity_init = ncread('GLODAPv2.2016b.salinity.nc','salinity'); % 360*180*33
lat_init = ncread('GLODAPv2.2016b.salinity.nc','lat'); % 180*1
lon_init = ncread('GLODAPv2.2016b.salinity.nc','lon'); % 360*1
depth_init = ncread('GLODAPv2.2016b.salinity.nc','Depth'); % 33*1

% because lon range in GLODAP is from 20~380, we need to change to 0~360 
lon_init = lon_init-20;
Sal = NaN(360,180,33); 
Sal(1:20,:,:) = salinity_init(341:360,:,:); Sal(21:360,:,:) = salinity_init(1:340,:,:); 

% swap Sal dimensions from lon * lat * depth to lat * lon * depth
Sal = permute(Sal,[2 1 3]);

% meshgrid
[LON,LAT,DEPTH] = meshgrid(lon_init,lat_init,depth_init);
[LON_AO,LAT_AO,DEPTH_AO] =  meshgrid(ao.lon,ao.lat,ao.depth);

% interpolation
Sal_AO = interp3(LON,LAT,DEPTH,Sal,LON_AO,LAT_AO,DEPTH_AO);

% Interpolation
Sal =inpaint_nans3(Sal_AO,1);
Sal(isnan(ao.nanOCN))=NaN;

% Visualize surface data
figure(1)
subplot(3,1,1)
pcolor(Sal_init(:,:,1)); shading flat; title('GLODAP 180*360*33'); 
colorbar; set(gca,'CLim',[33 37]); hold on
subplot(3,1,2)
pcolor(Sal_AO(:,:,1)); shading flat; title('AO 91*180*24'); 
colorbar; set(gca,'CLim',[33 37]); hold on
subplot(3,1,3)
pcolor(Sal(:,:,1)); shading flat; title('Interp AO 91*180*24'); 
colorbar; set(gca,'CLim',[33 37]); hold off

save Sal.mat Sal