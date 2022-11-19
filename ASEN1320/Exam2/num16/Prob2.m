close all; clear all; clc;

%================Declare Variables================
t = [0 3.5];

y0 = 1;

a = 9.9;

b = 1.25;

%================Function Handle================
f = @(t,y)func2(t, y, a, b);

%================ODE Function================
[TSOL, YSOL] = ode45(f,t,y0);

%================Save to MAT File================
save('output2.mat');

%================Plotting Parameters================
plot(TSOL, YSOL, 'LineWidth',2.0);
grid on;