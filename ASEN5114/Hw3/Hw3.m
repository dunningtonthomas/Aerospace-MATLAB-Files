%% Hw3
% Author: Thomas Dunnington
% Modified: 2/17/2025

close all; clear; clc;


%% Problem 1
% Constants
ks = 10000;         % N/m
kw = 500000;        % N/m
b = 9800;           % Ns/m
m2 = 350;           % kg
m1 = 10;            % kg

% Linear Time Invariant System
A = [-b/m1, b/m1, -1/m1, 1/m1;
    b/m2, -b/m2, 0, -1/m2;
    kw, 0, 0, 0;
    -ks, ks, 0, 0];

B = [0; 0; -kw; 0];

C = [0, 1, 0, 0];

D = 0;

% Calculate the eigenvalues
[vecs, vals] = eig(A);

% Simulate system
sys = ss(A, B, C, D);

% Step and impulse responses
[y_step, t_step] = step(sys);
[y_imp, t_imp] = impulse(sys);

% Step response
figure();
plot(t_step, y_step, 'r', 'LineWidth', 2);
grid on;
hold on;
yline(1, 'color', 'c', 'LineWidth', 2,'LineStyle','--')
title('$\dot{y}$ Step Response', 'Interpreter','latex');
xlabel('Time (s)');
ylabel('$\dot{y}$ [m/s]', 'Interpreter','latex');

% Impulse response
figure();
plot(t_imp, y_imp, 'r', 'LineWidth', 2);
grid on;
hold on;
yline(0, 'color', 'c', 'LineWidth', 2,'LineStyle','--')
title('$\dot{y}$ Impulse Response', 'Interpreter','latex');
xlabel('Time (s)');
ylabel('$\dot{y}$ [m/s]', 'Interpreter','latex');



%% Problem 3
La = 10 / 1000;     % H
Ra = 1;             % ohm
J1 = 0.1;           % kg m^2
J2 = 1;             % kg m^2
k = 10;             % Nm/rad
b = 0.01;           % Nms/rad
kt = 1;             % Nm/A
ke = 1;             % Vs/rad
B = 0.01;           % Nms/rad

% Create state space
A = [-Ra/La, 0, -ke/La, 0, 0;
    0, 0, 1, 0, 0;
    kt/J1, -k/J1, -(B+b)/J1, k/J1, b/J1;
    0, 0, 0, 0, 1;
    0, k/J2, b/J2, -k/J2, -b/J2];

B = [1/La; 0; 0; 0; 0];

C = [0, 1, 0, 0, 0];

D = [0];


% Eigenvalues
[vecs, vals] = eig(A);


% Simulate
% sys = ss(A, B, C, D);
% figure()
% impulse(sys);