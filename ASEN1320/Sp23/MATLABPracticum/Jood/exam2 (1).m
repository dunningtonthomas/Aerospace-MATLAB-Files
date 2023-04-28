clc, clear , close all;

f =@func2;
tspan = [0 10];
y0 = 10;

[t, y] = ode45(f, tspan, y0); 
%[t1,y1] = ode45(f, tspan, y0);

x = [t,y];

figure()
plot(t,y)
title("Numerical Integration")
xlabel("t")
ylabel("y")


ychange = ode45(~,y)

writematrix(x,'output.csv');