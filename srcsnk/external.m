function [A,b,output] = external(A,b,do);
% RIVERALK adds alkalinity from 34 rivers

fprintf('%s','RIVandBUR...')
load data/ao.mat;
load data/RIVER.mat
load data/burial/BUR.mat

% turn the shoebox into a linear vector
% umol ALK kg-1 yr-1

riverb = RIVER(ao.iocn); 
burialb = BUR(ao.iocn);

burialb(isnan(burialb))=0;

% Scaling factor
sf = nansum(burialb.*ao.Vol)./nansum(riverb.*ao.Vol);

sourceb = riverb.*sf; 
sinkb = burialb;

% modify the b matrix
b = b - sourceb + sinkb;

% package outputs
output.riverb=sourceb;
output.burialb=sinkb;
output.sf=sf;