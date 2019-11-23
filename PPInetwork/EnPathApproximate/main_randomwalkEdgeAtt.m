clear (); clc; close all;
load('graph_data.mat');

graph=cell(4,1);n=1004;nrep=1;
Abase=graph_data{1,4};
Acc=zeros(6,1);

lambda=0.005;num=11;Acc=zeros(6,nrep);Para.D=50;Para.gamma=200;time=5:5:20;
for i=1:6
    B=graph_data{i,4};
    seq = randperm(n);
    %seq=1:n;
    B(seq(1:n),seq(1:n))=Abase(1:n,1:n);

    % Ground Truth Matrix
    GT=zeros(n);
    for j=1:length(seq)
        GT(j,seq(j))=1;
    end
    [X,obj] = KerGM_Pathfollowing_RandFourierFeature(double(Abase),double(B),lambda,num,Para,time);
    Acc(i)=X(:)'*GT(:)/sum(GT(:))
end

meanAcc=mean(Acc);
disp(meanAcc);


