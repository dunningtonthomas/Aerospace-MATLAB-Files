clc, clear, close all;

a = 11.2;
b = 1.2;

t = [0 6.5];

f2 = @(t,y)func2(t,y,a,b);

[tspan, yspan] = ode45(f2, t, 0);
dydt = func2(tspan, 0, a, b);

subplot(2,1,1);
plot(tspan, dydt);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');

subplot(2,1,2);
plot(tspan, yspan);
xlabel('t');
ylabel('y');
title('Numerical Integration');

matrix = [tspan' dydt' yspan'];

writematrix(matrix, 'output.csv');