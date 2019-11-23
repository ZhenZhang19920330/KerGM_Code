function [grad]=GradientExactPath(alpha,X,gph1,gph2,Kp,Kq,AA,BB)
% This function  is used to compute the gradient parameterized by alpha

% grad = (0.5-alpha)*(2AAX)+(0.5-alpha)*(2XBB)-2AXB-Kp.

% alpha=0: convex relaxation
% alpha=1: concave relaxation

% Input:
%      alpha:               path parameter
%      X:                   current value
%      global variables:    gph1,gph2,Kq,Kp,AA,BB

% Output: 
%      grad:     gradient

% Computation:
% AAX=AA*X; XBB=X*BB;
% AXB=H1*((G1'*X*G2).*KAB)*H2'+H1*((G1'*X*H2).*KAB)*G2'...
%     +G1*((H1'*X*G2).*KAB)*H2'+G1*((H1'*X*H2).*KAB)*G2'

G1=gph1.G; H1=gph1.H;
G2=gph2.G; H2=gph2.H;

% Compute AAX and XBB
AAX=AA*X; XBB=X*BB;
% Compute AXB
AXB1=ElementAXB(X,H1,G1,G2,H2,Kq);
AXB2=ElementAXB(X,H1,G1,H2,G2,Kq);
AXB3=ElementAXB(X,G1,H1,G2,H2,Kq);
AXB4=ElementAXB(X,G1,H1,H2,G2,Kq);
AXB=AXB1+AXB2+AXB3+AXB4;

grad=(0.5-alpha)*(2*AAX)+(0.5-alpha)*(2*XBB)-2*AXB-Kp;


end

function [grad_element]=ElementAXB(X,A1,B1,A2,B2,Kq)
% This function is used to compute A1*((B1'*X*A2).*Kq)*B2'

%1. compute B1'*X: for each row of B1' (m row, n col), we need to find the position of 1
[ind,~]=find(B1==1);
b1x=X(ind,:);

%2. Compute (B1'*X)*A2: for each col of A2 (n row, m col), we need to find the position of 1
[ind,~]=find(A2==1);
b1xa2=b1x(:,ind);
clear b1x;

%3. Compute the middle term (B1'*X*A2).*Kq
middle=b1xa2.*Kq;
clear blxa2;
%4. Compute the final result
grad_element=A1*middle*B2';
clear middle;

end
