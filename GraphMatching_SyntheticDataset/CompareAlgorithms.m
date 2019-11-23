function [AccTotal]=CompareAlgorithms(A,B,GT,gphs,KQ,K,AccTotal,irep, jvar)
% 1. Integer Projected Fixed Point Method (IPFP)
% 2. Spectral Matching with Affine Constraints (SMAC)
% 3. Probabilistic Graph Matching (PM)
% 4. Reweighted Random Walk Matching (RRWM)
% 5. Factorized Graph Matching (FGM)
% 6. Kernelized Graph Matching (KerGM)

%algorithm parameter
n1=size(A,1); n2=size(B,1);
[pars, algs] = gmPar(2);
Ct = ones(n1,n2); % mapping constraint (default to a constant matrix of one)
KP=zeros(n1,n2);
asgT.alg='truth';
asgT.X=GT;
asgT.obj = asgT.X(:)' * K * asgT.X(:);
asgT.acc = 1;

% IPFP-U
asgIpfpU = gm(K, Ct, asgT, pars{5}{:});
AccTotal{1}.res(irep,jvar)=asgIpfpU.acc;

% SMAC
asgSmac = gm(K, Ct, asgT, pars{4}{:});
AccTotal{2}.res(irep,jvar)=asgSmac.acc;

% PM
asgPm = pm(K, KQ, gphs, asgT);
AccTotal{3}.res(irep,jvar)=asgPm.acc;

% RRWM
asgRrwm = gm(K, Ct, asgT, pars{7}{:});
AccTotal{4}.res(irep,jvar)=asgRrwm.acc;

% FGM-U
asgFgmU = fgmU(KP, KQ, Ct, gphs, asgT, pars{8}{:});
AccTotal{5}.res(irep,jvar)=asgFgmU.acc;

% KerGM
lambda=0.005; num=11;para.gamma=5; para.D=20;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc = matchAsg(X, asgT);
AccTotal{6}.res(irep,jvar)=acc;

end