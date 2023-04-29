clc, clear, close all;

func2 = @(t,y)func2(t,y,11.2,1.2);

tspan = linspace(0,6.5,100);
y0 = 0;

[dydt] = func2(tspan,y0);
[Tout, Yout] = ode45(func2,tspan,y0);

figure();
subplot(2,1,2);
plot(Tout,Yout);
xlabel('t');
ylabel('y');
title('Numerical Integration');

subplot(2,1,1);
plot(Tout,dydt);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');

output = [Tout; dydt'; Yout;];

writematrix(output, 'output.csv');