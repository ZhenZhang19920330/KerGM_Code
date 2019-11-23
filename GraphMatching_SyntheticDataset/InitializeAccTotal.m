function [AccTotal]=InitializeAccTotal(nrep,nvar)
% 1. Integer Projected Fixed Point Method (IPFP)
% 2. Spectral Matching with Affine Constraints (SMAC)
% 3. Probabilistic Graph Matching (PM)
% 4. Reweighted Random Walk Matching (RRWM)
% 5. Factorized Graph Matching (FGM)
% 6. Kernelized Graph Matching (KerGM)

AccTotal=cell(1,6);
AccTotal{1}.name='IPFP';
AccTotal{2}.name='SMAC';
AccTotal{3}.name='PM';
AccTotal{4}.name='RRWM';
AccTotal{5}.name='FGM';
AccTotal{6}.name='KerGM';

for i=1:6
    AccTotal{i}.res=zeros(nrep,nvar);
end

end