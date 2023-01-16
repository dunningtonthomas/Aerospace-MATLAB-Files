%% Clean Up
clear; close all; clc;

%% Problem 1

y0 = 1;
tSpan = [0 5];

odeFunc1 = @(t,y)diffEq1(t,y);


%Call ode45
[tFinal, yFinal] = ode45(odeFunc1, tSpan, y0);

figure();
plot(tFinal, yFinal, 'linewidth', 2);
grid on;

xlabel('Time');
ylabel('Y');
title('Title');

%% Problem 2

x10 = 3;
x20 = -1;

initState = [x10; x20];
tSpan = [0 5];
m = 2;

odeFunc2 = @(t,x)diffEq2(t,x,m);


%Call ode
[tFinal, yFinal] = ode45(odeFunc2, tSpan, initState);


%Plotting
figure();
plot(tFinal, yFinal(:,1));
hold on
plot(tFinal, yFinal(:,2));








