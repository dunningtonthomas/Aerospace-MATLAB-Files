clc, clear, close all;


tspan = [0, 6.5];
xvector = linspace(0,6.5);
y0 = 0;
a = 11.2;
b = 1.2;
f = @(y)func2(t,y,a,b);
ODEfunc = @(out1,out2)ode45(f, tspan, f0);

figure();
plot(xvector, f);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');

hold on;
plot(out1, out2);
xlabel('t');
ylabel('y');
title('Numerical Integration');

writematrix(ODEfunc, 'output.csv');



