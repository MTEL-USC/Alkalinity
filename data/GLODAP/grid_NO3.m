% Grid GLODAP data to AO
clear all
load ../ao

% Mapped GLODAP data are downloaded from original paper
NO3_init = ncread('GLODAPv2.2016b.NO3.nc','NO3'); % 360*180*33
lat_init = ncread('GLODAPv2.2016b.NO3.nc','lat'); % 180*1
lon_init = ncread('GLODAPv2.2016b.NO3.nc','lon'); % 360*1
depth_init = ncread('GLODAPv2.2016b.NO3.nc','Depth'); % 33*1

% because lon range in GLODAP is from 20~380, we need to change to 0~360 
lon_init = lon_init-20;
NO3 = NaN(360,180,33); 
NO3(1:20,:,:) = NO3_init(341:360,:,:); NO3(21:360,:,:) = NO3_init(1:340,:,:); 

% swap TALK dimensions from lon * lat * depth to lat * lon * depth
NO3_init = permute(NO3,[2 1 3]);

% meshgrid
[LON,LAT,DEPTH] = meshgrid(lon_init,lat_init,depth_init);
[LON_AO,LAT_AO,DEPTH_AO] =  meshgrid(ao.lon,ao.lat,ao.depth);

% interpolation
NO3_AO = interp3(LON,LAT,DEPTH,NO3_init,LON_AO,LAT_AO,DEPTH_AO);

% Interpolation
NO3 =inpaint_nans3(NO3_AO,1);
NO3(isnan(ao.nanOCN))=NaN;

% Visualize surface data
figure(1)
subplot(3,1,1)
pcolor(NO3_init(:,:,1)); shading flat; title('GLODAP 180*360*33'); 
colorbar; set(gca,'CLim',[0 30]); 
hold on
subplot(3,1,2)
pcolor(NO3_AO(:,:,1)); shading flat; title('AO 91*180*24'); 
colorbar; set(gca,'CLim',[0 30]); hold on
subplot(3,1,3)
pcolor(NO3(:,:,1)); shading flat; title('Interp AO 91*180*24'); 
colorbar; set(gca,'CLim',[0 30]); hold off

save NO3.mat NO3