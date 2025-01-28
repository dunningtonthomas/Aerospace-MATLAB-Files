close all; clear all; clc;
%Variable declaration
a = 9.9;
b = 1.25;

y0 = 1;
tspan = [0 3.5];

%Function Handle
f2 = @(t,y)func2(t,y,a,b);

%Numerical integration
[t,y] = ode45(f2,tspan,y0);

%Making a single outputs matrix
outputs = zeros(length(t),2);
outputs(:,1) = t;
outputs(:,2) = y;

%Saving outputs to a csv file, was unable to make mat file
writematrix(outputs,'output2.csv');

%Plotting
plot(t,y,'LineWidth',2);
grid on;