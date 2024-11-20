%% Clean
close all; clear; clc;


%% Problem 1
sigma_a = 0.045;
sigma_b = -0.045;
qw = 10;
dt = 0.5;
W = qw .* [2, 0.05; 0.05, 0.5];

gamma = [0,0;1,0;0,0;0,1];

Aa = [0,1,0,0;
    0,0,0,-sigma_a;
    0,0,0,1;
    0,sigma_a,0,0];

Ab = [0,1,0,0;
    0,0,0,-sigma_b;
    0,0,0,1;
    0,sigma_b,0,0];

Fa = [1, sin(sigma_a*dt)/sigma_a, 0, -(1-cos(sigma_a*dt))/sigma_a; 
    0, cos(sigma_a*dt), 0, -sin(sigma_a*dt);
    0, (1-cos(sigma_a*dt))/sigma_a, 1, sin(sigma_a*dt)/sigma_a;
    0, sin(sigma_a*dt), 0, cos(sigma_a*dt)];

Fb = [1, sin(sigma_b*dt)/sigma_b, 0, -(1-cos(sigma_b*dt))/sigma_b; 
    0, cos(sigma_b*dt), 0, -sin(sigma_b*dt);
    0, (1-cos(sigma_b*dt))/sigma_b, 1, sin(sigma_b*dt)/sigma_b;
    0, sin(sigma_b*dt), 0, cos(sigma_b*dt)];

% Van loans method
za = dt .* [-Aa, gamma*W*gamma'; zeros(4,4), Aa'];
ez_a = expm(za);
Qa = ez_a(5:8, 5:8)' * ez_a(1:4, 5:8);

zb = dt .* [-Ab, gamma*W*gamma'; zeros(4,4), Ab'];
ez_b = expm(zb);
Qb = ez_b(5:8, 5:8)' * ez_b(1:4, 5:8);

%% Problem 2
rng(100);

% Load data, xadouble_truth, xasingle_truth, xbdouble_truth
load('hw8problemdata.mat');

% Measurement model
H = [1,0,0,0; 0,0,1,0];
Ra = [20, 0.05; 0.05, 20];

% Simulate noisy measurements
time_vec = 0.5:0.5:100;
vk_mat = zeros(2, 200);
for i = 2:length(xasingle_truth(1,:))
    pos_xa = [xasingle_truth(1,i); xasingle_truth(3,i)];
    vk_mat(:,i-1) = mvnrnd(pos_xa', Ra, 1);
end

% Plot for the first 20 seconds
time_20 = time_vec(time_vec <= 20);
vk_mat_20 = vk_mat(:,time_vec <= 20);


figure();
% Title for the entire figure
sgtitle('Simulated Noisy Measurements', 'FontSize', 16, 'FontWeight', 'bold');

% First subplot
subplot(2, 1, 1);
plot(time_20, vk_mat_20(1, :), 'LineWidth', 2, 'Color', [0 0.4470 0.7410]); % Use MATLAB default blue
grid on;
xlabel('Time (s)', 'FontSize', 12);
ylabel('$y_{k,1} (\xi)$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
title('Measurement in $\xi$ Direction', 'Interpreter', 'latex', 'FontSize', 14);
xlim([min(time_20), max(time_20)]); % Set consistent x-axis limits

% Second subplot
subplot(2, 1, 2);
plot(time_20, vk_mat_20(2, :), 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980]); % Use MATLAB default red
grid on;
xlabel('Time (s)', 'FontSize', 12);
ylabel('$y_{k,2} (\eta)$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
title('Measurement in $\eta$ Direction', 'Interpreter', 'latex', 'FontSize', 14);
xlim([min(time_20), max(time_20)]); % Set consistent x-axis limits

% Additional formatting
set(gcf, 'Color', 'w'); % Set background color to white



