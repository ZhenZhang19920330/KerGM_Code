function [Graph1,Graph2]=Preprocessing(gphs)
g1=gphs{1,1};g2=gphs{1,2};
[~,m1]=size(g1.G);
[~,m2]=size(g2.G);

Edge1=g1.dsts(1:m1)';
Edge2=g2.dsts(1:m2)';

sigma=2500;
dist11=pdist2(Edge1,Edge1).^2;Graph1.K=exp(-dist11/sigma);
dist22=pdist2(Edge2,Edge2).^2;Graph2.K=exp(-dist22/sigma);


Graph1.G=zeros(size(g1.G));
Graph1.H=zeros(size(g1.G));
Graph2.G=zeros(size(g2.G));
Graph2.H=zeros(size(g2.G));
for i=1:m1
    x=find(g1.G(:,i)==1);
    Graph1.G(x(1),i)=1;
    Graph1.H(x(2),i)=1;
end

for i=1:m2
    x=find(g2.G(:,i)==1);
    Graph2.G(x(1),i)=1;
    Graph2.H(x(2),i)=1;
end

end