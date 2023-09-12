%% Clean Up
close all; clear; clc;

%% Import Data
data1 = readmatrix('task1_T2_5nM');
time1 = data1(:,1) / 1000; %s
torque1 = 2.5 / 1000; %Nm
angVel1 = -1*data1(:,3) * 2*pi/60; %rad/s 

data2 = readmatrix('task1_T5nM');
time2 = data2(:,1) / 1000; %s
torque2 = 5 / 1000; %Nm
angVel2 = -1*data2(:,3) * 2*pi/60; %rad/s 

data3 = readmatrix('task1_T10nM');
time3 = data3(:,1) / 1000; %s
torque3 = 10 / 1000; %Nm
angVel3 = -1*data3(:,3) * 2*pi/60; %rad/s 

%% Analysis
%Calculate the moment of inertia
%Truncate less than 10 seconds
timeLog = time1 < 10 & time1 > 1;

%Good data
angVel1 = angVel1(timeLog);
time1 = time1(timeLog);

%Fit line to data
coeff1 = polyfit(time1, angVel1, 1);
alpha1 = coeff1(1);

%Calculate moment of inertia
moi1 = torque1 / alpha1;


%Calculate the moment of inertia
%Truncate less than 10 seconds
timeLog = time2 < 10 & time2 > 1;

%Good data
angVel2 = angVel2(timeLog);
time2 = time2(timeLog);

%Fit line to data
coeff2 = polyfit(time2, angVel2, 1);
alpha2 = coeff2(1);

%Calculate moment of inertia
moi2 = torque2 / alpha2;


%Calculate the moment of inertia
%Truncate less than 10 seconds
timeLog = time3 < 10 & time3 > 1;

%Good data
angVel3 = angVel3(timeLog);
time3 = time3(timeLog);

%Fit line to data
coeff3 = polyfit(time3, angVel3, 1);
alpha3 = coeff3(1);

%Calculate moment of inertia
moi3 = torque3 / alpha3;


%Average moment of inertia
moiAvg = mean([moi1 moi2 moi3]);




%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(time1, angVel1, 'marker', '.', 'markersize', 3, 'linestyle', 'none');
hold on
plot([1:10], polyval(coeff1, [1:10]), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Torque = 2.5 mNm')
legend('Data', 'Linear Regression', 'location', 'nw');

figure();
plot(time2, angVel2, 'marker', '.', 'markersize', 3, 'linestyle', 'none');
hold on
plot([1:10], polyval(coeff2, [1:10]), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Torque = 5 mNm')
legend('Data', 'Linear Regression', 'location', 'nw');


figure();
plot(time3, angVel3, 'marker', '.', 'markersize', 3, 'linestyle', 'none');
hold on
plot([1:10], polyval(coeff3, [1:10]), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Torque = 10 mNm')
legend('Data', 'Linear Regression', 'location', 'nw');




