%% Clean
close all; clear; clc;


%% Problem 1
load('midterm2_problem3b.mat')
%load('midterm2_problem3c.mat')

H = [1,0,0,0; 0,0,1,0];
num_measurements = length(yaHist(1,:));

% Sensor covariance matrix
RA = @(k)([75, 7.5; 7.5, 75] + [12.5*sin(k/10), 25.5*sin(k/10); 25.5*sin(k/10), 12.5*cos(k/10)]);

% Preallocate the stacked matrices
H_big = H;
R_big = zeros(num_measurements*2);
R_big(1:2, 1:2) = RA(1);
y_measurements = yaHist(:,1);
for i = 2:num_measurements
    % Measurement model
    H_big = [H_big; H];
    
    % Noisy measurements from data file
    y_measurements = [y_measurements; yaHist(:,i)];

    % Sensor covariance matrix
    R_big(2*i-1:2*i, 2*i-1:2*i) = RA(i);    
end


% Linear least squares
xhat_0 = inv(H_big' *inv(R_big)*H_big) * H_big' * inv(R_big) * y_measurements;
