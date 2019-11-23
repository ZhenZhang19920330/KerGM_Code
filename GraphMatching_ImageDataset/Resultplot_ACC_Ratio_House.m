

n1=20;

start = 0.042;
width = 0.193;

[avgAcc, avgObj, avgTm] = calcResults(n1);
%% ACC
figure;

fac = 10:10:100;
subplot(1,4,1);
hold on;
plot(fac, avgAcc.IpfpS, '-d', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0.4470 0.7410] , 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(fac, avgAcc.Rrwm, '-o', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4940 0.1840 0.5560] , 'MarkerFaceColor',[0.4940 0.1840 0.5560]);
plot(fac, avgAcc.Gagm, '-^', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.8500 0.3250 0.0980] , 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
plot(fac, avgAcc.FgmU, '-h', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4660 0.6740 0.1880] , 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
plot(fac, avgAcc.BpfG, '-s', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.9290 0.6940 0.1250] , 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
plot(fac, avgAcc.Kergm, '->', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0 0] , 'MarkerFaceColor',[0 0 0]);
axis([fac(1), fac(end), 0.2, 0.85]);
ap = get(gca, 'Position');
set(gca,'Xtick', fac, 'Ytick', [0:0.2:1], 'FontSize', 16,...
    'Position', [start ap(2)+0.07 width ap(4)*0.85]);
xlabel('gap','FontSize',16,'FontWeight','bold' )
ylabel('Accuracy','FontSize',16,'FontWeight','bold' )
lgd=legend("IPFP", 'RRWM', "GAGM", "FGM", "BPFG", "$${\rm KerGM_I}$$",'Orientation', 'horizontal', 'Interpreter', 'latex');

lp = get(lgd, 'Position');
% center top
set(lgd, 'Position', [ap(1)-0.16 ap(2)+ap(4)-0.007 lp(3) lp(4)*0.99], 'FontSize', 16);
hold off;

%% Ratio

maxv = [avgObj.Kergm; avgObj.Rrwm; avgObj.Gnccp; avgObj.FgmU; avgObj.Gagm;avgObj.BpfG];
maxv = max(maxv);
subplot(1,4,2)
hold on;
plot(fac, avgObj.IpfpS./ maxv, '-d', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0.4470 0.7410] , 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(fac, avgObj.Rrwm./ maxv, '-o', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4940 0.1840 0.5560] , 'MarkerFaceColor',[0.4940 0.1840 0.5560]);
plot(fac, avgObj.Gagm./ maxv, '-^', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.8500 0.3250 0.0980] , 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
plot(fac, avgObj.FgmU./ maxv, '-h', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4660 0.6740 0.1880] , 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
plot(fac, avgObj.BpfG./ maxv, '-s', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.9290 0.6940 0.1250] , 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
plot(fac, avgObj.Kergm./ maxv, '->', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0 0] , 'MarkerFaceColor',[0 0 0]);

axis([fac(1), fac(end), 0.8, 1]);
set(gca,'Xtick', fac, 'Ytick', 0.8:0.05:1.0, 'FontSize', 16,...
    'Position', [start+0.25 ap(2)+0.07 width ap(4)*0.85]);
xlabel('gap','FontSize',16, 'FontWeight','bold' )
ylabel('objective ratio','FontSize',16, 'FontWeight','bold' )
hold off;
set(gcf, 'Position', [100 200 1100 400]);

%% ACC 30
n1=30;
[avgAcc, avgObj, avgTm] = calcResults(n1);
subplot(1,4,3);
hold on;
plot(fac, avgAcc.IpfpS, '-d', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0.4470 0.7410] , 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(fac, avgAcc.Rrwm, '-o', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4940 0.1840 0.5560] , 'MarkerFaceColor',[0.4940 0.1840 0.5560]);
plot(fac, avgAcc.Gagm, '-^', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.8500 0.3250 0.0980] , 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
plot(fac, avgAcc.FgmU, '-h', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4660 0.6740 0.1880] , 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
plot(fac, avgAcc.BpfG, '-s', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.9290 0.6940 0.1250] , 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
plot(fac, avgAcc.Kergm, '->', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0 0] , 'MarkerFaceColor',[0 0 0]);
axis([fac(1), fac(end), 0.85, 1]);
ap = get(gca, 'Position');
set(gca,'Xtick', fac, 'Ytick', [0.75:0.05:1], 'FontSize', 16,...
    'Position', [start+0.5 ap(2)+0.07 width ap(4)*0.85]);
xlabel('gap','FontSize',16,'FontWeight','bold' )
ylabel('Accuracy','FontSize',16,'FontWeight','bold' )

hold off;

%% Ratio 30

maxv = [avgObj.Kergm; avgObj.Rrwm; avgObj.Gnccp; avgObj.FgmU; avgObj.Gagm;avgObj.BpfG];
maxv = max(maxv);
subplot(1,4,4)
hold on;
plot(fac, avgObj.IpfpS./ maxv, '-d', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0.4470 0.7410] , 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(fac, avgObj.Rrwm./ maxv, '-o', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4940 0.1840 0.5560] , 'MarkerFaceColor',[0.4940 0.1840 0.5560]);
plot(fac, avgObj.Gagm./ maxv, '-^', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.8500 0.3250 0.0980] , 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
plot(fac, avgObj.FgmU./ maxv, '-h', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.4660 0.6740 0.1880] , 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
plot(fac, avgObj.BpfG./ maxv, '-s', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0.9290 0.6940 0.1250] , 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
plot(fac, avgObj.Kergm./ maxv, '->', 'LineWidth', 1.5, 'MarkerSize',8, 'Color', [0 0 0] , 'MarkerFaceColor',[0 0 0]);

axis([fac(1), fac(end), 0.925, 1]);
set(gca,'Xtick', fac, 'Ytick', 0.925:0.025:1.0, 'FontSize', 16,...
    'Position', [start+0.75 ap(2)+0.07 width ap(4)*0.85]);
xlabel('gap','FontSize',16, 'FontWeight','bold' )
ylabel('objective ratio','FontSize',16, 'FontWeight','bold' )
hold off;

set(gcf, 'Position', [100 200 2200 400]);
annotation('textbox',[0.25 0.025 0.06 0.06],'String','(a)','EdgeColor','none', 'FontSize', 17);
annotation('textbox',[0.75 0.025 0.06 0.06],'String','(b)','EdgeColor','none', 'FontSize', 17);

s = 0.06;
h = 0.24;
annotation('textbox',[s h 0.075 0.12],'String','(20, 30)', 'FontSize', 20);
annotation('textbox',[s+0.25 h 0.075 0.12],'String','(20, 30)', 'FontSize', 20);
annotation('textbox',[s+0.5 h 0.075 0.12],'String','(30, 30)', 'FontSize', 20);
annotation('textbox',[s+0.75 h 0.075 0.12],'String','(30, 30)', 'FontSize', 20);

function [avgAcc, avgObj, avgTm] = calcResults(n1)
avgAcc.Kergm    = zeros(1,10);
%avgAcc.Psm      = zeros(1, 10);
avgAcc.Gnccp    = zeros(1, 10);
avgAcc.BpfG     = zeros(1, 10);
avgAcc.IpfpS    = zeros(1, 10);
avgAcc.Rrwm     = zeros(1, 10);
avgAcc.FgmU     = zeros(1, 10);
avgAcc.Gagm     = zeros(1, 10);


avgObj = avgAcc;
avgTm  = avgAcc;

savePath = './save/cmum';
for gi = 1:10
    gap = gi * 10;
    for fid = 1:110-gap
        smat_ipfps = sprintf('%s/n%d_g%d_f%d_ipfps.mat', savePath, n1, gap, fid);
        smat_rrwm = sprintf('%s/n%d_g%d_f%d_rrwm.mat', savePath, n1, gap, fid);
        %smat_psm = sprintf('%s/n%d_g%d_f%d_psm.mat', savePath, n1, gap, fid);
        smat_gnccp = sprintf('%s/n%d_g%d_f%d_gnccp.mat', savePath, n1, gap, fid);
        smat_bpfG = sprintf('%s/n%d_g%d_f%d_bpfG.mat', savePath, n1, gap, fid);
        smat_fgm = sprintf('%s/n%d_g%d_f%d_fgm.mat', savePath, n1, gap, fid);
        smat_gagm = sprintf('%s/n%d_g%d_f%d_gagm.mat', savePath, n1, gap, fid);
        smat_Kergm = sprintf('%s/n%d_g%d_f%d_Kergm.mat', savePath, n1, gap, fid);
        
        
        load(smat_Kergm);
        avgTm.Kergm(gi)=avgTm.Kergm(gi)+asgKergm.tm;
        avgAcc.Kergm(gi)=avgAcc.Kergm(gi)+asgKergm.acc;
        avgObj.Kergm(gi)=avgObj.Kergm(gi)+asgKergm.obj;
        
        load(smat_ipfps);
        avgTm.IpfpS(gi) = avgTm.IpfpS(gi) + asgIpfpS.tm;
        avgAcc.IpfpS(gi) = avgAcc.IpfpS(gi) + asgIpfpS.acc;
        avgObj.IpfpS(gi) = avgObj.IpfpS(gi) + asgIpfpS.obj;
        
        load(smat_rrwm);
        avgTm.Rrwm(gi) = avgTm.Rrwm(gi) + asgRrwm.tm;
        avgAcc.Rrwm(gi) = avgAcc.Rrwm(gi) + asgRrwm.acc;
        avgObj.Rrwm(gi) = avgObj.Rrwm(gi) + asgRrwm.obj;
        
        %         load(smat_psm);
        %         avgTm.Psm(gi) = avgTm.Psm(gi) + asgPsm.tm;
        %         avgAcc.Psm(gi) = avgAcc.Psm(gi) + asgPsm.acc;
        %         avgObj.Psm(gi) = avgObj.Psm(gi) + asgPsm.obj;
        
        load(smat_gnccp);
        avgTm.Gnccp(gi) = avgTm.Gnccp(gi) + asgGnccp.tm;
        avgAcc.Gnccp(gi) = avgAcc.Gnccp(gi) + asgGnccp.acc;
        avgObj.Gnccp(gi) = avgObj.Gnccp(gi) + asgGnccp.obj;
        
        load(smat_bpfG);
        avgTm.BpfG(gi) = avgTm.BpfG(gi) + asgBpfG.tm;
        avgAcc.BpfG(gi) = avgAcc.BpfG(gi) + asgBpfG.acc;
        avgObj.BpfG(gi) = avgObj.BpfG(gi) + asgBpfG.obj;
        
        load(smat_fgm);
        avgTm.FgmU(gi) = avgTm.FgmU(gi) + asgFgmU.tm;
        avgAcc.FgmU(gi) = avgAcc.FgmU(gi) + asgFgmU.acc;
        avgObj.FgmU(gi) = avgObj.FgmU(gi) + asgFgmU.obj;
        
        load(smat_gagm);
        avgTm.Gagm(gi) = avgTm.Gagm(gi) + asgGagm.tm;
        avgAcc.Gagm(gi) = avgAcc.Gagm(gi) + asgGagm.acc;
        avgObj.Gagm(gi) = avgObj.Gagm(gi) + asgGagm.obj;
        
    end
    
    t = fid;
    
    avgAcc.Kergm(gi)=avgAcc.Kergm(gi)/t;
    %avgAcc.Psm(gi) = avgAcc.Psm(gi) / t;
    avgAcc.Gnccp(gi) = avgAcc.Gnccp(gi) / t;
    avgAcc.BpfG(gi) = avgAcc.BpfG(gi) / t;
    avgAcc.IpfpS(gi) = avgAcc.IpfpS(gi) / t;
    avgAcc.Rrwm(gi) = avgAcc.Rrwm(gi) / t;
    avgAcc.FgmU(gi) = avgAcc.FgmU(gi) / t;
    avgAcc.Gagm(gi) = avgAcc.Gagm(gi) / t;
    
    avgObj.Kergm(gi)=avgObj.Kergm(gi)/t;
    %avgObj.Psm(gi) = avgObj.Psm(gi) / t;
    avgObj.Gnccp(gi) = avgObj.Gnccp(gi) / t;
    avgObj.BpfG(gi) = avgObj.BpfG(gi) / t;
    avgObj.IpfpS(gi) = avgObj.IpfpS(gi) / t;
    avgObj.Rrwm(gi) = avgObj.Rrwm(gi) / t;
    avgObj.FgmU(gi) = avgObj.FgmU(gi) / t;
    avgObj.Gagm(gi) = avgObj.Gagm(gi) / t;
    
    
    avgTm.Kergm(gi)=avgTm.Kergm(gi) /t;
    %avgTm.Psm(gi) = avgTm.Psm(gi) / t;
    avgTm.Gnccp(gi) = avgTm.Gnccp(gi) / t;
    avgTm.BpfG(gi) = avgTm.BpfG(gi) / t;
    avgTm.IpfpS(gi) = avgTm.IpfpS(gi) / t;
    avgTm.Rrwm(gi) = avgTm.Rrwm(gi) / t;
    avgTm.FgmU(gi) = avgTm.FgmU(gi) / t;
    avgTm.Gagm(gi) = avgTm.Gagm(gi) / t;
end
end
