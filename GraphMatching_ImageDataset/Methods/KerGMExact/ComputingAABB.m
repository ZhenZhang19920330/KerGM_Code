function [AA,BB]=ComputingAABB(gph1,gph2)
% Computing AA=H1((G1'*G1).*K1)H1'+H1((G1'*H1).*K1)G1'
%              +G1((H1'*G1).*K1)H1'+G1((H1'*H1).*K1)G1'
%           BB=H2((G2'*G2).*K2)H2'+H2((G2'*H2).*K2)G2'
%              +G2((H2'*G2).*K2)H2'+G1((H1'*H1).*K1)G2'
% Input:
%      1.   gph1.G:  n*m1 G-incidence matrix for graph 1
%           gph1.H:  n*m1 H-incidence matrix for graph 2
%           gph1.K:  m1*m1 matrix,self-edge affinity matrix, for
%                      computing  AA=Phi(A)*Phi(A)
%                      AA=H1((G1'*G1).*K1)H1'+H1((G1'*H1).*K1)G1'
%                         +G1((H1'*G1).*K1)H1'+G1((H1'*H1).*K1)G1'
%      2.   Similar explaination for gph2

% Output:   n*n matrix AA and BB

G1=gph1.G;H1=gph1.H; G2=gph2.G;H2=gph2.H;
K1=gph1.K; K2=gph2.K;

 % computing AA
 ele1=ElementAABB(H1,G1,G1,H1,K1);
 ele2=ElementAABB(H1,G1,H1,G1,K1);
 ele3=ElementAABB(G1,H1,G1,H1,K1);
 ele4=ElementAABB(G1,H1,H1,G1,K1);
 AA=ele1+ele2+ele3+ele4;
 
 % computing BB
 ele1=ElementAABB(H2,G2,G2,H2,K2);
 ele2=ElementAABB(H2,G2,H2,G2,K2);
 ele3=ElementAABB(G2,H2,G2,H2,K2);
 ele4=ElementAABB(G2,H2,H2,G2,K2);
 BB=ele1+ele2+ele3+ele4;

end

function [ele]=ElementAABB(A1,B1,A2,B2,K)
% Computing ele=A1*((B1'*A2).*K)*B2'

% compute b1a2=B1'*A2;
[ind,~]=find(B1==1);
b1a2=A2(ind,:);

% result
ele=A1*(b1a2.*K)*B2';
end
