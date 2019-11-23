function [A,B,GT]=GenerateAdjacentMatrices_RandGraph(inlier,outlier,density,deformation)
% This function is used to generate random graphs
% Input: 
%      inlier:       number of inlier nodes
%      outlier:      number of outlier nodes
%      density:      the edge density of random graph
%      deformation:  the deformation of edge weights
% Output:
%      A,B:          Two adjacency matrices of (inlier+outlier) nodes
%       GT:          The ground true permutation matrix   
n=inlier+outlier;
m=inlier+outlier;

A=rand(n);A=(A+A')/2; A=A.*(A<density); A=A-diag(diag(A));
B=rand(m);B=(B+B')/2; B=B.*(B<density); B=B-diag(diag(B));

seq = randperm(inlier);
B(seq(1:inlier),seq(1:inlier))=A(1:inlier,1:inlier);

N = deformation*tril(randn(m),-1);
N = N+N';
B=B+N;


% Ground Truth Matrix
GT=zeros(n,m);
for i=1:length(seq)
    GT(i,seq(i))=1;
end

end