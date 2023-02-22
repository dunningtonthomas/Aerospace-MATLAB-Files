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

%Also adjusting moment of inertia to fit the data better
%Wp as a function of ws
r = 0.5337 / 2; %meters, radius
wpAdj = @(ws)((g*d)./(r^2 * ws));
wpValuesAdj = wpAdj(ws);

%Solving for the time period given a precession rate
timePeriod = (2*pi) ./ wpValues;

%% Error Analysis
%Combining data
timeData = [trial1(:,1); trial2(:,1); trial3(:,1); trial4(:,1)];
wpData = 2*pi ./ timeData;
spinData = [trial1(:,2); trial2(:,2); trial3(:,2); trial4(:,2)];

%Model based on the spin data
wpModel = wp(spinData);
TModel = 2*pi ./ wpModel;

%Residuals = measured - approximate
wpResid = wpData - wpModel;
TResid = timeData - TModel;


%Calculate the error 
errorPercent = wpResid ./ wpData;
meanErr =  mean(errorPercent) * 100; %Mean error percent

%%%%ERROR FOR ADJUSTED MOMENT OF INERTIA
%Model based on the spin data
wpModelAdj = wpAdj(spinData);

%Residuals = measured - approximate
wpResidAdj = wpData - wpModelAdj;

%Calculate the error 
errorPercentAdj = wpResidAdj ./ wpData;
meanErrAdj =  mean(errorPercentAdj) * 100; %Mean error percent


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


%Plotting the residuals WP
figure();
plot(spinData, wpResid, 'linestyle', 'none', 'marker', '.', 'markerEdgeColor', 'k', 'markerSize', 20);

xlabel('Spin Rate (rad/s)');
ylabel('Residual (measured - model (rad/s))');
title('Residuals of Precession Rate');

%Plotting the percent error
figure();
plot(spinData, meanErr, 'linestyle', 'none', 'marker', '.', 'markerEdgeColor', 'k', 'markerSize', 20);

xlabel('Spin Rate (rad/s)');
ylabel('Percent Error (\%)');
title('Percent Error of Precession Rate');


%Plotting the precession and spin rates ADJUSTED MOMENT OF INERTIA
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(ws, wpValuesAdj, 'linewidth', 2);
hold on
plot(trial1(:,2), 2*pi ./ trial1(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial2(:,2), 2*pi ./ trial2(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial3(:,2), 2*pi ./ trial3(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');
plot(trial4(:,2), 2*pi ./ trial4(:,1), 'marker', '.', 'markerSize', 20, 'linestyle', 'none');

xlabel('Spin Rate (rad/s)');
ylabel('Precession Rate (rad/s)');
title('Wheel Spin Rate vs Precession Rate With Adjusted Moment of Inertia');
legend('Model Adjusted', 'Trial 1', 'Trial 2', 'Trial 3', 'Trial 4');



%Plotting the residuals WP ADJUSTED
figure();
plot(spinData, wpResidAdj, 'linestyle', 'none', 'marker', '.', 'markerEdgeColor', 'k', 'markerSize', 20);

xlabel('Spin Rate (rad/s)');
ylabel('Residual (measured - model (rad/s))');
title('Residuals of Precession Rate With Adjusted Moment of Inertia');

%Plotting the percent error ADJUSTED
figure();
plot(spinData, meanErrAdj, 'linestyle', 'none', 'marker', '.', 'markerEdgeColor', 'k', 'markerSize', 20);

xlabel('Spin Rate (rad/s)');
ylabel('Percent Error (\%)');
title('Percent Error of Precession Rate With Adjusted Moment of Inertia');



