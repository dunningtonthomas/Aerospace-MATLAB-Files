%% Clean
close all; clear; clc;

%% Question 1
A = [0, 0; 1,0];
B = [1; 0];
dt = 0.5;

F = expm(A*dt);

Ahat = [A,B; zeros(1,3)];

fullMat = expm(Ahat*dt);



carA = [0.5,0.5;0.5,0.5];

[vec, val] = eig(carA);