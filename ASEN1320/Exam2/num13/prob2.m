close all; clear all; clc

a= 9.9;
b = 1.25;

tspan = [0,3.5];
y0 = 1;

fun2 = @(t,y)func2(t,y,a,b);

[tsol, ysol] = ode45(fun2, tspan, y0);

Sol = ones(97,2);
Sol(:,1) = tsol(:,1);
Sol(:,2) = ysol(:,1);
% 
% writematrix(Sol,'output2.mat')

plot(tsol, ysol, 'linewidth', 2.0)
grid on