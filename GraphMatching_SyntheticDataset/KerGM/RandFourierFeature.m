function [EdgeFeat1, EdgeFeat2,AA,BB]=RandFourierFeature(Adj1,Adj2,Para)
% This function is used to compute the approxiamte features of edge weights
% Input: 
%      Adj1, Adj2:     Two n*n adjacency matrices
%      Para:           Parameters for computing the approximate features
%        Para.D:       The dimension of features
%        Para.gamma:   The scale of features
% Output:
%      EdgeFeat1,2:    n*n*D tensor
%      AA, BB:         Two n*n matrices: AA=EdgeFeat1*EdgeFeat1, 
%                      BB=EdgeFeat2*EdgeFeat2

D=Para.D; gamma=Para.gamma;
W=gamma*randn(D,1); % generate samples w1,w2,...,w_D
B=rand(D,1)*2*pi;   % generate samples b1,b2,...,b_D


[n,~]=size(Adj1); E1=zeros(n,n,D);E2=zeros(n,n,D);

for i=1:D
    
    % Random Fourier Edge Features for Graph1
    Temp1=sqrt(2/D)*cos(W(i)*Adj1+B(i));
    Temp1=((Temp1+Temp1')/2).*(Adj1>eps);
    E1(:,:,i)=Temp1;
    
    % Random Fourier Edge Features for Graph2
    Temp2=sqrt(2/D)*cos(W(i)*Adj2+B(i));
    Temp2=((Temp2+Temp2')/2).*(Adj2>eps);
    E2(:,:,i)=Temp2;
    
end

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