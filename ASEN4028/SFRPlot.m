%% Clean
close all; clear; clc;


%% Data




%% Plotting
% Sample data
cases = {'Coarse', 'Fine', 'Joint'};
data_RGVA = [3.9,2.4,2.1]; % error values
data_RGVB = [2.9,2.6,4.3]; % error values
model_RGVA = [1.4, 1.1, 1.4];
model_RGVB = [2.6,1.9,1.6];
dataAvg = 2*mean([data_RGVA; data_RGVB], 1);
modelAvg = 2*mean([model_RGVA; model_RGVB], 1);
plot_data = [dataAvg', modelAvg'];
errors = [1,2,3];  % standard deviations or other error measures


% Create bar plot with error bars
figure;
bar(errors, plot_data);
hold on;
yline(6.56, '--', 'Label', 'Coarse Requirement', 'Color', 'r')
yline(3.28, '--', 'Label', 'Fine/Joint Requirement', 'Color', 'r')
title('Model Versus Test Data');
xlabel('Phase');
ylabel('2DRMS Accuracy (ft)');
set(gca, 'XTickLabel', cases);
legend('Test Data Accuracy', 'Model Accuracy', 'Location', 'best')



% G

% Create bar plot
figure;
h = bar(plot_data);

% Adjust bar colors
h(1).FaceColor = [0.6, 0.9, 0.6]; % Light blue for Test Data Accuracy
h(2).FaceColor = [0.2, 0.5, 0.4]; % Dark blue for Model Accuracy

hold on;

% Add error bars
numGroups = size(plot_data, 1);
numBars = size(plot_data, 2);
% for i = 1:numBars
%     x = (1:numGroups) - 0.15 + (i-1)*0.3; % Adjust x position for each bar
%     errorbar(x, plot_data(:, i), errors(:, i), 'k.', 'LineWidth', 1); % Error bars
% end

% Add horizontal lines
yline(6.56, '--', 'Label', 'Coarse Requirement', 'Color', 'r', 'LineWidth', 1.5);
yline(3.28, '--', 'Label', 'Fine/Joint Requirement', 'Color', 'r', 'LineWidth', 1.5);

title('Model Versus Test Data');
xlabel('Phase');
ylabel('2DRMS Accuracy (ft)');
set(gca, 'XTick', 1:numGroups, 'XTickLabel', cases);
grid on; % Add grid lines
legend('Test Data Accuracy', 'Model Accuracy','Location', 'best');
hold off;




