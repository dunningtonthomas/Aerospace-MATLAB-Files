close all;clear all; clc

a = 9.9;
b = 1.25;
tstep = [0,3.5];
f = @(t,y)func2(t,y,a,b);
[time,state] = ode45(f,tstep, 1);

%saveas(state,'output2.mat','mmat')
writematrix(state,'output2.txt')

plot(time,state,'linewidth', 2.0)
grid on

