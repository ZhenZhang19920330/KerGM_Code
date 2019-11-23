% In this file, we compare the performance and time for different lambda
% 1. Dim=10;
% 2. Dim=20;
% 3. Dim=50;


clear (); close all; clc;
nrep=30; % We repeat the experiments ten times and report the average
inlier=500; outlier=0:100:500; density=1; deformation=0;
nvar=length(outlier);number=0;

AccTimeTotal_Dim=InitializeAccTimeTotal_Dim(nrep,nvar);
for irep=1:nrep
    for jvar=1:nvar  
        % Generate random graphs
        [A,B,GT]=GenerateAdjacentMatrices_RandGraph(inlier,outlier(jvar),density,deformation);
        % Compare different lambdas
        [AccTimeTotal_Dim]=CompareDims(A,B,GT,AccTimeTotal_Dim,irep, jvar);
        number=number+1;
        fprintf('The %dth graph matching problem has been solved\n', number);    
    end
end
save('Parameter_Dim.mat', 'AccTimeTotal_Dim');