clear; close all; clc;

%% Reading in Data
data = readmatrix('altData');
time = data(:,1);
altPress = data(:,2);
alt = (1 - (altPress ./ 1013.25).^(1/5.2559)) ./ 0.0000225577; %Alt in meters

%% Truncating 
timeLog = time > 1.52 & time < 6.44;
time = time(timeLog);
time = time - time(1);
alt = alt(timeLog);
alt = alt - alt(1);

%% Plotting 
figure(1)
plot(time, alt, 'linewidth', 2)
grid on
title('Altimeter Data');
xlabel('Time (s)');
ylabel('Height (m)');