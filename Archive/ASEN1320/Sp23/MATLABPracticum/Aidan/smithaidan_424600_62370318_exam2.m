clc, clear, close all;

F = @(t, y)func2(t, y, 11.2, 1.2);

tspan = [0, 6.5];

[tout, yout] = ode45(F, tspan, 0);

dydt = F(tout, yout);

matrix = [tout, dydt, yout];

writematrix(matrix, 'output.csv')

figure()
subplot(2,1,1)
plot(tout, dydt)
xlabel("t")
ylabel("dy/dt")
title("Rate of Change")

subplot(2,1,2)
plot(tout, yout)
xlabel("t")
ylabel("y")
title("Numerical Integration")