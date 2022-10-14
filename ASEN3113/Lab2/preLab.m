%% Clean up
clear; close all; clc;


%% Import Data
%Temp in celsius
temperatures = [17.6, 21.61, 25.13, 29.22, 34.92, 38.10, 45.21, 47.01];
x1 = 1 + 3/8; %in
%Distances that correspond to the temperatures
linDist = [x1, x1 + 0.5, x1 + 1, x1 + 1.5, x1 + 2, x1 + 2.5, x1 + 3, x1 + 3.5];


%% Analysis
%Finding a linear regression
coeff = polyfit(linDist, temperatures, 1);
xFit = linspace(1, x1 + 4);
yFit = polyval(coeff, xFit); 

%Calculating the T0 which occurs when the x distance is 0
tempInitial = polyval(coeff, 0);



%Finding the mean of the residuals
resid = temperatures - polyval(coeff, linDist);
standardD = std(resid);


%% Problem 5

H = coeff(1) / 0.0254; %Converting to Celsius / m
T0 = coeff(2) + 273.15;
alpha = 4.82e-5;
L = 5 * 0.0254; %Length in meters
x = 4 * 0.0254; %Position of the last thermocouple



%Calculating the temperature over time using the fourier series
t = 1:1000;

u = zeros(length(t), 10); %Temperature values

%Calculating the sum for n = 1 to 10
for i = 1:10
    sum = 0;
    for n = 0:i
        bn = (8*H*L*(-1)^n) / ((2*n-1)^2 * pi^2);
        lambdaN = ((2*n-1)*pi) / (2*L);
        sum = sum + bn*sin(lambdaN*x)*exp(-(lambdaN^2) * alpha * t);
    end
u(:,i) = T0 + H*x + sum;
end



%% Plotting
figure();
set(0,'defaulttextinterpreter', 'latex');
scatter(linDist, temperatures, 'filled');
hold on
plot(xFit, yFit, 'linewidth', 2);

xlabel('Distance $$(in)$$');
ylabel('Temperature $$(^{\circ}C)$$');
title('Temperature Distribution');

legend('Experimental Data', 'Linear Fit', 'location', 'Nw');



%Plotting the analytical solution over time
figure();
plot(t, u1);



