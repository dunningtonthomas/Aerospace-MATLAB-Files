%% Problem 1
close all; clear; clc;

% Constants
g = 9.81;
l = 1.85;
m = 2;
M = 4;
dt = 0.05;

% Linear LTI system
A = [0,1,0,0; 0,0,m*g/M,0; 0,0,0,1; 0,0,g*(M+m)/(l*M),0];
B = [0; 1/M; 0; 1/(M*l)];
C = [1, 0, -l, 0];
D = [0];

% Convert to DT
Ahat = [A, B; zeros(1, 5)];

% Matrix Exponential
exp_mat = expm(Ahat*dt);

% Discrete time system 
F = exp_mat(1:4,1:4);
G = exp_mat(1:4,5);
H = C;
M = D;

% Eigenvalues of F
[~, vals] = eig(F);

% Observability matrix
O = obsv(F,H);

% Load data
load('midterm1problem1data.mat');

% Construct matrices for estimation
Y = yNLhist;
Hbig = [];
for i = 1:length(Y)
    Hbig(i, :) = H * (F - G*Kc)^(i-1); 
end

% Least squares estimatino
xbar_0 = inv(Hbig' * Hbig) * Hbig' * Y;

% Calculate predicted sequence
x_k = xbar_0';
yk = zeros(length(thist), 1);
for i = 1:length(thist)
    t = thist(i);
    yk(i) = H*x_k(i,:)';
    x_k(i+1, :) = (F - G*Kc)*x_k(i, :)';
end

% Calculate y for x0
y0 = H*xbar_0;

% Calculate error between the predicted and measured values
error = Y - yk;


% Plot the predicted and measured values
figure();
plot(thist, Y, 'LineWidth', 2, 'Color', 'b');
hold on;
grid on;
plot(thist, yk, 'LineWidth', 2, 'Color', 'r', 'LineStyle', '--');

xlabel('Time (s)');
ylabel('Displacement Pertubation (m)')
title('Predicted vs Measured Bob Horizontal Displacement')
legend('Measured', 'Predicted')

% Plot the error in predicted versus measured
figure();
plot(thist, error, 'linewidth', 2, 'color', 'k');
grid on;

xlabel('Time (s)');
ylabel('Displacement Pertubation Error (m)')
title('Predicted vs Measured Error')