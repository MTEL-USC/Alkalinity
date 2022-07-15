% calculate R^2
clear all; close all;
load ../../data/ao
load ../../data/GLODAP/Sal
load ../../data/GLODAP/TA
load ../../data/Carter/TAc_AO
obs_0 = TA0_AO(ao.iocn); obs_0=obs_0(~isnan(obs_0)); 
obs_s = TAs_AO(ao.iocn); obs_s=obs_s(~isnan(obs_s)); 
obs_t = TA(ao.iocn) + TAr_AO(ao.iocn); obs_t=obs_t(~isnan(obs_t)); 

load ../../output/Base_M1
ms = E.*Sal./35-E0; model_s = ms(ao.iocn); model_s=model_s(~isnan(model_s)); 
m0 = E0; model_0 = m0(ao.iocn); model_0=model_0(~isnan(model_0)); 
mt = E.*Sal./35; model_t = mt(ao.iocn); model_t=model_t(~isnan(obs_t)); 

% TA0 R-squared
SSE1 = sum((obs_0-model_0).^2);
SST1 = sum((obs_0-mean(obs_0)).^2);
R2_0 = 1 - SSE1/SST1

% % TA* R-squared
SSE2 = sum((obs_s-model_s).^2);
SST2 = sum((obs_s-mean(obs_s)).^2);
R2_s = 1 - SSE2/SST2

% TA R-squared
SSE3 = sum((obs_t-model_t).^2);
SST3 = sum((obs_t-mean(obs_t)).^2);
R2_t = 1 - SSE3/SST3;