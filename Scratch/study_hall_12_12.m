%%
close all; clear; clc;


%% Simulate predator prey model

% Euler's method
dt = 0.001;
x0 = [20; 20];
tspan = [0 15];
timeVec = 0:dt:tspan(2);

xCurr = x0';
for i = 1:length(timeVec)-1
    xdot = predatorPreyODE(timeVec(i), xCurr(i, :));
    xCurr(i+1, :) = xCurr(i, :) + dt.*xdot';
end

% Plotting
% Plotting the predator-prey phase plane
figure();
plot(xCurr(:,1), xCurr(:,2), 'linewidth', 2, 'color', [0 0.5 0.8]); % Use a custom color
grid on; % Add grid for better readability
xlabel('Prey Population', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Predator Population', 'FontSize', 12, 'FontWeight', 'bold');
title('Lotka-Volterra Predator-Prey Model', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 1.2, 'FontSize', 11); % Improve axis line width and font size
legend('Phase Plane', 'Location', 'best', 'FontSize', 11);

% Plotting predator and prey populations over time
figure();
plot(timeVec, xCurr(:,1), 'LineWidth', 2, 'Color', [0.8 0.3 0.3]); % Prey population in red
hold on;
plot(timeVec, xCurr(:,2), 'LineWidth', 2, 'Color', [0.3 0.8 0.3]); % Predator population in green
grid on;
xlabel('Time', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Population', 'FontSize', 12, 'FontWeight', 'bold');
title('Predator-Prey State', 'FontSize', 14, 'FontWeight', 'bold');
legend({'Prey Population', 'Predator Population'}, 'Location', 'best', 'FontSize', 11);
set(gca, 'LineWidth', 1.2, 'FontSize', 11); % Improve axis line width and font size




%% Functions
function xdot = predatorPreyODE(t, x)
    alpha = 0.01;
    beta = 0.02;
    dxdt = x(1) - alpha*x(1)*x(2);
    dydt = -x(2) + beta*x(1)*x(2);
    xdot = [dxdt; dydt];

    %xdot = diag([1 - .01*x(2), -1 + .02*x(1)])*x;
end