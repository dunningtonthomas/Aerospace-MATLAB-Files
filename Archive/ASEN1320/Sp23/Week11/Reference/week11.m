%% Clean Up
close all; clear; clc;

%% Integration

%Declaring function handles
funHandle = @odeFun2;

%Time span
tspan = [0 5];

%Initial Conditions
initState = [3; -1];

%Calling ode45
[tOut, yOut] = ode45(funHandle, tspan, initState);

%% Plotting
%Problem 1
figure();
plot(tOut, yOut, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Output');
title('Recitation Assignment');
legend('x1', 'x2');

