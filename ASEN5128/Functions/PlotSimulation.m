function PlotSimulation(time, aircraft_state_array, control_input_array, fig, col) 
% Creates 6 plots from an aircraft simulation
% Inputs: 
%   time -> Time during simulation
%   aircraft_state_array -> full nx12 aircraft state over time
%   control_input_array -> control input vector nx4
%   col -> plotting options
% Output:
%   6 plots of aircraft state and control variables over time
% 
% Author: Thomas Dunnington
% Date Modified: 9/10/2024

%Plotting the inertial positions over time
figure(fig(1));
subplot(3,1,1)
plot(time, aircraft_state_array(:,1), col, 'linewidth', 2);
hold on;
grid on;
ylabel('X position (m)');
title('Aircraft Positions');

subplot(3,1,2)
plot(time, aircraft_state_array(:,2), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Y position (m)');

subplot(3,1,3)
plot(time, aircraft_state_array(:,3), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Z position (m)');


xlabel('Time (s)');


%Plotting the euler angles over time
figure(fig(2));
subplot(3,1,1)
plot(time, aircraft_state_array(:,4), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Roll (rad)');
title('Euler Angles');

subplot(3,1,2)
plot(time, aircraft_state_array(:,5), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Pitch (rad)');

subplot(3,1,3)
plot(time, aircraft_state_array(:,6), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Yaw (rad)');


xlabel('Time (s)');



%Plotting the inertial velocity in the body frame
figure(fig(3));
subplot(3,1,1)
plot(time, aircraft_state_array(:,7), col, 'linewidth', 2);
hold on;
grid on;
ylabel('uE (m/s)');
title('Inertial Velocities');

subplot(3,1,2)
plot(time, aircraft_state_array(:,8), col, 'linewidth', 2);
hold on;
grid on;
ylabel('vE (m/s)');

subplot(3,1,3)
plot(time, aircraft_state_array(:,9), col, 'linewidth', 2);
hold on;
grid on;
ylabel('wE (m/s)');


xlabel('Time (s)');


%Plotting the angular velocity
figure(fig(4));
subplot(3,1,1)
plot(time, aircraft_state_array(:,10), col, 'linewidth', 2);
hold on;
grid on;
ylabel('p (rad/s)');
title('Angular Velocities');

subplot(3,1,2)
plot(time, aircraft_state_array(:,11), col, 'linewidth', 2);
hold on;
grid on;
ylabel('q (rad/s)');

subplot(3,1,3)
plot(time, aircraft_state_array(:,12), col, 'linewidth', 2);
hold on;
grid on;
ylabel('r (rad/s)');


xlabel('Time (s)');



%Plotting each control input variable
figure(fig(5));
subplot(4,1,1)
plot(time, control_input_array(:,1), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Elevator (rad)');
title('Control Inputs');

subplot(4,1,2)
plot(time, control_input_array(:,2), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Aileron (rad)');

subplot(4,1,3)
plot(time, control_input_array(:,3), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Rudder (rad)');

subplot(4,1,4)
plot(time, control_input_array(:,4), col, 'linewidth', 2);
hold on;
grid on;
ylabel('Throttle (frac)');

xlabel('Time (s)');


%Plotting the 3 Dimensional Path of the drone
figure(fig(6));
plot3(aircraft_state_array(:,1), aircraft_state_array(:,2), -1*aircraft_state_array(:,3), col, 'linewidth', 2);
hold on;
grid on;

%Starting point
plot3(aircraft_state_array(1,1), aircraft_state_array(1,2), -1*aircraft_state_array(1,3), 'p', 'markersize', 10, 'markerFaceColor', 'green', 'markerEdgeColor', 'green');

%Ending point
plot3(aircraft_state_array(end,1), aircraft_state_array(end,2), -1*aircraft_state_array(end,3), 'p', 'markersize', 10, 'markerFaceColor', 'red', 'markerEdgeColor', 'red');

title('Aircraft Path');
xlabel('X Position (m)');
ylabel('Y Position (m)');
zlabel('Z Position (m)');


end

