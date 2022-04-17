close all; clear; clc;

%% Plotting the step response of a 2nd order LTI System

syms x(t);
x(t) = 1 - 1.061*exp(-t)*sin(2.828*t + 1.23);
xss = 1;
nineXss = 1 * 0.9;
oneXss = 1 * 0.1;
settleLim = 0.05 * xss;

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
yline(1 - settleLim);
yline(1 + settleLim);
xlabel('Time (s)');
ylabel('Response (x(t))');
title('Response Plot');
grid on

%% Step Response
G = tf([9], [1 2 9]);
figure(2)
S = stepinfo(G, 'SettlingTimeThreshold', 0.05);
step(G)



%% Second Question

syms x2(t);
x2(t) = exp(-3.25*t)*(cos(5.044*t) + 0.644*sin(5.044*t));
G2 = tf([1 6.5], [1 6.5 36]);
step2 = step(G2);
figure(1)
[y2,t2] = impulse(G2);
info = lsiminfo(y2, t2);

figure(1)
plot(t2, y2);
grid on

time2 = linspace(0,2,1000);

figure(2)
plot(time2, x2(time2), 'linewidth', 2);
xlabel('Time (s)');
ylabel('Response (x(t))');
title('Response Plot');
grid on

%% Third Question

syms x3(t);
x3(t) = 0.5 - 0.167*exp(-4*t) - 0.667*exp(-t);
time3 = linspace(0,8,1000);

figure(4)
G3 = tf([2], [1 5 4]);
step(G3)
info3 = stepinfo(G3, 'SettlingTimeThreshold', 0.05);

figure(3)
plot(time3, x3(time3), 'linewidth', 2);
grid on
xlabel('Time (s)');
ylabel('Response (x(t))');
title('Response Plot');