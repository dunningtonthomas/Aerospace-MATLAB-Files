clc;clear;close all;

%Variable declaration
a = 9.9;
b = 1.25;
tspan = [0 3.5];
y0 = 1;

%Creating a function handle
f = @(t,y)func2(a,b,t,y);

%Calculations
[t,y] = ode45(f,tspan,y0);

%Plotting the function
plot(t,y,'LineWidth',2);
grid on;