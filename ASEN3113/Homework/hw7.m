%% Clean up
clear; close all; clc;

%% Problem 2

tempFunc = @(x)(-932*exp(-0.0016447368*(3 ./ x)) + 950);
xVals = linspace(5, 60, 100);
xVals = xVals / 1000; %Convert to meters



%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(xVals * 1000, tempFunc(xVals), 'linewidth', 2);

xlabel('Velocity $(mm/s)$');
ylabel('Temperature $(^\circ C)$');
title('Temperature at Exit With Various Velocities');

