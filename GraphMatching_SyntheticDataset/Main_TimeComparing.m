% Comparing the running time for different graph matching algorithm
clear (); close all; clc;

inlier=100;

[A,B,~]=GenerateAdjacentMatrices_RandGraph(inlier,0,0.5,0);
% KerGM
t0=cputime;
lambda=0.005; num=11;para.gamma=10; para.D=20;
[X,obj]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
KerGMtime=cputime-t0;
fprintf("The cpu time of our KGM algorithm with graphs of %d nodes is %d\n", inlier, KerGMtime);

if inlier>200
    fprintf("The node number is too large, and may cause the OUT OF MEMORY issue for other algorithms.\n")
else
    [A,B,GT,gphs,KQ,K]=GenerateRandGraph(inlier,0,0.5,0);
    %algorithm parameters
    n1=size(A,1); n2=size(B,1);
    [pars, algs] = gmPar(2);
    Ct = ones(n1,n2); % mapping constraint (default to a constant matrix of one)
    KP=zeros(n1,n2);
    asgT.alg='truth'; asgT.X=GT; asgT.obj = asgT.X(:)' * K * asgT.X(:); asgT.acc = 1;
    
    % IPFP-U
    t0=cputime;
    asgIpfpU = gm(K, Ct, asgT, pars{5}{:});
    IPFPtime=cputime-t0;
    fprintf("The cpu time of the IPFP algorithm with graphs of %d nodes is %d\n", inlier, IPFPtime);
    
    % SMAC
    t0=cputime;
    asgSmac = gm(K, Ct, asgT, pars{4}{:});
    SMACtime=cputime-t0;
    fprintf("The cpu time of the SMAC algorithm with graphs of %d nodes is %d\n", inlier, SMACtime);
    
    % PM
    t0=cputime;
    asgPm = pm(K, KQ, gphs, asgT);
    PMtime=cputime-t0;
    fprintf("The cpu time of the PM algorithm with graphs of %d nodes is %d\n", inlier, PMtime);
    
    % RRWM
    t0=cputime;
    asgRrwm = gm(K, Ct, asgT, pars{7}{:});
    RRWMtime=cputime-t0;
    fprintf("The cpu time of the RRWM algorithm with graphs of %d nodes is %d\n", inlier, RRWMtime);
    
    %FGM-U
    t0=cputime;
    asgFgmU = fgmU(KP, KQ, Ct, gphs, asgT, pars{8}{:});
    FGMtime=cputime-t0;
    fprintf("The cpu time of the FGM algorithm with graphs of %d nodes is %d\n", inlier, FGMtime);
    
end 







