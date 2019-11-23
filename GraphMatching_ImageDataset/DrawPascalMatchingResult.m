%% Main function for draw pascal
%% Motorbike
cImg=1;
% load Motor images 
dataPath1 = './data/Pascal/Motorbikes';
savePath = './save/Pascal';
fmat = sprintf('%s/pair_%d.mat', dataPath1, cImg);

% load Motor graphs
graphPath = './data/Pascal/Graphs';
gmat = sprintf('%s/Motor%02d.mat', graphPath, cImg);
load(gmat);
gphs1=GRAPH{1,1}.gphs{1,1};
gphs2=GRAPH{1,1}.gphs{1,2};
X_GT=GRAPH{1,1}.X_GT;

% load KerGM matching results for Motor
smat_Kergm= sprintf('%s/Motor%02d_Kergm.mat', savePath, cImg);
load(smat_Kergm);
X=asgKergm{1}.X;
figure;
drawPascalMatches(fmat, gphs1, gphs2, X, X_GT);

%% Car
cImg=27;
% load car images 
dataPath2 = './data/Pascal/Cars';
savePath = './save/Pascal';
fmat = sprintf('%s/pair_%d.mat', dataPath2, cImg-20);

% load car graphs
graphPath = './data/Pascal/Graphs';
gmat = sprintf('%s/Car%02d.mat', graphPath, cImg - 20);
load(gmat);
gphs1=GRAPH{1,1}.gphs{1,1};
gphs2=GRAPH{1,1}.gphs{1,2};
X_GT=GRAPH{1,1}.X_GT;

% load KerGM matching results for car
smat_Kergm= sprintf('%s/Car%02d_Kergm.mat', savePath, cImg-20);
load(smat_Kergm);
X=asgKergm{1}.X;
figure;
drawPascalMatches(fmat, gphs1, gphs2, X, X_GT);

