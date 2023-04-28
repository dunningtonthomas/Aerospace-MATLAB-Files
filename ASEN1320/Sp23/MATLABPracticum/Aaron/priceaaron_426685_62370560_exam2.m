clear; close all; clc;

func = @(t,y)func2(t,y,11.2,1.2);
tspan = [0,6.5];
y0 = 0;
[tOut,yOut] = ode45(func,tspan,y0);
dydt = func(tOut, yOut);

figure()
tiledlayout(2,1)
nexttile;
plot(tOut, dydt);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');
nexttile;
plot(tOut, yOut);
xlabel('x');
ylabel('y');
title('Numerical Integration');

output = [tOut,dydt,yOut];
writematrix(output, 'output.csv');

