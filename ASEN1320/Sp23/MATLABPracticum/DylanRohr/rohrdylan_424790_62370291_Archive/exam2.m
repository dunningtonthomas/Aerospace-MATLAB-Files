clc, clear, close all;

a = 11.2;
b = 1.2;
t = [0 6.5];
y0 = 0;

f2 = @(t,y)func2(t,y,a,b);

[tout,yout] = ode45(f2,t,y0);

roc = f2(tout,yout);

figure();
subplot(2,1,1);
plot(tout,roc);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');

subplot(2,1,2);
plot(tout,yout);
xlabel('t');
ylabel('y');
title('Numerical Integration');

output = [tout,roc,yout];

writematrix(output, 'output.csv');




