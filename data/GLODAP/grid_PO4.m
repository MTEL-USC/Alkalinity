% Grid GLODAP data to AO
clear all
load ../ao

% Mapped GLODAP data are downloaded from original paper
PO4_init = ncread('GLODAPv2.2016b.PO4.nc','PO4'); % 360*180*33
lat_init = ncread('GLODAPv2.2016b.PO4.nc','lat'); % 180*1
lon_init = ncread('GLODAPv2.2016b.PO4.nc','lon'); % 360*1
depth_init = ncread('GLODAPv2.2016b.PO4.nc','Depth'); % 33*1

% because lon range in GLODAP is from 20~380, we need to change to 0~360 
lon_init = lon_init-20;
PO4 = NaN(360,180,33); 
PO4(1:20,:,:) = PO4_init(341:360,:,:); PO4(21:360,:,:) = PO4_init(1:340,:,:); 

% swap PO4 dimensions from lon * lat * depth to lat * lon * depth
PO4 = permute(PO4,[2 1 3]);

% meshgrid
[LON,LAT,DEPTH] = meshgrid(lon_init,lat_init,depth_init);
[LON_AO,LAT_AO,DEPTH_AO] =  meshgrid(ao.lon,ao.lat,ao.depth);

% interpolation
PO4_AO = interp3(LON,LAT,DEPTH,PO4,LON_AO,LAT_AO,DEPTH_AO);

% Interpolation
PO4 =inpaint_nans3(PO4_AO,1);
PO4(isnan(ao.nanOCN))=NaN;

% Visualize surface data
figure(1)
subplot(3,1,1)
pcolor(PO4_init(:,:,1)); shading flat; title('GLODAP 180*360*33'); 
colorbar; set(gca,'CLim',[0 2.5]); hold on
subplot(3,1,2)
pcolor(PO4_AO(:,:,1)); shading flat; title('AO 91*180*24'); 
colorbar; set(gca,'CLim',[0 2.5]); hold on
subplot(3,1,3)
pcolor(PO4(:,:,1)); shading flat; title('Interp AO 91*180*24'); 
colorbar; set(gca,'CLim',[0 2.5]); hold off

save PO4.mat PO4