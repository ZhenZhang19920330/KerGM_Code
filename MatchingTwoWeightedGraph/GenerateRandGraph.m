function [A,B,GT,gphs,KQ,K]=GenerateRandGraph(inlier,outlier,density,deformation)
% This function is used to generate random graphs
% Input: 
%      inlier:       number of inlier nodes
%      outlier:      number of outlier nodes
%      density:      the edge density of random graph
%      deformation:  the deformation of edge weights
% Output:
%      A,B:          Two adjacency matrices of (inlier+outlier) nodes
%       GT:          The ground true permutation matrix n1*n2
%     gphs:          The 1*2 cell
%     gphs{i}.G      The node-edge incidence matrix
%     gphs{i}.H      The augumented incidence matrix
%     KQ:            The m1*m2 edge affinity matrix
%      K:            The n1n2*n1n2 affinity matrix
%     
n1=inlier+outlier;
n2=inlier+outlier;

A=rand(n1);A=(A+A')/2; A=A.*(A<density); A=A-diag(diag(A));
B=rand(n2);B=(B+B')/2; B=B.*(B<density); B=B-diag(diag(B));

seq = randperm(inlier);
B(seq(1:inlier),seq(1:inlier))=A(1:inlier,1:inlier);

N = deformation*tril(randn(n2),-1);
N = N+N';
B=B+N;


% Ground Truth Matrix
GT=zeros(n1,n2);
for i=1:length(seq)
    GT(i,seq(i))=1;
end

% Incidence Matrices
[gphs,Edge1,Edge2]=GenerateIncidenceMatrix(A,B);

% Affinity Matrices
[K,KQ]=AffinityMatrices(A,B,Edge1,Edge2);

% Check
%[Diff]=Check(KQ,K,gphs);
end


function [gphs,Edge1,Edge2]=GenerateIncidenceMatrix(A,B)
gphs=cell(1,2);

n1=size(A,1);G1=[];Edge1=[];
for i=1:n1
    for j=i+1:n1
        if abs(A(i,j))>eps
            colG=zeros(n1,1);colG(i)=1;colG(j)=1;
            G1=[G1 colG];Edge1=[Edge1; A(i,j)];
        end
    end
end
gphs{1}.G=G1;
gphs{1}.H=[G1 eye(n1)];

n2=size(B,1);G2=[];Edge2=[];
for i=1:n2
    for j=i+1:n2
        if abs(B(i,j))>eps
            colG=zeros(n2,1);colG(i)=1; colG(j)=1;
            G2=[G2 colG];   Edge2=[Edge2;B(i,j)];    
        end
    end
end
gphs{2}.G=G2;
gphs{2}.H=[G2 eye(n2)];

end

function [K,KQ]=AffinityMatrices(A,B,Edge1,Edge2)

% Compute the edge affinity matrix KQ
Dist12=pdist2(Edge1,Edge2).^2;
KQ=exp(-Dist12/0.15);


% Compute the total affinity matrix K
n1=size(A,1); n2=size(B,1);
K = (repmat(A, n2, n2)-kron(B,ones(n1))).^2;
K = exp(-K./0.15);
K=K.*(kron(B,A)>eps);
K=(K+K')/2;

end

% This function is used to check the correctness of computed affinity
% matrix K gphs
function [Diff]=Check(KQ,K,gphs)

G1=sparse(gphs{1}.G);H1=sparse(gphs{1}.H);
G2=sparse(gphs{2}.G);H2=sparse(gphs{2}.H);

L=[KQ, -KQ*G2';
   -G1*KQ, G1*KQ*G2'];
L=sparse(L);
Knew=kron(H2,H1)*(diag(L(:)))*kron(H2,H1)';

Diff=norm(Knew-K,'fro');


end










