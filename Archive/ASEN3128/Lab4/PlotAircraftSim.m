function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col) 
%This function is used to plot the results of a simulation
%Inputs: time, the 12 by n aircraft state array, the 4 by n array of
%control inputs [Z,L,M,N], the 6 by 1 vector of figure numbers to plot
%over, and the string col to indicate the plotting option for every plot

%Plotting the inertial positions over time
set(0, 'defaulttextinterpreter', 'latex');
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
ylabel('$$\phi$$ (rad)');
title('Euler Angles');

subplot(3,1,2)
plot(time, aircraft_state_array(:,5), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$\theta$$ (rad)');

subplot(3,1,3)
plot(time, aircraft_state_array(:,6), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$\psi$$ (rad)');


xlabel('Time (s)');



%Plotting the inertial velocity in the body frame
figure(fig(3));
subplot(3,1,1)
plot(time, aircraft_state_array(:,7), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$u^{E}$$ (m/s)');
title('Inertial Velocities');

subplot(3,1,2)
plot(time, aircraft_state_array(:,8), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$v^{E}$$ (m/s)');

subplot(3,1,3)
plot(time, aircraft_state_array(:,9), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$w^{E}$$ (m/s)');


xlabel('Time (s)');


%Plotting the angular velocity
figure(fig(4));
subplot(3,1,1)
plot(time, aircraft_state_array(:,10), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$p$$ (rad/s)');
title('Angular Velocities');

subplot(3,1,2)
plot(time, aircraft_state_array(:,11), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$q$$ (rad/s)');

subplot(3,1,3)
plot(time, aircraft_state_array(:,12), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$r$$ (rad/s)');


xlabel('Time (s)');



%Plotting each control input variable
figure(fig(5));
subplot(4,1,1)
plot(time, control_input_array(:,1), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$Z_{c}$$ (N)');
title('Control Inputs');

subplot(4,1,2)
plot(time, control_input_array(:,2), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$L_{c}$$ (Nm)');

subplot(4,1,3)
plot(time, control_input_array(:,3), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$M_{c}$$ (Nm)');

subplot(4,1,4)
plot(time, control_input_array(:,4), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$N_{c}$$ (Nm)');

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

