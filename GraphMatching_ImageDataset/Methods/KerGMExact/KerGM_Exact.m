function [OptX,obj]=KerGM_Exact(Graph1,Graph2,KP,KQ,lambda,num)
% Entropy-regularized path graph matching, solve the following sequence of
% optimization problems

% Min   F_alpha(X)=(1-alpha)F_vex(X)+alpha*F_cave(X)-<Kp,X>+lambda*h(X)
% s.t.  X1=1,X'1=1,X>=0(elementwise)

% F_vex(X)=0.5*||Phi(A)*X-X*Phi(B)||^2_"fro"
% F_cave(X)=-0.5*||Phi(A)*X+X*Phi(B)||^2_"fro"

% Input: 
%      1.   Graph1.G:  n1*m1 G-incidence matrix for graph 1
%           Graph1.H:  n1*m1 H-incidence matrix for graph 2
%           Graph1.K:  m1*m1 matrix,self-edge affinity matrix, for
%                      computing  AA=Phi(A)*Phi(A)
%                      AA=H1((G1'*G1).*K1)H1'+H1((G1'*H1).*K1)G1'
%                         +G1((H1'*G1).*K1)H1'+G1((H1'*H1).*K1)G1'
%      2.   Similar explaination for Graph2
%      3.   KP:        n1*n2 cross node affinity matrix
%      4.   KQ:        m1*m2 cross edge affinity matrix
%      5.   lambda:    regularizer 
%      6.   num:       The number of optimization problems parameterized by alpha.
% Output:
%      1.   Matching matrix: OptX (n1*n2)
%      2.   objective score: obj=x*K*x=trace[Phi(A)*X*Phi(B)*X']+trace(Kp'*X)  (Here we use the non-regualarized
%                         and positive version, and x is permutation matrix).

global gph1 gph2 Kp Kq AA BB;
gph1=Graph1; gph2=Graph2; Kp=KP;Kq=KQ; clear Graph1 Graph2 KP KQ;

[n1,m1]=size(gph1.G); [n2,m2]=size(gph2.G); n=max(n1,n2);Kp=Kp/n;

% Make the sizes equal
gph1.G=[gph1.G;zeros(n-n1,m1)];
gph1.H=[gph1.H;zeros(n-n1,m1)];
gph2.G=[gph2.G;zeros(n-n2,m2)];
gph2.H=[gph2.H;zeros(n-n2,m2)];

Kp=[Kp, zeros(n1,n-n2);
    zeros(n-n1,n2), zeros(n-n1,n-n2)];

% Computing AABB
[AA,BB]=ComputingAABB(gph1,gph2);

AlphaVec=linspace(0,1,num);
% Initialization
X=ones(n)/(n*n);
% Path Optimization procedure
obj=0;

for i=1:num
    alpha=AlphaVec(i);
    [Xnew,val]=EntropyWF(alpha,X,lambda,1000);
    if obj>val
        [Xnew,val]=EntropyWF(0.5,Xnew,lambda,1);
    end
    fprintf('alpha=%f finished\n',alpha);
    X=Xnew;
    obj=val;
end

% Hungarian Discretization
X=-X; X=X-min(X(:));
[seq, ~]=assignmentoptimal(X);

OptX = eye(n);
OptX = OptX(seq,:);

% Compute the objective function value 
%obj=x*K*x=trace[Phi(A)*X*Phi(B)*X']+trace(Kp'*X)
obj=evalobjective(OptX);
% Resize
OptX=OptX(1:n1,1:n2);

end

function  [optX,val]=EntropyWF(alpha,X0,lambda,MaxOut)
% This function is the Entropic Wolf-Frank Algorithm for solving the
% alpha-parameterized optimization problem

% Min   F_alpha(X)=(1-alpha)F_vex(X)+alpha*F_cave(X)-<Kp,X>+lambda*h(X)
% s.t.  X1=1/n;X'1=1/n;

% F_vex(X)=0.5*||Phi(A)*X-X*Phi(B)||_"fro"
% F_cave(X)=-0.5*||Phi(A)*X+X*Phi(B)||_"fro"

global gph1 gph2 Kp Kq AA BB;

OutIter=0; OutTolerance=10^(-8); Diff=1;

X=X0; [n,~]=size(X); r=ones(n,1)/n;c=1;% Initialization
grad=GradientExactPath(alpha,X,gph1,gph2,Kp,Kq,AA,BB);
while OutIter<MaxOut && Diff>=OutTolerance && c>=eps
    
    % Generalized Conditional Gradient Descent algorithm
    [Y,r]=Sinkhorn(grad,lambda,10^(-6),r);
    [s,c,gradY_X]=stepsize(alpha,X,Y,lambda,grad);
    if c<eps
        break;
    end
    Xnew=X+s*(Y-X);
    
    % Compute the relative difference
    Diff=norm(Xnew-X,'fro')/norm(X,'fro');
    X=Xnew;
    grad=grad+s*gradY_X+s*Kp; % Trick: by the linearity of gradient
    OutIter=OutIter+1;
       
end

optX=X;
val=evalobjective(size(X,1)*X);
end

function [OptX,Upr]=Sinkhorn(grad,lambda,Tolerance,r)
% Solving the following problem with the Sinkhorn Algorithm
% Min    <grad, X>+lambda*h(X)
% s.t.   X1=1/n;X'1=1/n;X>=0;

% The problem is equal to 
% Min  sum_{i,j} X_ij*log(X_ij/C_ij)   X and C are  n*n matrices
% s.t. X*1=1/n;  X'*1=1/n;  X>=0 (element-wise)
% C=exp(-grad/lambda)

% The solution can be written as OptX=diag(r)*C*diag(s), where r is an n*1
% vector and s is an n*1 vector, and both r and s are nonnegative

% Input: 
%       grad:          The gradient of x'*K*x
%       lambda:        The regularizer parameter
%       Tolerance:     Stopping criterion
%       r:             The intial value of the dual variable

% Output: 
%       OptX:          The optimal solution
%        Upr:          The updated r

Iter=0;diff=1;MaxIter=10000;% maximal iteration number

n=length(r); onevec=ones(n,1)/n;
Temp=-grad/lambda;med=median(Temp(:)); Temp=Temp-med;
C=exp(Temp);
while (Iter<MaxIter) && (diff>Tolerance)
    
    rnew=onevec./(C*(onevec./(C'*r)));
    diff=norm(rnew-r,1)/norm(r,1);
    r=rnew;
    Iter=Iter+1;
%      if Iter==MaxIter
%          fprintf('Achieve the maximal (sinkhorn) iteration number\n');
%      end
%     
end

Upr=r;
s=onevec./(C'*r);
OptX=(r.*C).*(s');
%fvalue=sum(sum(OptX.*(log(OptX./C))));
%fprintf('There are %d sinkhorn iterations in total\n', Iter);

end

function [s,c,gradY_X]=stepsize(alpha,X,Y,lambda,gradX)
% Deriving the stepsize for the EnGM with the following rule

% Define c=[<gradX,X>+lambda*h(X)]-[<gradX,Y>+lambda*h(Y)], which is the
% gap and should be greater than 0.
% The quadratic term (w.r.t s) is Q=0.5*<Y-X,grad(Y-X)>

% So if Q<0:  s=1
%    if Q>0:  s=c/(2*Q)

global gph1 gph2 Kp Kq AA BB;

% f(Z)=<gradX,Z>+lambda*h(Z)
f=@(Z) sum(sum(gradX.*Z))+lambda*sum(sum(Z.*log(Z+eps)));
c=f(X)-f(Y); % This is the duality gap

gradY_X=GradientExactPath(alpha,Y-X,gph1,gph2,Kp,Kq,AA,BB);
Q=0.5*sum(sum((gradY_X+Kp).*(Y-X)));% Compute Q

if Q>eps
    s=min(c/(2*Q),1);
else
    s=1;
end 

end

function [obj]=evalobjective(X)
% This function is used to compute obj=x*K*x, given the optimal X
global gph1 gph2 Kp Kq AA BB;

GradOpt=GradientExactPath(0.5,X,gph1,gph2,Kp,Kq,AA,BB);
obj=-sum(sum((GradOpt+Kp).*X))/2+sum(sum(Kp.*X))*size(Kp,1);
end



