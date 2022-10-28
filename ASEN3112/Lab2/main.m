%% Clean Up
clear; close all; clc;

%% Import Data
data = readmatrix('Test 06');
loadForce = data(:,1) * 4.44822;
F0 = data(:,2) * 4.44822;
F1 = data(:,3) * 4.44822;
F2 = data(:,4) * 4.44822;
F3 = data(:,5) * 4.44822;
LVDT = data(:,6) * 25.4;

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
%Residuals are actual minus estimated

%F0
residF0 = F0 - polyval(coeff0, loadForce);
stdF0 = std(residF0);

%F1
residF1 = F1 - polyval(coeff1, loadForce);
stdF1 = std(residF1);

%F2
residF2 = F2 - polyval(coeff2, loadForce);
stdF2 = std(residF2);

%F3
residF3 = F3 - polyval(coeff3, loadForce);
stdF3 = std(residF3);

%F4
residLVDT = LVDT - polyval(coeffLVDT, loadForce);
stdLVDT = std(residLVDT);

%Quanitifying the standard deviation with percent of the maximum
%measurement
stdF0Perc = stdF0 / max(abs(F0));
stdF1Perc = stdF1 / max(abs(F1));
stdF2Perc = stdF2 / max(abs(F2));
stdF3Perc = stdF3 / max(abs(F3));
stdLVDTPerc = stdLVDT / max(abs(LVDT));

%% Analyzing the ANSYS Data and Comparing
%Nodes 1 and 52 correspond to the F2 load cell
%Nodes 17 and 68 correspond to the other load cells, not the in line one

%USE THE REACTIONS FOR THE PLATE MOUNTED LOAD CELLS
%USE INTERNAL LOADING FOR THE IN-LINE LOAD CELL
%USE DISPLACEMENT AT THE MIDSPAN FOR DISPLACEMENT






%% Plotting
%Plotting each force separately with a linear regression
%F0 Plot
set(0, 'defaulttextinterpreter', 'latex');
figure();
xPlot = linspace(0,222.4,100);
scatter(loadForce, F0, 'filled', 'markerfacecolor', 'r');
hold on
yF0Plot = polyval(coeff0, xPlot);
plot(xPlot, yF0Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Internal Force $$(N)$$');
title('$$F_{0}$$ Internal Loading');
legend('Experimental Data', 'Linear Fit', 'location', 'NW');


%F1 Plot
figure();
scatter(loadForce, F1, 'filled', 'markerfacecolor', 'r');
hold on
yF1Plot = polyval(coeff1, xPlot);
plot(xPlot, yF1Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Internal Force $$(N)$$');
title('$$F_{1}$$ Internal Loading');
legend('Experimental Data', 'Linear Fit', 'location', 'NW');


%F2 Plot
figure();
scatter(loadForce, F2, 'filled', 'markerfacecolor', 'r');
hold on
yF2Plot = polyval(coeff2, xPlot);
plot(xPlot, yF2Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Internal Force $$(N)$$');
title('$$F_{2}$$ Internal Loading');
legend('Experimental Data', 'Linear Fit', 'location', 'NW');


%F0 Plot
figure();
scatter(loadForce, F3, 'filled', 'markerfacecolor', 'r');
hold on
yF3Plot = polyval(coeff3, xPlot);
plot(xPlot, yF3Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Internal Force $$(N)$$');
title('$$F_{3}$$ Internal Loading');
legend('Experimental Data', 'Linear Fit', 'location', 'NW');


%Plotting the LVDT which is the displacement
figure();
scatter(loadForce, LVDT, 'filled', 'markerfacecolor', rgb('blue'));
hold on
yLVDTPlot = polyval(coeffLVDT, xPlot);
plot(xPlot, yLVDTPlot, 'linewidth', 2, 'color', rgb('purple'));

xlabel('Applied Force $$(N)$$');
ylabel('Linear Displacement $$(mm)$$');
title('Displacement With Varying Load Force');
legend('Experimental Data', 'Linear Fit', 'location', 'NE');







