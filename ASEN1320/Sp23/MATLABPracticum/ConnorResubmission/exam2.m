clc, clear, close all;

tspan = [0, 6.5];
y0 = 0;
a = 11.2;
b = 1.2;
odehand = @(t, y)func2(t, y, a, b);

[Tout, Yout] = ode45(odehand, tspan, y0);

hold = length(Tout);
rateY = zeros(hold, 1);
for n = 1:hold
    rateY(n, 1) = odehand(Tout(n), Yout(n));
end

figure()

subplot(2, 1, 1)
plot(Tout, rateY)
title("Rate of Change")
xlabel('t')
ylabel("dy/dt")
axis([0 7 -0.5 1.5])

subplot(2, 1, 2)
plot(Tout, Yout)
title("Numerical Integration")
xlabel("t")
ylabel("y")
axis([0 7 -0.2 0.4])