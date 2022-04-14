close all; clear; clc;

%% Experimental Data

data1 = readmatrix('rigid_5_kp_5_kd_0');
data2 = readmatrix('rigid_5_kp_10_kd_0');
data3 = readmatrix('rigid_5_kp_15_kd_1pt5');
data4 = readmatrix('rigid_5_kp_20_kd_0');

time1 = data1(:,1) / 1000;
angles1 = data1(:,2);

time2 = data2(:,1) / 1000;
angles2 = data2(:,2);

time3 = data3(:,1) / 1000;
angles3 = data3(:,2);

time4 = data4(:,1) / 1000;
angles4 = data4(:,2);

%% Plotting
figure(1)
plot(time1, angles1)
grid on

figure(2)
plot(time2, angles2)
grid on

figure(3)
plot(time3, angles3)
grid on

figure(4)
plot(time4, angles4)
grid on