function [grad]=Gradient_alpha05(X,EdgeFeat1,EdgeFeat2)
% This function is used to compute the gradient
% Input:
%      EdgeFeat1, EdgeFeat2: The edge feature tensor of graph1 and graph2
% Output:
%      grad:  The gradient, i.e, grad=-2*EdgeFeat1*X*EdgeFeat2

D=length(EdgeFeat1);AXB=cell(D,1);
for i=1:D
    AXB{i}=EdgeFeat1{i}*X*EdgeFeat2{i};
end
[n,~]=size(AXB{1});TempAXB=zeros(n,n);

for i=1:D
    TempAXB=TempAXB+AXB{i};
end
AXB=TempAXB;

% [D,~]=size(EdgeFeat1);
% Z=zeros(n,n,D);
% 
% for i=1:D
%     Z(:,:,i) = EdgeFeat1(:,:,i)*X*EdgeFeat2(:,:,i); 
% end 
% 
grad=-2*AXB;

end