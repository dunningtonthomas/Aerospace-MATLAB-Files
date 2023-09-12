%% Clean Up
clear; close all; clc;

%% Import Data
data1 = readmatrix('ARW_0,5A_0,2Hz');
data2 = readmatrix('ARW_0,5A_0,1Hz');
data3 = readmatrix('ARW_0,25A_0,2Hz');
data1(1,:) = [];
data2(1,:) = [];
data3(1,:) = [];

time1 = data1(:,1);
time1 = time1 - time1(1); %Start at t = 0
gyroRate1 = data1(:,2); %rad/s
inputRate1 = (data1(:,3) / 60) * 2*pi; %rad/s

time2 = data2(:,1);
time2 = time2 - time2(1); %Start at t = 0
gyroRate2 = data2(:,2); %rad/s
inputRate2 = (data2(:,3) / 60) * 2*pi; %rad/s

time3 = data3(:,1);
time3 = time3 - time3(1); %Start at t = 0
gyroRate3 = data3(:,2); %rad/s
inputRate3 = (data3(:,3) / 60) * 2*pi; %rad/s

%% Analysis
%Fitting a linear regression
gyroRateFlip1 = -1*gyroRate1;
coeff1 = polyfit(inputRate1, gyroRateFlip1, 1);
xVals = linspace(-4,6,100);

coeffNew1 = [1/coeff1(1), -1*coeff1(2)];

%Apply correction to the data
gyroRateCorrect1 = polyval(coeffNew1, gyroRateFlip1);


%Fitting a linear regression
gyroRateFlip2 = -1*gyroRate2;
coeff2 = polyfit(inputRate2, gyroRateFlip2, 1);
xVals = linspace(-4,6,100);

coeffNew2 = [1/coeff2(1), -1*coeff2(2)];

%Apply correction to the data
gyroRateCorrect2 = polyval(coeffNew2, gyroRateFlip2);



%Fitting a linear regression
gyroRateFlip3 = -1*gyroRate3;
coeff3 = polyfit(inputRate3, gyroRateFlip3, 1);
xVals = linspace(-4,6,100);

coeffNew3 = [1/coeff3(1), -1*coeff3(2)];

%Apply correction to the data
gyroRateCorrect3 = polyval(coeffNew3, gyroRateFlip3);


%Table of scale factors and bias
coeffTable = [coeffNew1; coeffNew2; coeffNew1];
coeffTable(:,2) = coeffTable(:,2) * -1; %Converting back to offset

%Calculating the mean and standard deviation
averages = mean(coeffTable, 1);
stds = std(coeffTable, 1);


%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(time1, inputRate1, 'linewidth', 2);
hold on
plot(time1, gyroRate1, 'linewidth', 2);


xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Time History of Input and Gyro Output');
legend('Input Angular Velocity', 'Gyro Angular Velocity', 'location', 'best')


figure();
plot(time1, inputRate1, 'linewidth', 2);
hold on
plot(time1, gyroRateFlip1, 'linewidth', 2);


xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Time History of Input and Gyro Output Flipped');
legend('Input Angular Velocity', 'Gyro Angular Velocity', 'location', 'best')


%Gyro calibration
figure();
plot(inputRate1, gyroRateFlip1, 'linewidth', 2, 'marker', '.', 'linestyle', 'none');
hold on
plot(xVals, polyval(coeff1,xVals), 'linewidth', 2)

xlabel('Input Angular Velocity (rad/s)');
ylabel('Gyro Angular Velocity (rad/s)');
title('Input/Output Linear Regression');

legend('Raw Data', 'Linear Regression', 'location', 'nw');


%Calibrated Results
figure();
plot(time1, inputRate1, 'linewidth', 2);
hold on
plot(time1, gyroRateCorrect1, 'linewidth', 2, 'linestyle', '--');

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Time History of Input and Calibrated Gyro Output');

legend('Input Angular Velocity', 'Corrected Gyro Angular Velocity', 'location', 'best')


%% Plotting Problem 4

%%%%Input Rate and Mesured Rate
%%Data1
figure();
plot(time1, inputRate1, 'linewidth', 2);
hold on
plot(time1, gyroRateCorrect1, 'linewidth', 2, 'linestyle', '--');

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Angular Velocity Time History (0.5A 0.2Hz)');
legend('Input Rate', 'Measured Rate', 'location', 'best')


%%Data2
figure();
plot(time2, inputRate2, 'linewidth', 2);
hold on
plot(time2, gyroRateCorrect2, 'linewidth', 2, 'linestyle', '--');

xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Angular Velocity Time History (0.5A 0.1Hz)');
legend('Input Rate', 'Measured Rate', 'location', 'best')




%%%%Angular Rate Measurement Error calibrated - input
%%Data1
rateError1 = gyroRateCorrect1 - inputRate1;
figure();
plot(time1, rateError1, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Velocity Error (rad/s)');
title('Measurement Error (0.5A 0.2Hz)');

%%Data2
rateError2 = gyroRateCorrect2 - inputRate2;
figure();
plot(time2, rateError2, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Velocity Error (rad/s)');
title('Measurement Error (0.5A 0.1Hz)');


%%%%True angular position and measured angular position
%%Data1
truePos1 = cumtrapz(time1, inputRate1);
measPos1 = cumtrapz(time1, gyroRateCorrect1);
rawPos1 = cumtrapz(time1, gyroRateFlip1);
figure();
plot(time1, truePos1, 'linewidth', 2);
hold on
plot(time1, measPos1, 'linewidth', 2, 'linestyle', '--');
plot(time1, rawPos1, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Position (rad)');
title('Angular Position Time History (0.5A 0.2Hz)');
legend('True Position', 'Calibrated Measured Position', 'Raw Measured Position', 'location', 'nw')

%%Data2
truePos2 = cumtrapz(time2, inputRate2);
measPos2 = cumtrapz(time2, gyroRateCorrect2);
rawPos2 = cumtrapz(time2, gyroRateFlip2);
figure();
plot(time2, truePos2, 'linewidth', 2);
hold on
plot(time2, measPos2, 'linewidth', 2, 'linestyle', '--');
plot(time2, rawPos2, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Position (rad)');
title('Angular Position Time History (0.5A 0.1Hz)');
legend('True Position', 'Calibrated Measured Position', 'Raw Measured Position', 'location', 'nw')


%%%%Angular Position error (measured - true)
%%Data1
rawError1 = rawPos1 - truePos1;
calibError1 = measPos1 - truePos1;
figure();
plot(time1, rawError1, 'linewidth', 2);
hold on
plot(time1, calibError1, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Position Error (rad)');
title('Angular Position Error Raw and Calibrated (0.5A 0.2Hz)');
legend('Raw Error', 'Calibrated Error');


%%Data2
rawError2 = rawPos2 - truePos2;
calibError2 = measPos2 - truePos2;
figure();
plot(time2, rawError2, 'linewidth', 2);
hold on
plot(time2, calibError2, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Angular Position Error (rad)');
title('Angular Position Error Raw and Calibrated (0.5A 0.1Hz)');
legend('Raw Error', 'Calibrated Error');


