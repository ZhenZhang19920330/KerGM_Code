% In this file, we compare the performance and time for different lambda
% lambda=0.005, 0.006, 0.007, 0.008, 0.009, 
%        0.01,  0.012, 0.016, 0.02,  0.03,  0.04, 0.05
clear (); close all; clc;
addpath('./KerGM');

nrep=10; % We repeat the experiments ten times and report the average
inlier=500; outlier=0:100:500; density=1; deformation=0;
nvar=length(outlier); Acc=zeros(nrep,nvar);number=0;

AccTimeTotal_lambda=InitializeAccTimeTotal_lambda(nrep,nvar,12);
for irep=1:nrep
    for jvar=1:nvar  
        % Generate random graphs
        [A,B,GT]=GenerateAdjacentMatrices_RandGraph(inlier,outlier(jvar),density,deformation);
        % Compare different lambdas
        [AccTimeTotal_lambda]=CompareLambdas(A,B,GT,AccTimeTotal_lambda,irep, jvar);
        number=number+1;
        fprintf('The %dth graph matching problem has been solved\n', number);    
    end
end
save('Parameter_lambda.mat', 'AccTimeTotal_lambda');