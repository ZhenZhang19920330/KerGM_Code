close all; clear (); clc;
x = [5, 10, 15, 20, 25];
y = [...
    0.8436, 0.8376, 0.8365, 0.8316, 0.8305;...
    0.8932, 0.4031, 0.1816, 0.1068, 0.06;...
    0.2948, 0.2331, 0.2540, 0.2241, 0.1614;...
    0.77, 0.615, 0.47, 0.34, 0.295;...
    ];

namelist = ['$${\rm KerGM_{II}}$$', "GHOST", "TAME", "MAGNA"];

figure;
hold on;
b= bar(y');
b(1).FaceColor = [0,0,0];
b(2).FaceColor = [0 0.4470 0.7410];
b(3).FaceColor = [0.8500 0.3250 0.0980];
b(4).FaceColor = [0.9290 0.6940 0.1250];

axis([0.5 5.5 0 1])
xticks(1:1:5);
xticklabels({'5%', '10%', '15%', '20%', '25%'})
yticks(0:0.2:1)
xlabel('Noise level', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Node accuracy', 'FontSize', 16, 'FontWeight', 'bold');
set(gca, 'FontSize', 16, 'YGrid', 'on' ,'GridLineStyle', '-')
lgd = legend(namelist, 'FontSize', 12, 'interpreter' ,'latex');
set(lgd, 'Position', [0.69 0.5 0.2 0.2])
set(gcf, 'Position', [100 200 600 400])
hold off;
