%% Clean Up
clear; close all; clc;

%% Data
Vin = 1:1:10;
Vout = [0.996 1.991 2.987 3.98 4.926 5.415 5.5 5.53 5.548 5.557];

%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(Vin, Vout, 'linewidth', 2, 'marker', '.', 'markersize', 25, 'markerfacecolor', 'k', 'markeredgecolor', 'k');

xlabel('Vin (V)');
ylabel('Vout (V)');
title('Zener Diode Voltage vs Input');