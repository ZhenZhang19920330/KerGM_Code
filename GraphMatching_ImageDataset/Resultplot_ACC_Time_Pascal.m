clear (); close all; clear;
savePath = './save/Pascal';
[avgAcc, avgObj, avgCT, total] = getResult(savePath);
fac = 0:2:20;

%% ACC
figure;
subplot(1,2,1);
hold on;
plot(fac, avgAcc.IpfpS, '-d', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0.4470 0.7410] , 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(fac, avgAcc.Rrwm, '-o', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4940 0.1840 0.5560] , 'MarkerFaceColor',[0.4940 0.1840 0.5560]);
plot(fac, avgAcc.Gagm, '-^', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.8500 0.3250 0.0980] , 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
plot(fac, avgAcc.FgmU, '-h', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4660 0.6740 0.1880] , 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
plot(fac, avgAcc.BpfG, '-s', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.9290 0.6940 0.1250] , 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
plot(fac, avgAcc.Kergm, '->', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0 0] , 'MarkerFaceColor',[0 0 0]);
axis([fac(1), fac(end), 0.1, 0.9]);
ap = get(gca, 'Position');
set(gca,'Xtick', fac, 'Ytick', [0:0.2:1], 'FontSize', 16,...
    'Position', [0.07 ap(2)+0.048 0.41, ap(4)*0.88]);
xlabel('outliers','FontSize',16,'FontWeight','bold' )
ylabel('Accuracy','FontSize',16,'FontWeight','bold' )
lgd=legend("IPFP", 'RRWM', "GAGM", "FGM", "BPFG", "$${\rm KerGM_I}$$",'Orientation', 'horizontal','Interpreter', 'latex');

lp = get(lgd, 'Position');
% center top
set(lgd, 'Position', [ap(1)-lp(3)/2+ap(3) ap(2)+ap(4)*0.98 lp(3) lp(4)], 'FontSize', 16);
hold off;

%% CT
maxv = ceil(max([max(avgCT.Kergm), max(avgCT.FgmU), max(avgCT.Gagm), max(avgCT.Gnccp),max(avgCT.BpfG)]));
minv = 0;
step = (maxv-minv) / 10;
subplot(1,2,2);
hold on;
plot(fac, avgCT.IpfpS, '-d', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0.4470 0.7410] , 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(fac, avgCT.Rrwm, '-o', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4940 0.1840 0.5560] , 'MarkerFaceColor',[0.4940 0.1840 0.5560]);
plot(fac, avgCT.Gagm, '-^', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.8500 0.3250 0.0980] , 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
plot(fac, avgCT.FgmU, '-h', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4660 0.6740 0.1880] , 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
plot(fac, avgCT.BpfG, '-s', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.9290 0.6940 0.1250] , 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
plot(fac, avgCT.Kergm, '->', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0 0] , 'MarkerFaceColor',[0 0 0]);

axis([fac(1), fac(end), 0, 950]);
set(gca,'Xtick', fac, 'Ytick', 0:100:1000, 'FontSize', 16,...
    'Position', [0.57 ap(2)+0.048 0.41, ap(4)*0.88]);
xlabel('outliers','FontSize',16, 'FontWeight','bold' )
ylabel('time (s)','FontSize',16, 'FontWeight','bold' )
hold off;
set(gcf, 'Position', [100 200 1100 400]);

%% getResult
function [avgAcc, avgObj, avgCT,total] = getResult(savePath)
avgAcc.Kergm      = zeros(1, 11);
avgAcc.Gnccp    = zeros(1, 11);
avgAcc.IpfpS    = zeros(1, 11);
avgAcc.Rrwm     = zeros(1, 11);
avgAcc.FgmU     = zeros(1, 11);
avgAcc.Gagm     = zeros(1, 11);
avgAcc.BpfG     = zeros(1, 11);

total.Kergm=zeros(50,11);
total.Gnccp=zeros(50,11);
total.IpfpS=zeros(50,11);
total.Rrwm=zeros(50,11);
total.FgmU=zeros(50,11);
total.Gagm=zeros(50,11);
total.BpfG=zeros(50,11);


avgObj = avgAcc;
avgCT  = avgAcc;

t = 0;
for cImg = 1:50
    t = t + 1;
    if cImg <= 20
        smat_ipfps = sprintf('%s/Motor%02d_ipfps.mat', savePath, cImg);
        smat_Kergm = sprintf('%s/Motor%02d_Kergm.mat', savePath, cImg);
        smat_rrwm = sprintf('%s/Motor%02d_rrwm.mat', savePath, cImg);
        smat_BpfG = sprintf('%s/Motor%02d_bpfG.mat', savePath, cImg);
        smat_gnccp = sprintf('%s/Motor%02d_gnccp.mat', savePath, cImg);
        smat_fgm = sprintf('%s/Motor%02d_fgm.mat', savePath, cImg);
        smat_gagm = sprintf('%s/Motor%02d_gagm.mat', savePath, cImg);
    else
        smat_ipfps = sprintf('%s/Car%02d_ipfps.mat', savePath, cImg - 20);
        smat_Kergm = sprintf('%s/Car%02d_Kergm.mat', savePath, cImg - 20);
        smat_rrwm = sprintf('%s/Car%02d_rrwm.mat', savePath, cImg - 20);
        smat_BpfG = sprintf('%s/Car%02d_bpfG.mat', savePath, cImg - 20);
        smat_gnccp = sprintf('%s/Car%02d_gnccp.mat', savePath, cImg - 20);
        smat_fgm = sprintf('%s/Car%02d_fgm.mat', savePath, cImg - 20);
        smat_gagm = sprintf('%s/Car%02d_gagm.mat', savePath, cImg - 20);
    end
    load(smat_ipfps);
    load(smat_Kergm);
    load(smat_rrwm);
    load(smat_gnccp);
    load(smat_fgm);
    load(smat_gagm);
    load(smat_BpfG);
    for i = 1:11
        avgCT.Kergm(i)  = avgCT.Kergm(i)  + asgKergm{i}.tm;
        avgAcc.Kergm(i) = avgAcc.Kergm(i) + asgKergm{i}.acc;
        avgObj.Kergm(i) = avgObj.Kergm(i) + asgKergm{i}.obj;
        total.Kergm(cImg,i) = asgKergm{i}.acc;
        
        avgCT.Gnccp(i) = avgCT.Gnccp(i) + asgGnccp{i}.tm;
        avgAcc.Gnccp(i) = avgAcc.Gnccp(i) + asgGnccp{i}.acc;
        avgObj.Gnccp(i) = avgObj.Gnccp(i) + asgGnccp{i}.obj;
        total.Gnccp(cImg, i) = asgGnccp{i}.acc;
        
        avgCT.BpfG(i) = avgCT.BpfG(i) + asgBpfG{i}.tm;
        avgAcc.BpfG(i) = avgAcc.BpfG(i) + asgBpfG{i}.acc;
        avgObj.BpfG(i) = avgObj.BpfG(i) + asgBpfG{i}.obj;
        total.BpfG(cImg, i) = asgBpfG{i}.acc;
        
        avgCT.IpfpS(i) = avgCT.IpfpS(i) + asgIpfpS{i}.tm;
        avgAcc.IpfpS(i) = avgAcc.IpfpS(i) + asgIpfpS{i}.acc;
        avgObj.IpfpS(i) = avgObj.IpfpS(i) + asgIpfpS{i}.obj;
        total.IpfpS(cImg, i)=asgIpfpS{i}.acc;
        
        avgCT.Rrwm(i) = avgCT.Rrwm(i) + asgRrwm{i}.tm;
        avgAcc.Rrwm(i) = avgAcc.Rrwm(i) + asgRrwm{i}.acc;
        avgObj.Rrwm(i) = avgObj.Rrwm(i) + asgRrwm{i}.obj;
        total.Rrwm(cImg, i) = asgRrwm{i}.acc;
        
        avgCT.FgmU(i) = avgCT.FgmU(i) + asgFgm{i}.tm;
        avgAcc.FgmU(i) = avgAcc.FgmU(i) + asgFgm{i}.acc;
        avgObj.FgmU(i) = avgObj.FgmU(i) + asgFgm{i}.obj;
        total.FgmU(cImg, i) = asgFgm{i}.acc;
        
        avgCT.Gagm(i) = avgCT.Gagm(i) + asgGagm{i}.tm;
        avgAcc.Gagm(i) = avgAcc.Gagm(i) + asgGagm{i}.acc;
        avgObj.Gagm(i) = avgObj.Gagm(i) + asgGagm{i}.obj;
        total.Gagm(cImg, i) = asgGagm{i}.acc;
    end
end

% avgAcc.Kergm = avgAcc.Kergm / t;
% avgAcc.Gnccp = avgAcc.Gnccp / t;
% avgAcc.IpfpS = avgAcc.IpfpS / t;
% avgAcc.Rrwm = avgAcc.Rrwm / t;
% avgAcc.FgmU = avgAcc.FgmU / t;
% avgAcc.Gagm = avgAcc.Gagm / t;
% avgAcc.BpfG = avgAcc.BpfG / t;

avgAcc.Kergm = mean(total.Kergm);
avgAcc.Gnccp = mean(total.Gnccp);
avgAcc.IpfpS = mean(total.IpfpS);
avgAcc.Rrwm = mean(total.Rrwm);
avgAcc.FgmU = mean(total.FgmU);
avgAcc.Gagm = mean(total.Gagm);
avgAcc.BpfG= mean(total.BpfG);

avgObj.Kergm = avgObj.Kergm / t;
avgObj.Gnccp = avgObj.Gnccp / t;
avgObj.IpfpS = avgObj.IpfpS / t;
avgObj.Rrwm = avgObj.Rrwm / t;
avgObj.FgmU = avgObj.FgmU / t;
avgObj.Gagm = avgObj.Gagm / t;
avgObj.BpfG = avgObj.BpfG / t;

avgCT.Kergm = avgCT.Kergm / t;
avgCT.Gnccp = avgCT.Gnccp / t;
avgCT.IpfpS = avgCT.IpfpS / t;
avgCT.Rrwm = avgCT.Rrwm / t;
avgCT.FgmU = avgCT.FgmU / t;
avgCT.Gagm = avgCT.Gagm / t;
avgCT.BpfG = avgCT.BpfG / t;

end







