close all; clear; clc;

%% Plotting the step response of a 2nd order LTI System

syms x(t);
x(t) = 0.111 - 0.136*exp(-t)*sin(2.45*t + 1.23);
xss = 0.111;
nineXss = 0.111 * 0.9;
oneXss = 0.111 * 0.1;
ans1 = solve(0.111 - 0.136*exp(-t)*sin(2.45*t + 1.23) == nineXss, t);

time = linspace(0,10,1000);

plot(time, x(time), 'lineWidth', 2);
xlabel('Time (s)');
ylabel('Response (x(t))');
title('Response Plot');
grid on