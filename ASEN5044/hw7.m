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
subplot(4,1,1);
plot(time_vec, mu_mat(:,1), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,1) + 2.*unc_mat(:,1), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);
plot(time_vec, mu_mat(:,1) - 2.*unc_mat(:,1), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\xi [m]')

% xi dot
subplot(4,1,2);
plot(time_vec, mu_mat(:,2), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,2) + 2.*unc_mat(:,2), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);
plot(time_vec, mu_mat(:,2) - 2.*unc_mat(:,2), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\dot{\xi} [m/s]')

% eta 
subplot(4,1,3);
plot(time_vec, mu_mat(:,3), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,3) + 2.*unc_mat(:,3), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);
plot(time_vec, mu_mat(:,3) - 2.*unc_mat(:,3), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\eta [m]')

% eta dot
subplot(4,1,4);
plot(time_vec, mu_mat(:,4), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,4) + 2.*unc_mat(:,4), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);
plot(time_vec, mu_mat(:,4) - 2.*unc_mat(:,4), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\eta dot [m/s]')


%%%% Only positive 2sigma values
figure();
subplot(4,1,1);
plot(time_vec, mu_mat(:,1), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,1) + 2.*unc_mat(:,1), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\xi [m]')

% xi dot
subplot(4,1,2);
plot(time_vec, mu_mat(:,2), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,2) + 2.*unc_mat(:,2), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\dot{\xi} [m/s]')

% eta 
subplot(4,1,3);
plot(time_vec, mu_mat(:,3), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,3) + 2.*unc_mat(:,3), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\eta [m]')

% eta dot
subplot(4,1,4);
plot(time_vec, mu_mat(:,4), 'linewidth', 2, 'Color','b')
hold on
grid on
plot(time_vec, mu_mat(:,4) + 2.*unc_mat(:,4), 'color', 'r', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Time (s)')
ylabel('\eta dot [m/s]')