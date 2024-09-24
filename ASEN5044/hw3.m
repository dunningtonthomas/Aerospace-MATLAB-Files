%% Clean
close all; clear; clc;

%% Problem 1
A = [0, 1, 0, 0; -2, 0, 1, 0; 0, 0, 0, 1; 1, 0, -2, 0];
B = [0, 1; -1, 0; 0, 0; 1, 1];

Ahat = [A, B; zeros(2,6)];
dt = 0.05;

expMat = expm(Ahat .* dt);

omega_sample = 2*pi / dt;



