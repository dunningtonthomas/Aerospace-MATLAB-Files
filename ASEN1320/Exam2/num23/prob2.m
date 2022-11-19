close all, clear all, clc

a = 9.9;
b = 1.25;
tspan = [0 3.5];

f = @(t,y)func2(t,y,a,b);

[tout, yout] = ode45(f,tspan,1);

fid = fopen('output2.mat','Wb');
fwrite(fid,tout,'double');
fwrite(fid,yout,'double');

plot(tout,yout,'LineWidth',2)
grid on