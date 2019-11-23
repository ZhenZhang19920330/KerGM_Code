function [AccTimeTotal_Dim]=CompareDims(A,B,GT,AccTimeTotal_Dim,irep, jvar)
% 1. Dim=2;
% 2. Dim=20;
% 3. Dim=100;
% 4. Dim=200;

% KerGM
lambda=0.005;num=11;para.gamma=10; 

%1
para.D=10;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_Dim{1}.res(irep,jvar)=acc;

%2
para.D=20;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_Dim{2}.res(irep,jvar)=acc;

%3
para.D=50;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_Dim{3}.res(irep,jvar)=acc;



end