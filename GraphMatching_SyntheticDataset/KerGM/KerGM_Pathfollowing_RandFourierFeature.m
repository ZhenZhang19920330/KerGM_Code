function [OptX,obj] = KerGM_Pathfollowing_RandFourierFeature(Adj1,Adj2,lambda,num,Para)
% Entropy-regularized path graph matching, solve the following sequence of
% optimization problems

% Min   F_alpha(X)=(1-alpha)F_vex(X)+alpha*F_cave(X)+lambda*h(X)
% s.t.  X1=1,X'1=1,X>=0(elementwise)

% F_vex(X)=0.5*||Phi(A)*X-X*Phi(B)||^2_"fro"
% F_cave(X)=-0.5*||Phi(A)*X+X*Phi(B)||^2_"fro"

% Input: 
%        adjacent matrices: Adj1 (n1*n1), and Adj2 (n2*n2).
%        regularizer:       lambda. 
%        num:               The number of optimization problems
%                           parameterized by alpha.
%        Para:              Parameters for computing the approximate
%                           features.
%           Para.D:         The dimension of features.
%           Para.gamma:     The scale of features.
% Output:
%        Matching matrix: OptX (n1*n2)
%        objective score: obj=x*K*x   (Here we use the non-regualarized
%                         and positive version, and x is permutation matrix).

%addpath('./AssignmentOptimal/');

global EdgeFeat1 EdgeFeat2 AA BB;
[n1,~]=size(Adj1); [n2,~]=size(Adj2); n=max(n1,n2);

% make the sizes equal
Adj1=[Adj1,           zeros(n1,n-n1);
      zeros(n-n1,n1), zeros(n-n1,n-n1)];
Adj2=[Adj2,           zeros(n2,n-n2);
      zeros(n-n2,n2), zeros(n-n2,n-n2)];
  
% Random Fourier Features for edges, based on the kernel k(q1, q2) = exp(-(q1-q2)^2/0.15)
[EdgeFeat1,EdgeFeat2,AA,BB]=RandFourierFeature(Adj1,Adj2,Para);

AlphaVec=linspace(0,1,num);

% Initialization
X=ones(n1)/(n1*n1);
% Path Optimization procedure
obj=0;
for i=1:num
    alpha=AlphaVec(i);
    [Xnew,val]=Entropy_FrankWolfe(alpha,X,lambda,1000); 
    if obj>val
        [Xnew,val]=Entropy_FrankWolfe(0.5,Xnew,lambda,1000); 
    end
    obj=val;
    fprintf('alpha=%f finished\n',alpha);
    X=Xnew;
end

% Greedy Discretization
% OptX=zeros(n);
% for i=1:n
%     [~,idx]=max(X(i,:));
%     OptX(i,idx)=1;
% end

% Hungarian Discretization
X=-X; X=X-min(X(:));
[seq, ~]=assignmentoptimal(X);

OptX = eye(n);
OptX = OptX(seq,:);

% Compute the objective function value x'*K*x
obj=evalobjective(OptX);

% Resize
OptX=OptX(1:n1,1:n2);

end


function  [optX,val]=Entropy_FrankWolfe(alpha,X0,lambda,MaxOut)
% This function is the Entropic Wolf-Frank Algorithm for solving the
% alpha-parameterized optimization problem

% Min   F_alpha(X)=(1-alpha)F_vex(X)+alpha*F_cave(X)+lambda*h(X)
% s.t.  X1=1/n;X'1=1/n;

% F_vex(X)=0.5*||Phi(A)*X-X*Phi(B)||_"fro"
% F_cave(X)=-0.5*||Phi(A)*X+X*Phi(B)||_"fro"

global EdgeFeat1 EdgeFeat2 AA BB;

OutIter=0; OutTolerance=10^(-8); Diff=1;

X=X0; [n,~]=size(X); r=ones(n,1)/n;c=1;% Initialization
grad=Gradient_Pathfollowing_RandFourierFeature(X,alpha,EdgeFeat1,EdgeFeat2,AA,BB);
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
    grad=grad+s*gradY_X; % Trick: by the linearity of gradient
    OutIter=OutIter+1;
       
end

optX=X;
val=evalobjective(X);

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
%     if Iter==MaxIter
%         fprintf('Achieve the maximal (sinkhorn) iteration number\n');
%     end
    
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

global EdgeFeat1 EdgeFeat2 AA BB;

% f(Z)=<gradX,Z>+lambda*h(Z)
f=@(Z) sum(sum(gradX.*Z))+lambda*sum(sum(Z.*log(Z+eps)));
c=f(X)-f(Y); % This is the duality gap

gradY_X=Gradient_Pathfollowing_RandFourierFeature(Y-X,alpha,EdgeFeat1,EdgeFeat2,AA, BB);
Q=0.5*sum(sum(gradY_X.*(Y-X)));% Compute Q

if Q>eps
    s=min(c/(2*Q),1);
else
    s=1;
end 

end

function [obj]=evalobjective(X)
% This function is used to compute obj=x*K*x, given the optimal X
global EdgeFeat1 EdgeFeat2;

GradOpt=Gradient_Pathfollowing_RandFourierFeature(X,0.5,EdgeFeat1,EdgeFeat2,eye(size(X, 1)), eye(size(X, 1)));
% Note that eye(size(X, 1)) will be not used here, since alpha = 0.5

obj=-sum(sum(GradOpt.*X))/2;
end
