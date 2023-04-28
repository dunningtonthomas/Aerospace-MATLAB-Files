clear all, close all, clc;

tspan = [0,6.5];
timey = linspace(0,6.5)
y0 = 0;

func = @(t,y)func2(t,y,11.2,1.2);
dy = func(timey,y0)

[t,y] = ode45(func,tspan,y0);

figure()
plot(timey,dy);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');

figure()
plot(t,y);
xlabel('t');
ylabel('y');
title('Numerical Integration');

fil= [t',dy',y'];

writematrix(fil, "output.csv")