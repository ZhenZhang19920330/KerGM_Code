function [grad]=Gradient_Pathfollowing_RandFourierFeature(X,alpha,EdgeFeat1,EdgeFeat2,AA,BB)
% This function is used to compute the gradient
% Input:
%      X:                    Current Variable X
%      EdgeFeat1, EdgeFeat2: The edge feature tensor of graph1 and graph2
%      AA, BB:               Two n*n matrices: AA=EdgeFeat1*EdgeFeat1, 
%                            BB=EdgeFeat2*EdgeFeat2
% Output:
%      grad:  The gradient, i.e, 
%             grad=(1-2alpha)*EdgeFeat1*EdgeFeat1*X+...
%                  +(1-2alpha)*X*EdgeFeat2*EdgeFeat2+...
%                  -2*EdgeFeat1*X*EdgeFeat2

D=length(EdgeFeat1);
AXB=cell(D,1);
for i=1:D
    AXB{i}=EdgeFeat1{i}*X*EdgeFeat2{i};
end
[n,~]=size(AXB{1});TempAXB=zeros(n,n);

for i=1:D
    TempAXB=TempAXB+AXB{i};
end

AAX=AA*X; XBB=X*BB; AXB=TempAXB;

grad=(1-2*alpha)*AAX+(1-2*alpha)*XBB-2*AXB;

end