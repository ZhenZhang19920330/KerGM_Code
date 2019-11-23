function [AccTimeTotal_lambda]=CompareLambdas(A,B,GT,AccTimeTotal_lambda,irep, jvar)

% KerGM
 num=11;para.gamma=10; para.D=20;

t0=cputime;
lambda=0.005;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{1}.res(irep,jvar)=acc;
AccTimeTotal_lambda{1}.time(irep,jvar)=cputime-t0;


t0=cputime;
lambda=0.006;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{2}.res(irep,jvar)=acc;
AccTimeTotal_lambda{2}.time(irep,jvar)=cputime-t0;


t0=cputime;
lambda=0.007;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{3}.res(irep,jvar)=acc;
AccTimeTotal_lambda{3}.time(irep,jvar)=cputime-t0;


t0=cputime;
lambda=0.008;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{4}.res(irep,jvar)=acc;
AccTimeTotal_lambda{4}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.009;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{5}.res(irep,jvar)=acc;
AccTimeTotal_lambda{5}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.01;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{6}.res(irep,jvar)=acc;
AccTimeTotal_lambda{6}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.012;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{7}.res(irep,jvar)=acc;
AccTimeTotal_lambda{7}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.016;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{8}.res(irep,jvar)=acc;
AccTimeTotal_lambda{8}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.02;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{9}.res(irep,jvar)=acc;
AccTimeTotal_lambda{9}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.03;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{10}.res(irep,jvar)=acc;
AccTimeTotal_lambda{10}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.04;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{11}.res(irep,jvar)=acc;
AccTimeTotal_lambda{11}.time(irep,jvar)=cputime-t0;

t0=cputime;
lambda=0.05;
[X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
acc=X(:)'*GT(:)/sum(GT(:));
AccTimeTotal_lambda{12}.res(irep,jvar)=acc;
AccTimeTotal_lambda{12}.time(irep,jvar)=cputime-t0;


end