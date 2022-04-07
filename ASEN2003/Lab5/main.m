close all; clear; clc;

%% Reading in Data
dataMat = readmatrix('rigid_5_kp_5_kd_0');
timeVec = dataMat(:,1) ./ 1000; %Seconds
timeVec = timeVec - timeVec(1);
angleVec = dataMat(:,2);


%% Plotting
figure(1)
plot(timeVec, angleVec);
grid on