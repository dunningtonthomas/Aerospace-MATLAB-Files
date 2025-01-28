close all; clear all; clc;

A = 9.9;
B = 1.25;
y0 = 1; %initial conditions and constants

tspan = [0, 3.5]; %setting up the timespan to run ode45 through

f = @(t,y)func2(t,y,A,B); %assigning to function handle f and keeping A and B constant

[t, yFinal] = ode45(f, tspan, y0); %running through ode45 to produce 2 matrices of differential and time valuse

plot(t, yFinal, "LineWidth",2) %plotting with thicker lines
grid on