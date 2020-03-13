% In this script, we provide a toy example to show how KerGM is applied to 
% matching two weighted graphs G_a and G_b

% The inputs are:
%       two adjacent matrices:  A and B;
%       some hyper parameters:  lambda, num, para = {para.gamma, para.D}

% The outputs X is the matching matrix between G_a and G_b. The following
% is the detailed explanation.
% Suppose G_a has n1 nodes, G_b has n2 nodes,
% Then X is a n1*n2 matrix X_{ij} = 1 iff the ith node in G_a is matched with
% the jth node in G_b.

% Recommed parameters:  lambda = 0.005
%                       num    = 11
%                       para.D can be chosen in {10, 20, 50, 100}, we suggest para.D = 20 
%                       para.gamma can be chosen in {0.01, 0.1, 1, 5, 10, 50, 100}

%  [X,~]=KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);

% If you have any questions or comments, feel free to email
% zhen.zhang@wustl.edu. Thanks.

%% The following is a example of matching two synthetic graphs.
% We first generate two synthetic graphs with adjacent matrices A and B.
% Note that A, B are two adjacent matrices, GT is the ground-truth matching
% matrix.

inlier = 50; outlier = 10; density =1; deformation = 0;
[A,B,GT,~,~,~] = GenerateRandGraph(inlier,outlier,density,deformation);

% We then apply KerGM to match graph_a and graph_b. If we already have two
% adjacent matrices, you can directly replace A and B.
% parameter setting: 
lambda = 0.005; num =11; para.gamma = 10; para.D = 20;
% addpath
addpath('./KerGM');
tic;
[X,~] = KerGM_Pathfollowing_RandFourierFeature(A,B,lambda,num,para);
toc;

% Since we have the ground-truth for this mannually generated example, we
% can compute the matching accuracy.

idx = find(GT);
co = length(find(GT(idx) == X(idx)));
accuracy = co / length(idx)*100; % in percentage

display(accuracy)






