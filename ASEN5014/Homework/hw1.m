%% Clean
close all; clear; clc;


%% Problem 2
% Initial conditions
x0 = [7e16; 3e15];

% System matrices
A = [-0.693/9.2, -1; 0, -0.693/6.7];
B = [0; 0];
C = [1, 1];
D = 0;

% Create the system
x1_sys = ss(A, B, [1, 0], D);
x2_sys = ss(A, B, [0, 1], D);


% Define the time vector
t = linspace(0, 20, 100);  % Adjust the time span and number of points as needed

% Define the input signal u(t) - Example: Step input
u = ones(size(t));

% Simulate the initial conditions
[y, t, x] = initial(x1_sys, x0, t);

% Plot the response
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(t, x, 'linewidth', 2);
hold on;
title('System Response');
xlabel('Time (Hours)');
ylabel('Concentration (atoms/volume)');
legend('Xenon 135', 'Iodine 135');

% Iodine response
figure();
plot(t, x(:,2), 'linewidth', 2, 'color', 'r');
title('Iodine Response');
xline(6.72, 'label', 'Half Life', 'LineStyle', '--');
xlabel('Time (Hours)');
ylabel('Concentration (atoms/volume)');

% Xenon response
figure();
plot(t, x(:,1), 'linewidth', 2, 'color', 'b');
title('Xenon Response');
xline(9.2, 'label', 'Half Life', 'LineStyle', '--');
xlabel('Time (Hours)');
ylabel('Concentration (atoms/volume)');



%% Problem 3
% Initial conditions
x0 = [0; 0];
u0 = [0;1;1];

% System matrices
A = [3, 0; 0, 2];
B = [1,1,0; 0,1,1];
C = [1, 0; 0, 1];
D = [0,0,0; 0,0,0];

% Create the system
sysTemp = ss(A, B, C, D);


% Define the time vector
t = linspace(0, 5, 100);  % Adjust the time span and number of points as needed

% Define the input signal u(t) - Example: Step input
u = ones(length(t), 3);
u(:,1) = zeros(length(t),1);

% Simulate the initial conditions
% Simulate the system response
[y, t, x] = lsim(sysTemp, u, t, x0);


% Plot the response
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(t, x, 'linewidth', 2);
hold on;
title('System Response');
xlabel('Time (Units)');
ylabel('Temperature');
legend('X1', 'X2');

% X1 response
figure();
plot(t, x(:,1), 'linewidth', 2, 'color', 'r');
title('X1 Response');
xlabel('Time (Hours)');
ylabel('Temperature');

% X2 response
figure();
plot(t, x(:,2), 'linewidth', 2, 'color', 'b');
title('X2 Response');
xlabel('Time (Units)');
ylabel('Temperature');







