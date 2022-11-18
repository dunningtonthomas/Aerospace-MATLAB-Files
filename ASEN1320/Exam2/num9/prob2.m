% clean up
close all; clear all; clc;

%variable declaration
a = 9.9;
b = 1.25;
tspan = [0 3.5];
y0 = 1;

% creating the function handle
f = @(t,y)func2(t,y,a,b);

% using ode45 to integrate
[y,t] = ode45(f,tspan,y0);

% saving the output variables to a MAT file
save('output2.mat',"y","t");

% plotting the function and setting its features
plot(y,t);
linewidth = 2.0;
grid on;