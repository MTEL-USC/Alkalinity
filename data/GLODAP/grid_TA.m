% Grid GLODAP data to AO
clear all
load ../ao

% Mapped GLODAP data are downloaded from original paper
TALK_init = ncread('GLODAPv2.2016b.TAlk.nc','TAlk'); % 360*180*33
lat_init = ncread('GLODAPv2.2016b.TAlk.nc','lat'); % 180*1
lon_init = ncread('GLODAPv2.2016b.TAlk.nc','lon'); % 360*1
depth_init = ncread('GLODAPv2.2016b.TAlk.nc','Depth'); % 33*1

% because lon range in GLODAP is from 20~380, we need to change to 0~360 
lon_init = lon_init-20;
TALK = NaN(360,180,33); 
TALK(1:20,:,:) = TALK_init(341:360,:,:); TALK(21:360,:,:) = TALK_init(1:340,:,:); 

% swap TALK dimensions from lon * lat * depth to lat * lon * depth
TALK = permute(TALK,[2 1 3]);

% meshgrid
[LON,LAT,DEPTH] = meshgrid(lon_init,lat_init,depth_init);
[LON_AO,LAT_AO,DEPTH_AO] =  meshgrid(ao.lon,ao.lat,ao.depth);

% interpolation
TALK_AO = interp3(LON,LAT,DEPTH,TALK,LON_AO,LAT_AO,DEPTH_AO);

% Interpolation
TA =inpaint_nans3(TALK_AO,1);
TA(isnan(ao.nanOCN))=NaN;

% Visualize surface data
figure(1)
subplot(3,1,1)
pcolor(TALK(:,:,1)); shading flat; title('GLODAP 180*360*33'); 
colorbar; set(gca,'CLim',[1900 2600]); hold on
subplot(3,1,2)
pcolor(TALK_AO(:,:,1)); shading flat; title('AO 91*180*24'); 
colorbar; set(gca,'CLim',[1900 2600]); hold on
subplot(3,1,3)
pcolor(TA(:,:,1)); shading flat; title('Interp AO 91*180*24'); 
colorbar; set(gca,'CLim',[1900 2600]); hold off

save TA.mat TA