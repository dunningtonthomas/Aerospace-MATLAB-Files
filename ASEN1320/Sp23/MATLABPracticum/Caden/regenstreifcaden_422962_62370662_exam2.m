clc; close all; clear;
%%
a = 11.2;
b = 1.2;
y = 0;
tspan = [0,6.5];

%%
F = @(t, y)func2(t, y, a, b);
%%

[T, Y] = ode45(F, tspan, y);
f = F(T,y);

%%
figure()
plot (T, Y)
xlabel("t")
ylabel("y")
title("Numerical Integrateion")

figure()
plot(f,Y)
xlabel("t")
ylabel("dydt")
title("Rate of Change")
%%
A = [T;f,Y];
csvwrite("output",A);

