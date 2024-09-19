%% Clean up
close all; clear; clc;


%% Problem 1
dt = 10;
k = 398600;
r0 = 6678;
w0 = sqrt(k / r0^3);

A = [0, 1, 0, 0; w0^2 + 2*k/r0^3, 0, 0, 2*r0*w0; 0, 0, 0, 1; 0, -2*w0/r0, 0, 0];
B = [0, 0; 1, 0; 0, 0; 0, 1/r0];

F = expm(A*dt);

% Augmented matrix
Ahat = [A, B; zeros(2, length(A(1,:)) + length(B(1,:)))];

% Matrix exponential
expAhat = expm(Ahat*dt);



