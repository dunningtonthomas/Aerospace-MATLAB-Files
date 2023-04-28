clc, clear, close all;

t = [0 6.5];
y = 0;
a = 11.2;
b = 1.2;

f = @func2.m;

[tout, yout] = ode45(f, t, 0);

figure();
subplot(1,2,1);
plot(tout,t);
title('Rate of Change');
ylabel('dy/dt');
xlabel('t');

subplot(1,2,2)
plot(yout,t);
title('Numerical Integration');
ylabel('y');
xlabel('t');

toutc = tout';
dydtc = dydt';
youtc = yout';

writematrix(toutc, dydtc, youtc,'output.csv')

