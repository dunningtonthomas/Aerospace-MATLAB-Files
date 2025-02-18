%% Clean
close all; clear; clc;


%% Problem 3b
load('midterm2_problem3b.mat')

% Measurement matrices
H = [1,0,0,0; 0,0,1,0];
num_measurements = length(yaHist(1,:));

% Transition matrix
sigma_a = 0.045;
sigma_b = -0.045;
dt = 0.5;
Fa = [1, sin(sigma_a*dt)/sigma_a, 0, -(1-cos(sigma_a*dt))/sigma_a; 
    0, cos(sigma_a*dt), 0, -sin(sigma_a*dt);
    0, (1-cos(sigma_a*dt))/sigma_a, 1, sin(sigma_a*dt)/sigma_a;
    0, sin(sigma_a*dt), 0, cos(sigma_a*dt)];

Fb = [1, sin(sigma_b*dt)/sigma_b, 0, -(1-cos(sigma_b*dt))/sigma_b; 
    0, cos(sigma_b*dt), 0, -sin(sigma_b*dt);
    0, (1-cos(sigma_b*dt))/sigma_b, 1, sin(sigma_b*dt)/sigma_b;
    0, sin(sigma_b*dt), 0, cos(sigma_b*dt)];


% Sensor covariance matrix
RA = @(k)([75, 7.5; 7.5, 75] + [12.5*sin(k/10), 25.5*sin(k/10); 25.5*sin(k/10), 12.5*cos(k/10)]);

% Preallocate the stacked matrices
H_big = H*Fa;
R_big = zeros(num_measurements*2);
R_big(1:2, 1:2) = RA(1);
y_measurements = yaHist(:,1);
for i = 2:num_measurements
    % Measurement model
    H_big = [H_big; H*Fa^i];
    
    % Noisy measurements from data file
    y_measurements = [y_measurements; yaHist(:,i)];

    % Sensor covariance matrix
    R_big(2*i-1:2*i, 2*i-1:2*i) = RA(i);    
end


% Linear least squares
xhat_0 = inv(H_big' *inv(R_big)*H_big) * H_big' * inv(R_big) * y_measurements;

% Error covariance
Pls = inv(H_big' * inv(R_big) * H_big);


%% Problem 3c
load('midterm2_problem3c.mat') % yaugHist

% Measurement matrix
H = [1,0,0,0,0,0,0,0;
    0,0,1,0,0,0,0,0;
    1,0,0,0,-1,0,0,0;
    0,0,1,0,0,0,-1,0];

% Transition matrix
F = [Fa, zeros(4,4); zeros(4,4), Fb];

% Sensor covariance
RD = [8000, 500; 500, 8000];

% Initialization
P0 = 10^6 .* eye(8);
x0 = zeros(8,1);

% Number of measurements
num_measurements = length(yaugHist(1,:));

% Recursive LLS
Pk = P0;
xhat0_k = x0;
unc_vec = sqrt(diag(Pk));
I = eye(8);
for i = 1:num_measurements
    Rk = [RA(i), zeros(2,2); zeros(2,2), RD];
    Kk = Pk* (F^i)' * H' * inv(H * F^i * Pk * (F^i)' * H' + Rk);
    xhat0_k(:,i+1) = xhat0_k(:,i) + Kk*(yaugHist(:,i) - H * F^i * xhat0_k(:,i));
    Pk = (I - Kk*H*F^i)*Pk*(I - Kk*H*F^i)' + Kk*Rk*Kk';
    unc_vec(:,i+1) = sqrt(diag(Pk));
end

% Output final estimate
fprintf('%.4f\n', xhat0_k(:,end));
Pk

% Plotting
set(groot, 'DefaultAxesFontSize', 16); % Set default font size for axes
set(groot, 'DefaultTextFontSize', 16); % Set default font size for text

% Aircraft A
time_step_vec = 1:num_measurements;
figure();
sgtitle('Initial Estimate of Aircraft A', 'Fontsize', 20)
subplot(4,1,1)
plot(time_step_vec, xhat0_k(1,2:end), 'linewidth', 2)
yline(xhat0_k(1,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g')
xlabel('Time Step (k)')
ylabel('$\hat{\xi}_{A}(0)$ (m)', 'Interpreter','latex')

subplot(4,1,2)
plot(time_step_vec, xhat0_k(2,2:end), 'linewidth', 2)
yline(xhat0_k(2,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g', 'LabelVerticalAlignment','bottom')
xlabel('Time Step (k)')
ylabel('$\hat{\eta}_{A}(0)$ (m/s)', 'Interpreter','latex')

subplot(4,1,3)
plot(time_step_vec, xhat0_k(3,2:end), 'linewidth', 2)
yline(xhat0_k(3,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g', 'LabelVerticalAlignment','bottom')
xlabel('Time Step (k)')
ylabel('$\hat{\dot{\xi}}_{A}(0)$ (m)', 'Interpreter','latex')

subplot(4,1,4)
plot(time_step_vec, xhat0_k(4,2:end), 'linewidth', 2)
yline(xhat0_k(4,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g')
xlabel('Time Step (k)')
ylabel('$\hat{\dot{\eta}}_{A}(0)$ (m/s)', 'Interpreter','latex')



% Aircraft B
time_step_vec = 1:num_measurements;
figure();
sgtitle('Initial Estimate of Aircraft B', 'Fontsize', 20)
subplot(4,1,1)
plot(time_step_vec, xhat0_k(5,2:end), 'linewidth', 2, 'Color', 'r')
yline(xhat0_k(5,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g')
xlabel('Time Step (k)')
ylabel('$\hat{\xi}_{B}(0)$ (m)', 'Interpreter','latex')

subplot(4,1,2)
plot(time_step_vec, xhat0_k(6,2:end), 'linewidth', 2, 'Color', 'r')
yline(xhat0_k(6,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g', 'LabelVerticalAlignment','top')
xlabel('Time Step (k)')
ylabel('$\hat{\eta}_{B}(0)$ (m/s)', 'Interpreter','latex')

subplot(4,1,3)
plot(time_step_vec, xhat0_k(7,2:end), 'linewidth', 2, 'Color', 'r')
yline(xhat0_k(7,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g', 'LabelVerticalAlignment','bottom')
xlabel('Time Step (k)')
ylabel('$\hat{\dot{\xi}}_{B}(0)$ (m)', 'Interpreter','latex')

subplot(4,1,4)
plot(time_step_vec, xhat0_k(8,2:end), 'linewidth', 2, 'Color', 'r')
yline(xhat0_k(8,end), 'label', 'Final Estimate', 'LineStyle','--', 'linewidth', 2, 'color', 'g')
xlabel('Time Step (k)')
ylabel('$\hat{\dot{\eta}}_{B}(0)$ (m/s)', 'Interpreter','latex')



%%%%% 2 Sigma Bounds
% Aircraft A
figure();
sgtitle('Aircraft A 2 Sigma Bounds', 'Fontsize', 20)
subplot(4,1,1)
plot(time_step_vec(2:end), 2.*unc_vec(1,3:end), 'linewidth', 2, 'LineStyle', '--')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\xi A}(0)$ (m)', 'Interpreter','latex')

subplot(4,1,2)
plot(time_step_vec(2:end), 2.*unc_vec(2,3:end), 'linewidth', 2, 'LineStyle', '--')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\eta A}(0)$ (m)', 'Interpreter','latex')

subplot(4,1,3)
plot(time_step_vec(2:end), 2.*unc_vec(3,3:end), 'linewidth', 2, 'LineStyle', '--')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\dot{\xi} A}(0)$ (m)', 'Interpreter','latex')

subplot(4,1,4)
plot(time_step_vec(2:end), 2.*unc_vec(4,3:end), 'linewidth', 2, 'LineStyle', '--')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\dot{\eta} A}(0)$ (m)', 'Interpreter','latex')



% Aircraft B
figure();
sgtitle('Aircraft B 2 Sigma Bounds', 'Fontsize', 20)
subplot(4,1,1)
plot(time_step_vec(2:end), 2.*unc_vec(5,3:end), 'linewidth', 2, 'LineStyle', '--', 'Color','r')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\xi B}(0)$ (m)', 'Interpreter','latex')


subplot(4,1,2)
plot(time_step_vec(2:end), 2.*unc_vec(6,3:end), 'linewidth', 2, 'LineStyle', '--', 'Color','r')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\eta B}(0)$ (m)', 'Interpreter','latex')


subplot(4,1,3)
plot(time_step_vec(2:end), 2.*unc_vec(7,3:end), 'linewidth', 2, 'LineStyle', '--', 'Color','r')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\dot{\xi} B}(0)$ (m)', 'Interpreter','latex')


subplot(4,1,4)
plot(time_step_vec(2:end), 2.*unc_vec(8,3:end), 'linewidth', 2, 'LineStyle', '--', 'Color','r')
xlabel('Time Step (k)')
ylabel('$2\sigma_{\dot{\eta} B}(0)$ (m)', 'Interpreter','latex')




