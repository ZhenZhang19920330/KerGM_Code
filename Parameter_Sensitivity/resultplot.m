clear (); close all; clc;
load('Parameter_dim.mat');
%load('Final_lambda.mat');
load('Parameter_lambda.mat');
Final_lambda=AccTimeTotal_lambda;

%% Dimension Data
dim_namelist = {};
dim_num = 3;%specificed
dim_data_mean = [];
dim_data_std = [];
for i = 1:dim_num 
    dim_namelist{i} = Final_dim{i}.name;
    temp = Final_dim{i}.res;
    dim_data_mean = [dim_data_mean; mean(temp)];
    dim_data_std = [dim_data_std; std(temp)];
end
dim_xticks = 0:100:500;
dim_yticks = 0:0.2:1;

%% Dimension Plot
figure;
hold on;
errorbar(dim_xticks, dim_data_mean(1, :), dim_data_std(1, :), '-d', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0 0.4470 0.7410], 'MarkerFaceColor',[0 0.4470 0.7410]);
errorbar(dim_xticks, dim_data_mean(2, :), dim_data_std(2, :), '->', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0 0 0], 'MarkerFaceColor', [0 0 0]);
errorbar(dim_xticks, dim_data_mean(3, :), dim_data_std(3, :), '-s', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0.8500 0.3250 0.0980], 'MarkerFaceColor', [0.8500 0.3250 0.0980]);

set(gca, 'FontSize', 17);
xticks(dim_xticks);
yticks(dim_yticks);
legend({dim_namelist{1:3}}, 'FontSize', 16, 'Location', 'eastoutside');
xlabel('outliers', 'FontSize', 16, 'fontweight','bold');
ylabel('Accuracy', 'FontSize', 16, 'fontweight','bold');
axis([-10 510 -0.05 1.05]);
ap = get(gca, 'Position');
set(gca, 'Position', [0.12, 0.16, 0.60, ap(4)]);
hold off;
set(gcf, 'Position', [100, 200, 600, 400]);
 s = 0.145; h = 0.19;
annotation('textbox',[s h 0.206 0.12],'String','\lambda=0.005', 'FontSize', 20);

hold off;






%% Lambda

lambda_namelist = {};
lamda_data_mean = [];
lamda_data_std = [];

for i = 1:12
   lambda_namelist{i} = [Final_lambda{i}.name];
   temp = Final_lambda{i}.res;
   lamda_data_mean = [lamda_data_mean; mean(temp)];
   lamda_data_std = [lamda_data_std; std(temp)];
end
lambda_xticks = 0:100:500;
lambda_yticks = 0:0.2:1;


%% plot
figure;
hold on
errorbar(lambda_xticks, lamda_data_mean(1, :), lamda_data_std(1,:), '->', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0 0 0], 'MarkerFaceColor', [0 0 0]);
errorbar(lambda_xticks, lamda_data_mean(2, :), lamda_data_std(2,:), '-s', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0.8500 0.3250 0.0980], 'MarkerFaceColor', [0.8500 0.3250 0.0980]);
errorbar(lambda_xticks, lamda_data_mean(3, :), lamda_data_std(3,:), '-h', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0.9290 0.6940 0.1250], 'MarkerFaceColor',[0.9290 0.6940 0.1250]);
errorbar(lambda_xticks, lamda_data_mean(4, :), lamda_data_std(4,:), '-d', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0 0.4470 0.7410], 'MarkerFaceColor',[0 0.4470 0.7410]);
errorbar(lambda_xticks, lamda_data_mean(5, :), lamda_data_std(5,:), '-o', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0.4940 0.1840 0.5560], 'MarkerFaceColor', [0.4940 0.1840 0.5560]);
errorbar(lambda_xticks, lamda_data_mean(6, :), lamda_data_std(6,:), '-+', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor', [0.4660 0.6740 0.1880]);
errorbar(lambda_xticks, lamda_data_mean(7, :), lamda_data_std(7,:), '-x', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0.3010 0.7450 0.9330], 'MarkerFaceColor',[0.3010 0.7450 0.9330]);
errorbar(lambda_xticks, lamda_data_mean(8, :), lamda_data_std(8,:), '-^', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0.6350 0.0780 0.1840], 'MarkerFaceColor',[0.6350 0.0780 0.1840]);
errorbar(lambda_xticks, lamda_data_mean(9, :), lamda_data_std(9,:), '-v', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[1 0 1], 'MarkerFaceColor', [1 0 1]);
errorbar(lambda_xticks, lamda_data_mean(10, :), lamda_data_std(10,:), '-<', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0 0 1], 'MarkerFaceColor', [0 0 1]);
errorbar(lambda_xticks, lamda_data_mean(11, :), lamda_data_std(11,:), '-p', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[1 0 0], 'MarkerFaceColor',[1 0 0]);
errorbar(lambda_xticks, lamda_data_mean(12, :), lamda_data_std(12,:), '-*', 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8,'Color',[0 0.9 0], 'MarkerFaceColor',[0 0.9 0]);
set(gca, 'FontSize', 17);
xticks(lambda_xticks);
yticks(lambda_yticks);
legend({lambda_namelist{1:12}}, 'FontSize', 16, 'Location', 'eastoutside');
xlabel('outliers', 'FontSize', 16, 'fontweight','bold');
ylabel('Accuracy', 'FontSize', 16, 'fontweight','bold');
axis([-10 510 -0.05 1.05]);
ap = get(gca, 'Position');
set(gca, 'Position', [0.12, 0.16, 0.60, ap(4)]);
hold off;
set(gcf, 'Position', [100, 200, 600, 400]);
 s = 0.145; h = 0.19;
annotation('textbox',[s h 0.136 0.12],'String','D=20', 'FontSize', 20);


