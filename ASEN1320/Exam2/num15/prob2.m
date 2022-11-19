close all; clear; clc;

% variables
a = 9.9;
b = 1.25;

% t goes 0 to 3.5
tspan = [0 3.5];
y0 = 1;

f = @(t,y)func2(a,b,t,y);
[t,y] = ode45(f,tspan,y0);


plot (t,y, "linewidth",2);
grid on;

%"output2.mat" = [t,y];

