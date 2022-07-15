% Model4S1: Model 4, Step 1 --> initialize optimization
close all; clear all;
setupstart = tic;
 
% open parallel pool
parpool(10);
options = optimoptions('ga','UseParallel',true);

% three parameters: export scaling factor, mean TA, Rconst
lb = [0.15 2375 0]; % lower bound 
ub = [0.8 2425 0.1]; % upper bound 

% Genetic algorithm options
options = optimoptions('ga','MaxStallGenerations',50,'MaxGenerations',2000);
options = optimoptions('ga','PopulationSize',50,'FunctionTolerance',1e-4);

rng default; % for reproducibility
% Start optimization: move to Step 2 (function Model4S2.m)
[finals,fval,exitFlag,Opoutput,pop,scores] = ga(@(inits)Model4S2(inits),3,[],[],[],[],lb,ub,[],options);

% Close parallel pool
delete(gcp('nocreate'));
% Save optimized model to the output subfolder
save(['output/Base_M4.mat'],'finals','fval','exitFlag','Opoutput','pop','scores','-append');

toc(setupstart)
