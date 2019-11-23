% In this file, we compare different state-of-the-art Graph Matching
% algorihtms, including:
% 1. Integer Projected Fixed Point Method (IPFP)
% 2. Spectral Matching with Affine Constraints (SMAC)
% 3. Probabilistic Graph Matching (PM)
% 4. Reweighted Random Walk Matching (RRWM)
% 5. Factorized Graph Matching (FGM)
% 6. Kernelized Graph Matching (KerGM)

setting=1;

nrep=100; % We repeat the experiment nrep times.
switch setting
    
    case 1
        inlier=50; outlier=0:5:50; density=1; deformation=0;
        nvar=length(outlier); Acc=zeros(nrep,nvar);number=0;
        AccTotal_out=InitializeAccTotal(nrep,nvar);
        for irep=1:nrep
            for jvar=1:nvar               
                % Generate random graphs
                [A1,A2,GT,gphs,KQ,K]=GenerateRandGraph(inlier,outlier(jvar),...
                    density,deformation);
                % Compare different algorithms
                 [AccTotal_out]=CompareAlgorithms(A1,A2,GT,gphs,KQ,K,AccTotal_out,...
                     irep, jvar);
                number=number+1;
                fprintf('The %dth graph matching problem has been solved\n', number);                
            end
        end
        save('outlier.mat', 'AccTotal_out');        
    case 2
        inlier=50; outlier=5; density=0.3:0.1:1; deformation=0.1;
        nvar=length(density); Acc=zeros(nrep,nvar); number=0;
        AccTotal_den=InitializeAccTotal(nrep,nvar);
        for irep=1:nrep
           for jvar=1:nvar               
               % Generate random graphs
               [A,B,GT,gphs,KQ,K]=GenerateRandGraph(inlier,outlier,...
                    density(jvar),deformation);
                % Compare different algorithms
                 [AccTotal_den]=CompareAlgorithms(A,B,GT,gphs,KQ,K,AccTotal_den,...
                     irep, jvar);
                number=number+1;
                fprintf('The %dth graph matching problem has been solved\n', number);                
            end
        end
        save('densitynew_outlier5noise01.mat','AccTotal_den');
    case 3 
        inlier=50; outlier=0; density=1; deformation=0:0.02:0.2;
        nvar=length(deformation); Acc=zeros(nrep,nvar);number=0;
        AccTotal_noise=InitializeAccTotal(nrep,nvar);
        for irep=1:nrep
           for jvar=1:nvar               
               % Generate random graphs
               [A,B,GT,gphs,KQ,K]=GenerateRandGraph(inlier,outlier,...
                    density,deformation(jvar));
                % Compare different algorithms
                 [AccTotal_noise]=CompareAlgorithms(A,B,GT,gphs,KQ,K,AccTotal_noise,...
                     irep, jvar);
                number=number+1;
                fprintf('The %dth graph matching problem has been solved\n', number);                
            end
        end
        save('noise.mat','AccTotal_noise');
end 


