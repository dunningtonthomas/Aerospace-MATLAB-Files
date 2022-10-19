%% Clean Up
clear; close all; clc;

%% Import Data
data = readmatrix('Test 06');
loadForce = data(:,1);
F0 = data(:,2);
F1 = data(:,3);
F2 = data(:,4);
F3 = data(:,5);
LVDT = data(:,6);

%Index 60 is when it starts going back down to 0 from 50 pounds
loadForce = loadForce(1:60);
F0 = F0(1:60);
F1 = F1(1:60);
F2 = F2(1:60);
F3 = F3(1:60);
LVDT = LVDT(1:60);

%F3 starts at negative 90
F3Norm = F3 - F3(1);

%Performing linear regression
coeff0 = polyfit(loadForce, F0, 1);
coeff1 = polyfit(loadForce, F1, 1);
coeff2 = polyfit(loadForce, F2, 1);
coeff3 = polyfit(loadForce, F3, 1);
coeffLVDT = polyfit(loadForce, LVDT, 1);

%Getting the slopes of each load cell which corresponds to 
slopeF0 = coeff0(1);
slopeF1 = coeff1(1);
slopeF2 = coeff2(1);
slopeF3 = coeff3(1);
slopeLVDT = coeffLVDT(1);

%Performing uncertainty analysis
%Calculating the standard deviation of the residuals



%% Plotting
%Plotting each force separately with a linear regression
%F0 Plot
figure();
xPlot = linspace(0,50,100);
scatter(loadForce, F0, 'filled', 'markerfacecolor', 'r');
hold on
yF0Plot = polyval(coeff0, xPlot);
plot(xPlot, yF0Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(lb\cdot f)$$');
ylabel('Internal Force $$(lb\cdot f)$$');
title('$$F_{0}$$ Internal Loading');


%F1 Plot
figure();
scatter(loadForce, F1, 'filled', 'markerfacecolor', 'r');
hold on
yF1Plot = polyval(coeff1, xPlot);
plot(xPlot, yF1Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(lb\cdot f)$$');
ylabel('Internal Force $$(lb\cdot f)$$');
title('$$F_{1}$$ Internal Loading');


%F2 Plot
figure();
scatter(loadForce, F2, 'filled', 'markerfacecolor', 'r');
hold on
yF2Plot = polyval(coeff2, xPlot);
plot(xPlot, yF2Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(lb\cdot f)$$');
ylabel('Internal Force $$(lb\cdot f)$$');
title('$$F_{2}$$ Internal Loading');


%F0 Plot
figure();
scatter(loadForce, F3, 'filled', 'markerfacecolor', 'r');
hold on
yF3Plot = polyval(coeff3, xPlot);
plot(xPlot, yF3Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(lb\cdot f)$$');
ylabel('Internal Force $$(lb\cdot f)$$');
title('$$F_{3}$$ Internal Loading');


%Plotting the LVDT which is the displacement
figure();
scatter(loadForce, LVDT, 'filled', 'markerfacecolor', rgb('blue'));
hold on
yLVDTPlot = polyval(coeffLVDT, xPlot);
plot(xPlot, yLVDTPlot, 'linewidth', 2, 'color', rgb('purple'));

xlabel('Applied Force $$(lb\cdot f)$$');
ylabel('Linear Displacement $$(in)$$');
title('Displacement With Varying Load Force');







