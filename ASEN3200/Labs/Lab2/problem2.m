%% Clean Up
clear; close all; clc;

%% Import Data
speedData = readmatrix('data.txt'); %km/hr
speedData = speedData * (1000/3600) ./ (0.6477 / 2); %rad/s

%Time periods, (s)
timeTrial1 = [7.62; 6.88; 6.14; 5.79];
timeTrial2 = [5.35; 4.75; 4.29; 4.1];
timeTrial3 = [7.84; 6.85; 6.3; 5.81; 5.22; 4.94];
timeTrial4 = [9.11; 8.04; 7.06; 6.38; 5.91];

%Combining data, time period in first column, speeds in the second
trial1 = [timeTrial1, speedData(1:4,1)];
trial2 = [timeTrial2, speedData(1:4,2)];
trial3 = [timeTrial3, speedData(1:6,3)];
trial4 = [timeTrial4, speedData(1:5,4)];


%% Analysis
%Constants
g = 9.81;
d = 0.19; %meters from the axle to the support point
r = 0.6477 / 2; %meters, radius


%Vary the wheel spin rate from 8 to 20 rad/s
ws = linspace(15, 40, 100);

%Wp as a function of ws
wp = @(ws)((g*d)./(r^2 * ws));
wpValues = wp(ws);

%Solving for the time period given a precession rate
timePeriod = (2*pi) ./ wpValues;


%% Plotting Predicted Values
%Plotting the precession and spin rates
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(ws, wpValues, 'linewidth', 2);
hold on
plot(trial1(:,2), 2*pi ./ trial1(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial2(:,2), 2*pi ./ trial2(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial3(:,2), 2*pi ./ trial3(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial4(:,2), 2*pi ./ trial4(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');



xlabel('Spin Rate (rad/s)');
ylabel('Precession Rate (rad/s)');
title('Wheel Spin Rate vs Precession Rate');
legend('Model', 'Trial 1', 'Trial 2', 'Trial 3', 'Trial 4');


%Plotting the predicted time period versus spin rate
figure();
plot(ws, timePeriod, 'linewidth', 2);
hold on
plot(trial1(:,2), trial1(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial2(:,2), trial2(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial3(:,2), trial3(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial4(:,2), trial4(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');


xlabel('Spin Rate (rad/s)');
ylabel('Time Period (s)');
title('Wheel Spin Rate vs Time Period');
legend('Model', 'Trial 1', 'Trial 2', 'Trial 3', 'Trial 4', 'location', 'nw');



