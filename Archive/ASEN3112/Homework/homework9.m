%% Clean Up
clear; close all; clc;


%% Problem 3
M = [2, 0; 0, 3];
K = [1000, -1000; -1000, 2000];

w1 = sqrt((7000-5000)/12);
w2 = sqrt(1000);

mat1 = [1000-2*w1^2, -1000; -1000, 2000-3*w1^2];
det1 = det(mat1);

mat2 = [1000-2*w2^2, -1000; -1000, 2000-3*w2^2];
det2 = det(mat2);

%Finding the eigenvectors
U1 = [1; 2/3];
U2 = [1;-1];


%Normalizing the modes
M1 = U1' * M * U1;
M2 = U2' * M * U2;

phi1 = (1/sqrt(M1))*U1;
phi2 = (1/sqrt(M2))*U2;

%Checking unity
intermed = phi2' * K;

%Checking orthogonality
intermO = phi1' * M;
orthoK = phi1' * K * phi2;


%Solving
bigPhi = [phi1,phi2];


%Initial conditions
n0 = bigPhi' * M * [2;1];



%Plotting
uFinal1 = @(t)(1.8*cos(w1*t) + 0.2*cos(w2*t));
uFinal2 = @(t)(1.2*cos(w1*t) - 0.2*cos(w2*t));

times = linspace(0, 2, 1000);

figure();
set(0, 'defaulttextinterpreter', 'latex');

plot(times, uFinal1(times), 'linewidth', 2);
hold on
plot(times, uFinal2(times), 'linewidth', 2);

xlabel('Time ($$s$$)');
ylabel('Displacement ($$in$$)');
title('Response');
legend('u_{1}(t)', 'u_{2}(t)', 'location', 'best');



