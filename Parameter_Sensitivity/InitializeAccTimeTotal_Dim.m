function [AccTimeTotal]=InitializeAccTimeTotal_Dim(nrep,nvar)
% 1. Dim=10;
% 2. Dim=20;
% 3. Dim=50;


AccTimeTotal=cell(1,4);
AccTimeTotal{1}.name='10';
AccTimeTotal{2}.name='20';
AccTimeTotal{3}.name='50';
for i=1:4
    AccTimeTotal{i}.res=zeros(nrep,nvar);
    AccTimeTotal{i}.time=zeros(nrep,nvar);
end

end