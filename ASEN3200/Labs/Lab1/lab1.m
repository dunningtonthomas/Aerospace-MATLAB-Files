%% Clean Up
clear; close all; clc;

%% Import Data
data = readmatrix('ARW_0,5A_0,2Hz');
data(1,:) = [];

time = data(:,1);
time = time - time(1); %Start at t = 0
gyroRate = data(:,2); %rad/s
inputRate = (data(:,3) / 60) * 2*pi; %rad/s

%% Analysis


%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(time, gyroRate, 'linewidth', 2);
hold on
plot(time, inputRate, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Time History of Input and Gyro Output');


