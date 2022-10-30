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


%% Analysis 
%Calculating area
area = pi*((3/16)*25.4)^2 - pi*((3/16 - 1/16)*25.4)^2;

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
%Nodes 1 and 52 correspond to the F2 load cell pinned
%Nodes 17 and 68 correspond to the other load cells (the rollers), not the in line one
%Displacements at node 26

%USE THE REACTIONS FOR THE PLATE MOUNTED LOAD CELLS
%USE INTERNAL LOADING FOR THE IN-LINE LOAD CELL
%USE DISPLACEMENT AT THE MIDSPAN FOR DISPLACEMENT
loadVec = [0; 10; 20; 30; 40; 50] * 4.44822; %Newtons
disp_0 = 0;
disp_10 = -0.37034;
disp_20 = -0.74068;
disp_30 = -1.1110;
disp_40 = -1.4814;
disp_50 = -1.8517;
dispVec = [disp_0; disp_10; disp_20; disp_30; disp_40; disp_50]; %miliMeters



%Getting the reaction forces
rec17 = [0,11.121,22.242,33.363,44.484,55.595];
recf0 = rec17;
rec68 = [0,11.121,22.24,33.357, 44.476,55.595];
recf1 = rec68;
rec1  = [0,11.119,22.238,33.357,44.476,55.605];
recf2 = 2*rec1;

%Performing linear regression to get the slopes
coeffAnsys0 = polyfit(loadVec, recf0, 1);
coeffAnsys1 = polyfit(loadVec, recf1, 1);
coeffAnsys2 = polyfit(loadVec, recf2, 1);
coeffAnsysDisp = polyfit(loadVec, dispVec, 1);


%Calculating the percent difference between the experimental slope and the
%analytical slope
percentDiff0 = (coeff0(1) - coeffAnsys0(1)) / ((coeff0(1) + coeffAnsys0(1))/2) * 100;
percentDiff1 = (coeff1(1) - coeffAnsys1(1)) / ((coeff1(1) + coeffAnsys1(1))/2) * 100;
percentDiff2 = (coeff2(1) - coeffAnsys2(1)) / ((coeff2(1) + coeffAnsys2(1))/2) * 100;
percentDiffDisp = (coeffLVDT(1) - coeffAnsysDisp(1)) / ((coeffLVDT(1) + coeffAnsysDisp(1))/2) * 100;


%Finding the mean of the residuals for the ANSYS vs Experimental
%Exp - predicted
ansysResidF0 = polyval(coeff0,  loadVec) - polyval(coeffAnsys0, loadVec);
ansysAvgF0 = (polyval(coeff0,  loadVec) + polyval(coeffAnsys0, loadVec)) / 2;
meanResidF0 = mean(ansysResidF0 ./ ansysAvgF0);

ansysResidF1 = polyval(coeff1,  loadVec) - polyval(coeffAnsys1, loadVec);   
ansysAvgF1 = (polyval(coeff1,  loadVec) + polyval(coeffAnsys1, loadVec)) / 2;
meanResidF1 = mean(ansysResidF1 ./ ansysAvgF1);

ansysResidF2 = polyval(coeff2,  loadVec) - polyval(coeffAnsys2, loadVec);   
ansysAvgF2 = (polyval(coeff2,  loadVec) + polyval(coeffAnsys2, loadVec)) / 2;
meanResidF2 = mean(ansysResidF2 ./ ansysAvgF2);

ansysResidDisp = polyval(coeffLVDT,  loadVec) - polyval(coeffAnsysDisp, loadVec);   
ansysAvgDisp = (polyval(coeffLVDT,  loadVec) + polyval(coeffAnsysDisp, loadVec)) / 2;
meanResidDisp = mean(ansysResidDisp ./ ansysAvgDisp);



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
ylabel('Reaction Force $$(N)$$');
title('$$F_{0}$$ Reaction Loading');
legend('Experimental Data', 'Linear Fit', 'location', 'NW');


%F1 Plot
figure();
scatter(loadForce, F1, 'filled', 'markerfacecolor', 'r');
hold on
yF1Plot = polyval(coeff1, xPlot);
plot(xPlot, yF1Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Reaction Force $$(N)$$');
title('$$F_{1}$$ Reaction Loading');
legend('Experimental Data', 'Linear Fit', 'location', 'NW');


%F2 Plot
figure();
scatter(loadForce, F2, 'filled', 'markerfacecolor', 'r');
hold on
yF2Plot = polyval(coeff2, xPlot);
plot(xPlot, yF2Plot, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Reaction Force $$(N)$$');
title('$$F_{2}$$ Reaction Loading');
legend('Experimental Data', 'Linear Fit', 'location', 'NW');


%F3 Plot
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



%% Experimental vs Analytical

%F0 Plot
set(0, 'defaulttextinterpreter', 'latex');
figure();
xPlot = linspace(0,222.4,100);
scatter(loadForce, F0, 'filled', 'markerfacecolor', rgb('blue'));
hold on
yF0Plot = polyval(coeff0, xPlot);
plot(xPlot, yF0Plot, 'linewidth', 2, 'color', rgb('purple'));

%ANSYS
scatter(loadVec, recf0, 'filled', 'markerfacecolor', rgb('red'));
plot(loadVec, recf0, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Reaction Force $$(N)$$');
title('$$F_{0}$$ Reaction Loading');
legend('Experimental Data', 'Linear Fit', 'ANSYS Data', 'Linear Fit','location', 'NW');


%F1 Plot
figure();
scatter(loadForce, F1, 'filled', 'markerfacecolor', rgb('blue'));
hold on
yF1Plot = polyval(coeff1, xPlot);
plot(xPlot, yF1Plot, 'linewidth', 2, 'color', rgb('purple'));

%ANSYS
scatter(loadVec, recf1, 'filled', 'markerfacecolor', rgb('red'));
plot(loadVec, recf1, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Reaction Force $$(N)$$');
title('$$F_{1}$$ Reaction Loading');
legend('Experimental Data', 'Linear Fit','ANSYS Data', 'Linear Fit', 'location', 'NW');


%F2 Plot
figure();
scatter(loadForce, F2, 'filled', 'markerfacecolor', rgb('blue'));
hold on
yF2Plot = polyval(coeff2, xPlot);
plot(xPlot, yF2Plot, 'linewidth', 2, 'color', rgb('purple'));

%ANSYS
scatter(loadVec, recf2, 'filled', 'markerfacecolor', rgb('red'));
plot(loadVec, recf2, 'linewidth', 2, 'color', rgb('orange'));

xlabel('Applied Force $$(N)$$');
ylabel('Reaction Force $$(N)$$');
title('$$F_{2}$$ Reaction Loading');
legend('Experimental Data', 'Linear Fit','ANSYS Data', 'Linear Fit', 'location', 'NW');


%F3 Plot
figure();
scatter(loadForce, F3, 'filled', 'markerfacecolor', rgb('blue'));
hold on
yF3Plot = polyval(coeff3, xPlot);
plot(xPlot, yF3Plot, 'linewidth', 2, 'color', rgb('purple'));


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

%ANSYS
scatter(loadVec, dispVec, 'filled', 'markerfacecolor', rgb('red'));
plot(loadVec, dispVec, 'linewidth', 2, 'color', rgb('orange'));


xlabel('Applied Force $$(N)$$');
ylabel('Linear Displacement $$(mm)$$');
title('Displacement With Varying Load Force');
legend('Experimental Data', 'Linear Fit', 'ANSYS Data', 'Linear Fit', 'location', 'NE');



