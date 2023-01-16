close all; clear all; clc; 

a = 9.9;
b = 1.25;

tspan = [0 3.5];
y0 = 1;

f = @func2;

[t,y] = ode45(f,tspan,y0);

plot(t,y)
grid on 