%% Clean Up
clear; close all; clc;

%% Problem 2.3

delta = linspace(0,1000,1000) / 1000; %displacement in meters

smallFunc = 32*delta; %kN

bigFunc = 40*sqrt(delta.^2 + 8*delta + 25) - 200; %kN

%Calculating error
error = (bigFunc - smallFunc) ./ bigFunc;  

%Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(delta * 1000, smallFunc, 'linewidth', 2);
hold on
plot(delta * 1000, bigFunc, 'linewidth', 2);

legend('Small Displacement Assumption', 'Not Small Displacement Assumption', 'location', 'NW'); 

xlabel('Displacement $$\delta$$ $$(mm)$$');
ylabel('Force $$(kN)$$');
title('Force and Displacement Approximation');


%Error
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(delta * 1000, error * 100, 'linewidth', 2);


xlabel('Displacement $$\delta$$ $$(mm)$$');
ylabel('Error $$(\%)$$');
title('Force and Displacement Approximation Error');






