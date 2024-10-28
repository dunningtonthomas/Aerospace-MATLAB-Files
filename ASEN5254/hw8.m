%% Clean
close all; clear; clc;


%% E1 Agents vs Time and Tree Size
num_agents = 2:6;
comp_time = [45.7, 125.6, 980.5, 8095, 81253.2];
tree_size = [384, 541, 2242, 10209, 24824];

decentral_time = [33.5, 52.48, 85.5, 116.02, 147.9];


% figure();
% scatter(num_agents, comp_time, 'filled', 'marker', 'o', 'color', 'b')
% set(gca, 'YScale', 'log');
% grid on;
% 
% xlabel('Number of Agents')
% ylabel('Time (ms)')
% title('Average Computation Time')
% 
% figure();
% scatter(num_agents, tree_size, 'filled', 'marker', 'o', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
% set(gca, 'YScale', 'log');
% grid on;
% 
% xlabel('Number of Agents')
% ylabel('Tree Size (#nodes)')
% title('Average Tree Size')


% First Plot: Average Computation Time
figure();
scatter(num_agents, comp_time, 60, 'o', 'filled', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b'); % Adjust marker size and color
set(gca, 'YScale', 'log'); % Log scale for y-axis
grid on;
xlabel('Number of Agents', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Time (ms)', 'FontSize', 12, 'FontWeight', 'bold');
title('Average Computation Time', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 1.2, 'FontSize', 10); % Thicker axis lines and larger font size for readability

% Second Plot: Average Tree Size
figure();
scatter(num_agents, tree_size, 60, 'o', 'filled', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r'); % Adjust marker size and color
set(gca, 'YScale', 'log'); % Log scale for y-axis
grid on;
xlabel('Number of Agents', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Tree Size (#nodes)', 'FontSize', 12, 'FontWeight', 'bold');
title('Average Tree Size', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 1.2, 'FontSize', 10); % Thicker axis lines and larger font size for readability


figure();
scatter(num_agents, decentral_time, 60, 'o', 'filled', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b'); % Adjust marker size and color
grid on;
xlabel('Number of Agents', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Time (ms)', 'FontSize', 12, 'FontWeight', 'bold');
title('Decentralized Average Computation Time', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 1.2, 'FontSize', 10); % Thicker axis lines and larger font size for readability