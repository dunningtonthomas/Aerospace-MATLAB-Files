close all; clear; clc

%% Reading in Data
% 8 proportional 1.3 derivative
exp1 = readmatrix('data/8_1pt3');
time1 = (exp1(:,1) / 1000);
time1 = time1 - time1(1);
angle1 = exp1(:,2);

% 10 proportional 0 derivative
exp2 = readmatrix('data/10_0');
time2 = (exp2(:,1) / 1000);
time2 = time2 - time2(1);
angle2 = exp2(:,2);

% 10 proportional 0.5 derivative
exp3 = readmatrix('data/10_0pt5');
time3 = (exp3(:,1) / 1000);
time3 = time3 - time3(1);
angle3 = exp3(:,2) * -1;

% 5 proportional 0 derivative
exp4 = readmatrix('data/5_0');
time4 = (exp4(:,1) / 1000);
time4 = time4 - time4(1);
angle4 = exp4(:,2);

% 5 proportional 0.5 derivative
exp5 = readmatrix('data/5_0pt5');
time5 = (exp5(:,1) / 1000);
time5 = time5 - time5(1);
angle5 = exp5(:,2);




%% Analysis
%First data set
logVec1 = time1 > 8 & time1 < 9.5;
xFunc1 = angle1(logVec1);
tFunc1 = time1(logVec1);
[xPlot1, tPlot1] = truncate(xFunc1, tFunc1);

% Shifting Up
xPlot1 = xPlot1 - min(xPlot1);

% Shifting Time
tPlot1 = tPlot1 - tPlot1(1);

%Second Data Set, 10 with no derivative
logVec2 = time2 > 0.4 & time2 < 2.2;
xFunc2 = angle2(logVec2);
tFunc2 = time2(logVec2);
[xPlot2, tPlot2] = truncate(xFunc2, tFunc2);

% Shifting Up
xPlot2 = xPlot2 - min(xPlot2);

% Shifting Time
tPlot2 = tPlot2 - tPlot2(1);

%Third Data Set, 10 with 0.5 derivative
logVec3 = time3 > 4.25 & time3 < 5.5;
xFunc3 = angle3(logVec3);
tFunc3 = time3(logVec3);
[xPlot3, tPlot3] = truncate(xFunc3, tFunc3);

% Shifting Up
xPlot3 = xPlot3 - min(xPlot3);

% Shifting Time
tPlot3 = tPlot3 - tPlot3(1);

%Fourth Data Set, 5 with 0 derivative
logVec4 = time4 > 3.4 & time4 < 4.8;
xFunc4 = angle4(logVec4);
tFunc4 = time4(logVec4);
[xPlot4, tPlot4] = truncate(xFunc4, tFunc4);

% Shifting Up
xPlot4 = xPlot4 - min(xPlot4);

% Shifting Time
tPlot4 = tPlot4 - tPlot4(1);

%Fifth Data Set, 5 with 0.5 derivative
logVec5 = time5 > 4.9 & time5 < 6.5;
xFunc5 = angle5(logVec5);
tFunc5 = time5(logVec5);
[xPlot5, tPlot5] = truncate(xFunc5, tFunc5);

% Shifting Up
xPlot5 = xPlot5 - min(xPlot5);

% Shifting Time
tPlot5 = tPlot5 - tPlot5(1);


%% Plotting
figure(1)
set(0, 'defaultTextInterpreter', 'latex');
set(gca, 'FontSize', 12);
plot(tPlot1, xPlot1, 'linewidth', 2);
grid on
title('8 Proportional 1.3 Derivative');
xlabel('Time (s)');
ylabel('Angle (rad)');
ylim([0 1]);

figure(2)
plot(tPlot2, xPlot2, 'linewidth', 2);
grid on
hold on
plot(tPlot3, xPlot3, 'linewidth', 2)
title('10 Proportional');
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('0 Derivative', '0.5 Derivative');
ylim([0 1.2]);

figure(3)
plot(tPlot4, xPlot4, 'linewidth', 2)
grid on;
hold on;
plot(tPlot5, xPlot5, 'linewidth', 2)
title('5 Proportional');
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('0 Derivative', '0.5 Derivative');
ylim([0 1]);

%% Functions

function [x, t] = truncate(xRaw, tRaw)
    %Getting rid of noise, averaging 4 points
    %Function outputs averaged values from raw data to get rid of some
    %noise
    x = length(xRaw) / 4;
    t = length(tRaw) / 4;
    for j = 1:length(xRaw) / 4 - 1
        x1 = xRaw(4 * j);
        x2 = xRaw(4 * j + 1);
        x3 = xRaw(4 * j + 2);
        x4 = xRaw(4 * j + 3);
        
        t1 = tRaw(4 * j);
        t2 = tRaw(4 * j + 1);
        t3 = tRaw(4 * j + 2);
        t4 = tRaw(4 * j + 3);
        
        x(j) = mean([x1 x2 x3 x4]);
        t(j) = mean([t1 t2 t3 t4]);       
    end
end