%% ASEN 5114 Exam 1
% Author: Thomas Dunnington
% Modified: 2/24/2025
close all; clear; clc;


%% Problem 3
% Define open loop transfer function
G_num = 10;
G_den = [1 0 0.01];
sys = tf(G_num, G_den);

% PID Gains
% kp = 1;
% kd = 1;
% ki = 1;
kp = 10;
kd = 2;
ki = 5;


% Closed loop transfer function
G_num_closed = @(kp, kd, ki)([10*kd 10*kp 10]);
G_den_closed = @(kp, kd, ki)([1 10*kd 10*kp+0.01 10]);

% Plug in gain values
G_num_cl = G_num_closed(kp, kd, ki);
G_den_cl = G_den_closed(kp, kd, ki);

% Create transfer function
sys = tf(G_num_cl, G_den_cl);

% Simulate
[y, t] = step(sys);
info = stepinfo(sys, "SettlingTimeThreshold", 0.05);

% Plot the step response
figure();
p = plot(t, y, 'linewidth', 2, 'color', 'r');
hold on
grid on
grid minor
scatter(info.SettlingTime, 1.05, 'SizeData', 20, 'MarkerFaceColor', 'b', 'MarkerEdgeColor','b');
s = xline(info.SettlingTime, 'LineWidth',1.5, 'linestyle', '--', 'color', 'b');
st = yline(1.05, 'linestyle', '--', 'Color', 'k', 'LineWidth', 1.5);
yline(0.95, 'linestyle', '--', 'Color', 'k', 'LineWidth', 1.5)
c = yline(1, 'Color', 'g', 'LineWidth', 1.5);

xlabel('Time (s)', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');
ylabel('Pitch Angle (rad)', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');
title('Closed Loop PID Pitch Angle Response', 'FontSize', 16, 'FontWeight', 'bold', 'Interpreter', 'latex');
legend([p, s, st, c], {'Response', 'Settling Time', '95\% Bound', 'Step Command'}, ...
    'Location', 'best', 'FontSize', 12, 'Interpreter', 'latex');
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.2;
ax.Box = 'on';

% Simulate with simulink
output = sim('pitch_controller.slx');
t = output.t;
y = output.y;
u = output.u;

% Plot the step response
figure();
p = plot(t, y, 'linewidth', 2, 'color', 'r');
hold on
grid on
grid minor
scatter(info.SettlingTime, 1.05, 'SizeData', 20, 'MarkerFaceColor', 'b', 'MarkerEdgeColor','b');
s = xline(info.SettlingTime, 'LineWidth',1.5, 'linestyle', '--', 'color', 'b');
st = yline(1.05, 'linestyle', '--', 'Color', 'k', 'LineWidth', 1.5);
yline(0.95, 'linestyle', '--', 'Color', 'k', 'LineWidth', 1.5)
c = yline(1, 'Color', 'g', 'LineWidth', 1.5);

xlabel('Time (s)', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');
ylabel('Pitch Angle (rad)', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');
title('Simulink PID Pitch Angle Response', 'FontSize', 16, 'FontWeight', 'bold', 'Interpreter', 'latex');
legend([p, s, st, c], {'Response', 'Settling Time', '95\% Bound', 'Step Command'}, ...
    'Location', 'best', 'FontSize', 12, 'Interpreter', 'latex');
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.2;
ax.Box = 'on';



%% Problem 4
% PART A
% Solve for the exponential value
lambda = -1*log(1 - 0.425/0.5);

% Create the tf
sys = tf(0.95, [1 1.9]);

% Step response
figure();
step(sys);


% PART B
% Create the tf
sys = tf(2, [1 0]);

% Step response
figure();
step(sys, 10);


% PART C
% Damped frequency
wd = 2*pi/4;

% Real component
sigma = log(1 - 0.2/0.35) / 3.8;

% DC Gain
A_2 = 0.35 * 2.6;

% Create the transfer function
sys = tf([A_2], [1 0.44 2.6]);
figure();
step(sys, 20)


% PART D
wd = pi;

% Create the transfer function
sys = tf([0.14*pi^2 / 2], [1 0 pi^2]);
figure();
step(sys, 6)


%% Problem 5
% Part a
A = 2/82;
C = 1/10 * (12 - 2*A);
B = 1/11 * (13 - A*5) - C;
coeff_temp = 50 * A;


% Part b
B_2 = 10 / -820;
A_2 = 10 / (2*10);

lhs_1 = 10 - 0.5*11*5 - B_2*5;
lhs_2 = 10 - 0.5*12*10 - B_2*2*10;

% Solve system of equations
sys_mat = [11, 11, lhs_1; 48, 24, lhs_2];
sys_solution = rref(sys_mat);

% Split for laplace
rhs_temp = sys_solution(2,3) / sys_solution(1,3);
rhs_temp_2 = sys_solution(1,3) * 1.25;

% Solve for total solution
temp = 50*A;

