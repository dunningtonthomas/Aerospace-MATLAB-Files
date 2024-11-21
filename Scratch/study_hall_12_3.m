%% 
close all; clear; clc;


%% Mass spring damper
% Parameters
params.k = 100;
params.b = 5;
params.m = 5;

% Integrate EOM
eomFunc = @(t, x)springEOM(t, x, params);
tspan = [0 10];
x_init = [0.5; 0];
[tout, yout] = ode45(eomFunc, tspan, x_init);

% Plot results
figure();
sgtitle('Damped Mass-Spring Response', 'FontSize', 14, 'Interpreter', 'latex')

% Subplot 1: Position
subplot(2,1,1)
plot(tout, yout(:,1), 'LineWidth', 2, 'Color', [0 0.4470 0.7410]) % Default MATLAB blue
grid on;
xlabel('Time (s)', 'FontSize', 12, 'Interpreter', 'latex')
ylabel('$x$ (m)', 'FontSize', 12, 'Interpreter', 'latex')
title('Displacement vs Time', 'FontSize', 12, 'Interpreter', 'latex')

% Subplot 2: Velocity
subplot(2,1,2)
plot(tout, yout(:,2), 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980]) % Default MATLAB red
grid on;
xlabel('Time (s)', 'FontSize', 12, 'Interpreter', 'latex')
ylabel('$\dot{x}$ (m/s)', 'FontSize', 12, 'Interpreter', 'latex')
title('Velocity vs Time', 'FontSize', 12, 'Interpreter', 'latex')

% General improvements
set(gcf, 'Color', 'w'); % Set figure background to white
set(gca, 'FontSize', 10); % Adjust font size of axes




%% EOM Function
function xdot = springEOM(t, x, params)
    A = [0, 1; -params.k / params.m, -params.b/params.m];
    xdot = A*x;
end