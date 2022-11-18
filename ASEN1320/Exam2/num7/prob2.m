close all; clear all; clc;

% Initialize variables
a = 9.9;
b = 1.25

% Make ode func
ode_func = @(t,y)func2(t,y,a,b);

% Integrate function
[t , y] = ode45(ode_func , [0 3.5], 1);

% Save data
save("output2.mat", "y", "t");

% Plot data
plot(t , y);