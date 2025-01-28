close all; clear all; clc;

a = 9.9;
b = 1.25;
y = 1;
t = 1;
tspan = (0: 3.5);

dydt = func2(t, y, a, b )
f = dydt;

[y,t] = ode45(f ,tspan, y);
ode45 = file("output.mat");

plot(y, t, 'linewidth',2);
grid on;
