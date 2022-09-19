%% Clean Up
clear; close all; clc;

%% Import Data

load('RSdata_nocontrol.mat');

times = rt_estim.time(:);
xdata = rt_estim.signals.values(:,1);
ydata = rt_estim.signals.values(:,2);
zdata = rt_estim.signals.values(:,3);

psidata = rt_estim.signals.values(:,4);
thetadata = rt_estim.signals.values(:,5);
phidata = rt_estim.signals.values(:,6);

udata = rt_estim.signals.values(:,7);
vdata = rt_estim.signals.values(:,8);
wdata = rt_estim.signals.values(:,9);

pdata = rt_estim.signals.values(:,10);
qdata = rt_estim.signals.values(:,11);
rdata = rt_estim.signals.values(:,12);



%% Plotting
%Plotting the position over time
figure();
set(0,'defaulttextinterpreter','latex');
subplot(3,1,1);
plot(times, xdata, 'linewidth', 2);

ylabel('X Position (m)');

subplot(3,1,2);
plot(times, ydata, 'linewidth', 2);

ylabel('Y Position (m)');

subplot(3,1,3);
plot(times, zdata, 'linewidth', 2);

ylabel('Z Position (m)');
xlabel('Time (s)');



%Plotting the velocities over time
figure();
subplot(3,1,1);
plot(times, udata, 'linewidth', 2, 'color', 'r');

ylabel('u Velocity (m/s)');

subplot(3,1,2);
plot(times, vdata, 'linewidth', 2, 'color', 'r');

ylabel('v Velocity (m/s)');

subplot(3,1,3);
plot(times, wdata, 'linewidth', 2, 'color', 'r');

ylabel('w Velocity (m/s)');
xlabel('Time (s)');



%Plotting the Euler angles over time
figure();
subplot(3,1,1);
plot(times, phidata, 'linewidth', 2);

ylabel('$$\phi$$ (rad)');

subplot(3,1,2);
plot(times, thetadata, 'linewidth', 2);

ylabel('$$\theta$$ (rad)');

subplot(3,1,3);
plot(times, psidata, 'linewidth', 2);

ylabel('$$\psi$$ (rad)');
xlabel('Time (s)');



%Plotting the roll, pitch, and yaw rate over time
figure();
subplot(3,1,1);
plot(times, pdata, 'linewidth', 2, 'color', 'r');

ylabel('Roll Rate (rad/s)');

subplot(3,1,2);
plot(times, qdata, 'linewidth', 2, 'color', 'r');

ylabel('Pitch Rate (rad/s)');

subplot(3,1,3);
plot(times, rdata, 'linewidth', 2, 'color', 'r');

ylabel('Yaw Rate (rad/s)');
xlabel('Time (s)');







