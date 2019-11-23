clear (); clc; close all;
load('outlier.mat');
load('noise.mat');
load('densitynew_outlier5noise01.mat');
[~, method_num] = size(AccTotal_out);
n_groups = 4;
color_map = containers.Map;
color_map('IPFP') =  [0 0.4470 0.7410];
color_map('SMAC') =  [0.8500 0.3250 0.0980];
color_map('PM') =  [0.9290 0.6940 0.1250];
color_map('RRWM') =  [0.4940 0.1840 0.5560];
color_map('FGM') =  [0.4660 0.6740 0.1880];
color_map('KerGM') =  [0 0 0];

marker_map = containers.Map;
marker_map('IPFP') =  '-d';
marker_map('SMAC') =  '-s';
marker_map('PM') =  '-v';
marker_map('RRWM') =  '-o';
marker_map('FGM') =  '-h';
marker_map('KerGM') =  '->';

%% Get names
method_list = strings(method_num, 1);
for i = 1:method_num
    method_list(i) = AccTotal_out{i}.name;
end

%% Get statistics
out_mean = [];
noise_mean = [];
density_mean = [];
out_std = [];
noise_std = [];
density_std = [];
for i = 1:method_num
    out_mean = [out_mean; mean(AccTotal_out{i}.res)];
    noise_mean = [noise_mean; mean(AccTotal_noise{i}.res)];
    density_mean = [density_mean; mean(AccTotal_den{i}.res)];
    out_std = [out_std; std(AccTotal_out{i}.res)];
    noise_std = [noise_std; std(AccTotal_noise{i}.res)];
    density_std = [density_std; std(AccTotal_den{i}.res)];
end

% data1-3
group_names = {'outliers', 'noise', 'density'};
x_data = {[0:5:50]; [0:0.02:0.2]; [0.3:0.1:1]};
x_ticks ={[0:10: 50];[0:0.04:0.2];[0.3:0.1:1]};
y_data = {out_mean, noise_mean, density_mean};
y_ticks = {[0:0.2:1]; [0:0.2:1]; [0:0.2:1]};
err_data = {out_std, noise_std, density_std};

% data4
x_ticks4 = [50, 60, 70, 80, 90, 100];
x_data4 = x_ticks4;
x_tick_labels4 = {'50', '100', '200', '500', '1000', '2000'};
y_data4 = [...
    0.0938, 2.0300,   27.6875,   nan,     nan,      nan;...
    0.2969, 3.2500,   36.1406,   nan,     nan,      nan;...
    0.0781, 0.2344,   3.2656,    nan,     nan,      nan;...
    0.0938, 2.0313,   25.9375,   nan,     nan,      nan;...
    9.8594, 239.5781, 4.79*10^3, nan,     nan,      nan;...
    1,      1.23,     5.5625,    44.6875, 353.3438, 2.4*10^3;...
    ];


mid_id = ceil(n_groups / 2);

figure;
for ii = 1:n_groups
    if ii <=3
        subplot(1, n_groups, ii);
        hold on;
        errorbar(x_data{ii}, y_data{ii}(1,:), err_data{ii}(1,:), marker_map(method_list(1)), 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8, 'Color', color_map(method_list(1)), 'MarkerFaceColor',color_map(method_list(1)));
        errorbar(x_data{ii}, y_data{ii}(2,:), err_data{ii}(2,:), marker_map(method_list(2)), 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8, 'Color', color_map(method_list(2)), 'MarkerFaceColor',color_map(method_list(2)));
        errorbar(x_data{ii}, y_data{ii}(3,:), err_data{ii}(3,:), marker_map(method_list(3)), 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8, 'Color', color_map(method_list(3)), 'MarkerFaceColor',color_map(method_list(3)));
        errorbar(x_data{ii}, y_data{ii}(4,:), err_data{ii}(4,:), marker_map(method_list(4)), 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8, 'Color', color_map(method_list(4)), 'MarkerFaceColor',color_map(method_list(4)));
        errorbar(x_data{ii}, y_data{ii}(5,:), err_data{ii}(5,:), marker_map(method_list(5)), 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8, 'Color', color_map(method_list(5)), 'MarkerFaceColor',color_map(method_list(5)));
        errorbar(x_data{ii}, y_data{ii}(6,:), err_data{ii}(6,:), marker_map(method_list(6)), 'LineWidth', 1.5, 'Capsize', 1,'MarkerSize',8, 'Color', color_map(method_list(6)), 'MarkerFaceColor',color_map(method_list(6)));
        xticks(x_ticks{ii});
        yticks(y_ticks{ii});
        x_l = min(x_ticks{ii});
        x_h = max(x_ticks{ii});
        d = x_h-x_l;
        x_l = x_l - d/20;
        x_h = x_h + d/20;
        axis([x_l x_h 0 1.05]);
        xlabel(group_names{ii},'FontSize', 13,'FontWeight','bold' );
        ylabel('Accuracy', 'FontSize', 13,'FontWeight','bold');
        %    grid on;
    end
    hold off;
    
    % plot data 4
    if ii == 4
        subplot(1, n_groups, ii);
        hold on;
        for i = 1:length(method_list)
            plot(x_data4, y_data4(i,:), marker_map(method_list(i)),'LineWidth', 1.5, 'MarkerSize',8, 'Color', color_map(method_list(i)), 'MarkerFaceColor',color_map(method_list(i)));
        end
        xticks(x_ticks4);
        xticklabels(x_tick_labels4);
        set(gca, 'yscale', 'log');
        axis([47, 102, 0.02, 20000]);
%         legend(method_list, 'Location', 'southeast');
        plot(ones(71,1)*x_ticks4(3), 10.^(-2:0.1:5), '-.b');
        xx_temp = 0:1:x_ticks4(3);
        plot(xx_temp, ones(length(xx_temp),1)*y_data4(5,3), '-.b')
        xx_temp = 0:1:x_ticks4(6);
        plot(xx_temp, ones(length(xx_temp),1)*y_data4(6,6), '-.b')
        xlabel('# nodes','FontSize', 16,'FontWeight','bold');
        ylabel('time (s)','FontSize', 16,'FontWeight','bold');
        yticks([0.01 0.1 1 10 100 1000 10000])
        hold off;
    end
    
    % legend
    ap = get(gca, 'Position');
    if ii == 4
        m_listnew = method_list;
        m_listnew{6} = '$${\rm KerGM_{II}}$$';
        lgd = legend(m_listnew, 'Orientation', 'horizontal', 'interpreter', 'latex');
        lp = get(lgd, 'Position');
        % center top
        set(lgd, 'Position', [ap(1)-lp(3)+ap(3) ap(2)+ap(4)+0.012 lp(3) lp(4)], 'FontSize', 16);
    end
    set(gca, 'Position', [(ii-1)*(1/n_groups-0.006)+0.049 ap(2)+0.106 0.20 ap(4)*0.84], 'FontSize', 16);    
    
end
set(gcf, 'Position', [100 200 2000 400]);
annotation('textbox',[0.375 0.025 0.06 0.06],'String','(a)','EdgeColor','none', 'FontSize', 17);
annotation('textbox',[0.875 0.025 0.06 0.06],'String','(b)','EdgeColor','none', 'FontSize', 17);