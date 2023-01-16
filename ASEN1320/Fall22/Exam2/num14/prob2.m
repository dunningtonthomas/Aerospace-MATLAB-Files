close all; clear all; clc;

tspan = [0 3.5]; 

a = 9.9;
b = 1.25;

y0 = 1;

f = @(t,y)func2(t,y,a,b); %function handle keeps a and b as constant

[tSol,ySol] = ode45(f, tspan, y0); %integration over 0  to 3.5

%lineSpec1 = marker

plot(tSol, ySol); %plot 
xticks(0:0.5:3.5);
yticks(1:0.5:6);

grid on




