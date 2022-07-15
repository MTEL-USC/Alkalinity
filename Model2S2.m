function cost = Model2S2(inits);
% Model 2 Step 2: generate the alkalinity model 

% add path to biogeochemical processes (specified in the srcsnk subfolder)
addpath srcsnk
% load data
load data/ao
load data/water_transport
% initialize A and b matrices
b = zeros(200160,1);
A = sparse(200160,200160);

% Assign initial values to each parameter
SF = inits(1);
c = inits(2);
fprintf('SF=%d,c=%d\n',inits);

do = [];

% external src/snk: balanced river and burial
do.external.on = 1;

% Set mean concentration of salinity-normalized TA
do.conc.on = 1;
do.conc.c = c;

% Calcite export and kinetic dissolution
do.kinetic_c.on=1;
do.kinetic_c.SF=SF;
do.kinetic_c.sedremin=1;

% Aragonite export and kinetic dissolution
do.kinetic_a.on=1;
do.kinetic_a.SF=SF;
do.kinetic_a.sedremin=1;

% Call the biogeochemical functions in the srcsnk subfolder
[A,b,output] = conc(A,b,do); op.conc=output;
[A,b,output] = external(A,b,do); op.external=output;
[A,b,output] = kinetic_a(A,b,do); op.kinetic_a=output;
[A,b,output] = kinetic_c(A,b,do); op.kinetic_c=output;

% Add ocean circulation (water_transport.mat)
A = A + water_transport; 

% Solve tracer (e) through linear algebra
tic
e=A\b; 
toc

E = ao.nanOCN;
E(ao.iocn) = e; % E is the 3-D matrix of tracer concentrations; e is 1-D

% Save the model output to the output subfolder
filename = 'output/Base_M2.mat';
save (filename,'E','A','b','op');

% Move to Model 2 Step 3: solve modeled TA0 based on the modeled TA (E)
Model2S3;

end
