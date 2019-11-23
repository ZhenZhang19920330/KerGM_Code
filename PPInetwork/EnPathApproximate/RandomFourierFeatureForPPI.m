function [EdgeFeat1, EdgeFeat2,AA,BB]=RandomFourierFeatureForPPI(Adj1,Adj2,Para,time)
% This function is used to compute the approxiamte features of edge weights
% Input: 
%      Adj1, Adj2:     Two n*n adjacency matrices
%      Para:           Parameters for computing the approximate features
%        Para.D:       The dimension of features
%        Para.gamma:   The scale of features
%      step:           The step of random walks for computing edge
%                      attributes
% Output:
%      EdgeFeat1,2:    n*n*D tensor
%      AA, BB:         Two n*n matrices: AA=EdgeFeat1*EdgeFeat1, 
%                      BB=EdgeFeat2*EdgeFeat2

D=Para.D; gamma=Para.gamma;[n,~]=size(Adj1); 
E1=zeros(n,n,D);E2=zeros(n,n,D);

% generate random walk edge features
% [RwAtt1]=RandomWalkAtt(Adj1,step);
% [RwAtt2]=RandomWalkAtt(Adj2,step);

% generate heat kernel edge features
[Att1]=HeatAtt(Adj1,time);
[Att2]=HeatAtt(Adj2,time);

W=gamma*randn(D,length(time)); % generate samples w1,w2,...,w_D
B=rand(D,1)*2*pi;   % generate samples b1,b2,...,b_D

% Generate explicit random features
[E1]=ExplicitFeature(Att1,W,B,Adj1);
[E2]=ExplicitFeature(Att2,W,B,Adj2);
EdgeFeat1=cell(D,1); EdgeFeat2=cell(D,1);

for i=1:D
    EdgeFeat1{i}=E1(:,:,i);
    EdgeFeat2{i}=E2(:,:,i);
end

% Computing AA and BB
TempAA=cell(D,1);TempBB=cell(D,1);
for i=1:D
    TempAA{i}=EdgeFeat1{i}*EdgeFeat1{i};
    TempBB{i}=EdgeFeat2{i}*EdgeFeat2{i};
end

AA=zeros(n,n);BB=zeros(n,n);
for i=1:D
    AA=AA+TempAA{i};
    BB=BB+TempBB{i};
end

end

% function [RwAtt]=RandomWalkAtt(Adj,step)
% 
% n=size(Adj,1); RwAtt=zeros(n,n,step);
% Dvec=Adj*ones(n,1); P=diag(1./Dvec)*Adj; Pstep=P;
% for istep=1:step
%     RwAtt(:,:,istep)=full(Pstep.*(Adj>0));
%     Pstep=Pstep*P;
% end
% 
% end

function [Att]=HeatAtt(Adj,time)

T=time;
[n,~]=size(Adj);Att=zeros(n,n,length(time));
Dvec=Adj*ones(n,1); SqrtInvDvec=1./sqrt(Dvec);
L=eye(n)-diag(SqrtInvDvec)*Adj*diag(SqrtInvDvec);
L=(L+L')/2;

[U,D]=eig(L);

for istep=1:length(time)
    expD=exp(-T(istep)*diag(D));
    Temp=zeros(n,n);
    for ieig=1:n
        Temp=Temp+expD(ieig)*U(:,ieig)*U(:,ieig)';
    end
    Att(:,:,istep)=Temp;
end

end

function [ExpFeat]=ExplicitFeature(Att,W,B,Adj)

[n,~,~]=size(Att);D=length(B);ExpFeat=zeros(n,n,D);

for i=1:n
    for j=i+1:n
        if Adj(i,j)>0
            ExpFeat(i,j,:)=sqrt(2/D)*cos(W*squeeze(Att(i,j,:))+B);
            ExpFeat(j,i,:)=ExpFeat(i,j,:);
        end
    end
end


end