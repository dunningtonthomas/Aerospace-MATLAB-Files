close all; clear; clc;

%% Plotting the step response of a 2nd order LTI System

syms x(t);
x(t) = 1 - 1.061*exp(-t)*sin(2.828*t + 1.23);
xss = 1;
nineXss = 1 * 0.9;
oneXss = 1 * 0.1;

time = linspace(0,10,1000);
xFunc = x(time);
[~,ind1] = min(abs(xFunc - oneXss));
[~,ind2] = min(abs(xFunc - nineXss));
t1 = time(ind1);
t2 = time(ind2);

plot(time, xFunc, 'lineWidth', 2);
hold on
xline(0.1602);
xline(0.6170);
xlabel('Time (s)');
ylabel('Response (x(t))');
title('Response Plot');
grid on

%% Step Response
G = tf([9], [1 2 9]);
figure(2)
S = stepinfo(G, 'SettlingTimeThreshold', 0.05);
step(G)