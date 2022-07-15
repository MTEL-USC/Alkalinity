% Model3S1: Model 3, Step 1 --> initialize optimization
close all; clear all;
setupstart = tic;
 
% open parallel pool
parpool(10);
options = optimoptions('ga','UseParallel',true);

% six parameters: export scaling factor, mean TA, x_calc, m_calc, x_arag, m_arag
lb = [0.15 2375 0 0 0 0];
ub = [0.8 2425 20 2 20 2];

% Genetic algorithm options
options = optimoptions('ga','MaxStallGenerations',50,'MaxGenerations',2000);
options = optimoptions('ga','PopulationSize',100,'FunctionTolerance',1e-4);

rng default; % for reproducibility
% Start optimization: move to Step 2 (function Model3S2.m)
[finals,fval,exitFlag,Opoutput,pop,scores] = ga(@(inits)Model3S2(inits),6,[],[],[],[],lb,ub,[],options);

% Close parallel pool
delete(gcp('nocreate'));
% Save optimized model to the output subfolder
save(['output/Base_M3.mat'],'finals','fval','exitFlag','Opoutput','pop','scores','-append');

toc(setupstart)
