%% Clean
close all; clear; clc;


%% Exercise 2 controls plot
data = readmatrix('controls3.txt');

time = data(:,1);
velocity = data(:,2);
steering_angle = data(:,3);


% Plotting
figure();
subplot(2,1,1)
sgtitle('Simple Car Control Inputs')
plot(time, velocity, 'linewidth', 2, 'color', 'r')
grid on
grid minor

xlabel('Time (s)')
ylabel('Velocity Control (m/s)')

subplot(2,1,2)
plot(time, steering_angle, 'linewidth', 2, 'color', 'b')

grid on
grid minor
xlabel('Time (s)')
ylabel('Steering Angle Control (rad)')