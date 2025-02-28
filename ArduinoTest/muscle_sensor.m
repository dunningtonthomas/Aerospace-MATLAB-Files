%% Muscle Sensor Testing
% Collect data from the muscle sensor and plot
% Author: Thomas Dunnington
% Modified: 2/28/2025
close all; clear; clc;

%% Read Data
% Connect to Arduino
a = arduino('COM6');

% Setup live plot
figure;
h = animatedline('Marker','o', 'Color', 'r');
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Live Voltage Data');

% Read voltage in loop
startTime = datetime('now');
while true
    % Read voltage
    voltage = a.readVoltage('A0');
    fprintf("Voltage: %f\n", voltage);

    % Live plot of voltage data
    elapsedTime = seconds(datetime('now') - startTime);
    addpoints(h, elapsedTime, voltage);
    drawnow;   
end


