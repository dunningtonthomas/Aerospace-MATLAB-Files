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
P0 = 1000000000 .* eye(8);
x0 = zeros(8,1);

% Number of measurements
num_measurements = length(yaugHist(1,:));

% Recursive LLS
Pk = P0;
xhat0_k = x0;
I = eye(8);
for i = 1:num_measurements
    Rk = [RA(i), zeros(2,2); zeros(2,2), RD];
    Kk = Pk*H' * inv(H * Pk * H' + Rk);
    xhat0_k = xhat0_k + Kk*(yaugHist(:,i) - H * F^i * xhat0_k);
    Pk = (I - Kk*H)*Pk*(I - Kk*H)' + Kk*Rk*Kk';
end






