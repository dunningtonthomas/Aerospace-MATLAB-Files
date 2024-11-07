%% Clean
close all; clear; clc;

%% Problem 1
mu_0 = [0; 85*cos(pi/4); 0; -85*sin(pi/4)];
P_0 = [10, 0, 0, 0; 0, 2, 0 ,0; 0, 0, 10, 0; 0, 0, 0, 2];
sigma = 0.045;
dt = 0.5;
F = [1, sin(sigma*dt)/sigma, 0, -(1-cos(sigma*dt))/sigma; 
    0, cos(sigma*dt), 0, -sin(sigma*dt);
    0, (1-cos(sigma*dt))/sigma, 1, sin(sigma*dt)/sigma;
    0, sin(sigma*dt), 0, cos(sigma*dt)];

% 300 step simulation
iterations = 1:300;
mu_mat = zeros(length(iterations), 4);
unc_mat = zeros(length(iterations), 4);

for i = iterations
    % Propogate average
    mu_N = F^i * mu_0;
    mu_mat(i,:) = mu_N';

    % Propogate covariance
    P_N = F^i * P_0 * (F^i)';
    unc_mat(i,:) = [sqrt(P_N(1,1)), sqrt(P_N(2,2)), sqrt(P_N(3,3)), sqrt(P_N(4,4))];
end

time_vec = iterations .* 0.5;


%% Plotting 
%%%% +- 2sigma values
figure();

% Set line properties for clarity
mainLineColor = 'b';
boundLineColor = 'r';
lineWidth = 2;

% Main title for the figure
sgtitle('Pure Prediction State Propagation', 'FontSize', 14, 'FontWeight', 'bold');

% xi
subplot(4,1,1);
plot(time_vec, mu_mat(:,1), 'LineWidth', lineWidth, 'Color', mainLineColor);
hold on;
grid on;
plot(time_vec, mu_mat(:,1) + 2 .* unc_mat(:,1), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
plot(time_vec, mu_mat(:,1) - 2 .* unc_mat(:,1), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
xlabel('Time (s)');
ylabel('\xi [m]');
title('$\xi$ (Position in x)', 'Interpreter','latex');
legend('Prediction', '2\sigma Bounds', 'Location', 'best');

% xi dot
subplot(4,1,2);
plot(time_vec, mu_mat(:,2), 'LineWidth', lineWidth, 'Color', mainLineColor);
hold on;
grid on;
plot(time_vec, mu_mat(:,2) + 2 .* unc_mat(:,2), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
plot(time_vec, mu_mat(:,2) - 2 .* unc_mat(:,2), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
xlabel('Time (s)');
ylabel('$\dot{\xi}$ [m/s]', 'Interpreter', 'latex');
title('$\dot{\xi}$ (Velocity in x)', 'Interpreter','latex');

% eta
subplot(4,1,3);
plot(time_vec, mu_mat(:,3), 'LineWidth', lineWidth, 'Color', mainLineColor);
hold on;
grid on;
plot(time_vec, mu_mat(:,3) + 2 .* unc_mat(:,3), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
plot(time_vec, mu_mat(:,3) - 2 .* unc_mat(:,3), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
xlabel('Time (s)');
ylabel('\eta [m]');
title('$\eta$ (Position in y)', 'Interpreter','latex');

% eta dot
subplot(4,1,4);
plot(time_vec, mu_mat(:,4), 'LineWidth', lineWidth, 'Color', mainLineColor);
hold on;
grid on;
plot(time_vec, mu_mat(:,4) + 2 .* unc_mat(:,4), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
plot(time_vec, mu_mat(:,4) - 2 .* unc_mat(:,4), 'Color', boundLineColor, 'LineStyle', '--', 'LineWidth', lineWidth);
xlabel('Time (s)');
ylabel('$\dot{\eta}$ [m/s]', 'Interpreter', 'latex');
title('$\dot{\eta}$ (Velocity in y)', 'Interpreter','latex');

% Adjust layout and size
set(gcf, 'Position', [100, 100, 700, 900]);



%%%% Positive 2 sigma bounds
figure();
sgtitle('2-Sigma Uncertainty over Time');

% Set color and line width for consistency
lineColor = 'r';
lineWidth = 2;

% xi
subplot(4,1,1);
plot(time_vec, 2 .* unc_mat(:,1), 'Color', lineColor, 'LineStyle', '-', 'LineWidth', lineWidth);
grid on;
xlabel('Time (s)');
ylabel('$2\sigma_{\xi}$ [m]', 'Interpreter', 'latex');
title('$2\sigma_{\xi}$ (Position in x)', 'Interpreter', 'latex');

% xi dot
subplot(4,1,2);
plot(time_vec, 2 .* unc_mat(:,2), 'Color', lineColor, 'LineStyle', '-', 'LineWidth', lineWidth);
grid on;
xlabel('Time (s)');
ylabel('2$\sigma_{\dot{\xi}}$ [m/s]', 'Interpreter', 'latex');
title('$2\sigma_{\dot{\xi}}$ (Velocity in x)', 'Interpreter', 'latex');

% eta
subplot(4,1,3);
plot(time_vec, 2 .* unc_mat(:,3), 'Color', lineColor, 'LineStyle', '-', 'LineWidth', lineWidth);
grid on;
xlabel('Time (s)');
ylabel('$2\sigma_\eta$ [m]', 'Interpreter', 'latex');
title('$2\sigma_{\eta}$ (Position in y)', 'Interpreter', 'latex');

% eta dot
subplot(4,1,4);
plot(time_vec, 2 .* unc_mat(:,4), 'Color', lineColor, 'LineStyle', '-', 'LineWidth', lineWidth);
grid on;
xlabel('Time (s)');
ylabel('$2\sigma_{\dot{\eta}}$ [m/s]', 'Interpreter', 'latex');  % Fixed label with latex interpreter
title('$2\sigma_{\dot{\eta}}$ (Velocity in y)', 'Interpreter', 'latex');

% Main title and adjust layout
set(gcf, 'Position', [100, 100, 600, 800]);  % Adjust figure size
