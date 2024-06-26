%% Clean Up
close all; clear; clc;

%% Import Data
data = readmatrix('k1_109_k2_38');
data2 = readmatrix('k1_109_k2_38_k3_10');
pos = data(2:end,3); %rad
pos2 = data2(2:end, 3);
time = data(2:end,1) / 1000; %s
time2 = data2(2:end,1) / 1000; %s
current = data(2:end,4);

%Truncate time
time = time - time(1) - 0.87;
time2 = time2 - time2(1) - 0.5;

%Convert current to torque
torque = current * 33.5;


%% Analysis

%Truncate experimental data
pos = pos(time >= 0 & time <= 2.5);
torque = torque(time >= 0 & time <= 2.5);
time = time(time >= 0 & time <= 2.5);

pos2 = pos2(time2 >= 0 & time2 <= 2.5);
time2 = time2(time2 >= 0 & time2 <= 2.5);

k1 = 109;
k2 = 38;
I = 0.0095 * 1000;

closedSys = tf([k1/I], [1 k2/I k1/I]);

%Call step function
opt = stepDataOptions('InputOffset',0,'StepAmplitude',0.5);
[output, t] = step(closedSys, opt);

%Plotting theorectical results
figure();
plot(t, output, 'linewidth', 2, 'color', 'r');
yline(0.5, '--', 'color', 'k', 'linewidth', 2);

xlabel('Time (s)');
ylabel('Response (rad)');
title('Theoretical Closed Loop Response');
legend('Theoretical Data', 'Reference Position', 'location', 'best');



%% Plotting 
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(time, pos, 'linewidth', 2);
hold on;
plot(time2, pos2, 'linewidth', 2);
yline(0.5, '--', 'color', 'k', 'linewidth', 2);

xlabel('Time (s)');
ylabel('Response (rad)');
title('Experimental Closed Loop Response k1 = 109 k2 = 38');
legend('No Integral Control', 'Integral Control', 'Reference Position', 'location', 'best');

%Torque versus time
% figure();
% plot(time, torque, 'linewidth', 2);
% 
% xlabel('Time (s)');
% ylabel('Torque (mNm)')
% title('Reaction Wheel Torque')



