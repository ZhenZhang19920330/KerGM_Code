function [AccTimeTotal]=InitializeAccTimeTotal_lambda(nrep,nvar, num)

AccTimeTotal=cell(1,num);

for i=1:num
    AccTimeTotal{i}.res=zeros(nrep,nvar);
    AccTimeTotal{i}.time=zeros(nrep,nvar);
end
AccTimeTotal{1}.name='\lambda=0.005';
AccTimeTotal{2}.name='\lambda=0.006';
AccTimeTotal{3}.name='\lambda=0.007';
AccTimeTotal{4}.name='\lambda=0.008';
AccTimeTotal{5}.name='\lambda=0.009';
AccTimeTotal{6}.name='\lambda=0.01';
AccTimeTotal{7}.name='\lambda=0.012';
AccTimeTotal{8}.name='\lambda=0.016';
AccTimeTotal{9}.name='\lambda=0.02';
AccTimeTotal{10}.name='\lambda=0.03';
AccTimeTotal{11}.name='\lambda=0.04';
AccTimeTotal{12}.name='\lambda=0.05';
end