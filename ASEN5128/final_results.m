%% Clean
close all; clear; clc;


%% Load Data
rrt_data = load("RRTWaypointPath.mat");
spline_data = load("splinePath.mat");
kino_data = load("DubinsPath.mat");


%% Compute the final time and the path length of each path
% Compute the differences between consecutive points
differences = diff(rrt_data.aircraft_array(1:3,:)');  % This gives a (N-1)x3 matrix of differences
segment_lengths = sqrt(sum(differences.^2, 2));  % Sum along the 2nd dimension
total_path_length = sum(segment_lengths);
disp(['RRT Path Length: ', num2str(total_path_length)]);

differences = diff(spline_data.aircraft_array(1:3,:)');  % This gives a (N-1)x3 matrix of differences
segment_lengths = sqrt(sum(differences.^2, 2));  % Sum along the 2nd dimension
total_path_length = sum(segment_lengths);
disp(['Spline Path Length: ', num2str(total_path_length)]);

differences = diff(kino_data.aircraft_array(1:3,:)');  % This gives a (N-1)x3 matrix of differences
segment_lengths = sqrt(sum(differences.^2, 2));  % Sum along the 2nd dimension
total_path_length = sum(segment_lengths);
disp(['Dubins Path Length: ', num2str(total_path_length)]);


%% Load in the desired paths and compare the actual path
rrt_waypoints = getWaypoints("Data/waypoints_1", 100);
x_spline = linspace(min(rrt_waypoints(:,1)), max(rrt_waypoints(:,1)), length(spline_data.aircraft_array(1,:)));
y_spline = spline(rrt_waypoints(:,1), rrt_waypoints(:,2), x_spline);
spline_waypoints = [x_spline', y_spline', ones(length(x_spline), 1) .* 100];

% Linearly interpolate
total_points = 1696;
t_original = linspace(1, 9, size(rrt_waypoints, 1));
t_interpolated = linspace(1, 9, total_points);
interpolated_x = interp1(t_original, rrt_waypoints(:, 1), t_interpolated, 'linear');
interpolated_y = interp1(t_original, rrt_waypoints(:, 2), t_interpolated, 'linear');
interpolated_z = interp1(t_original, rrt_waypoints(:, 3), t_interpolated, 'linear');
rrt_interp_waypoints = [interpolated_x', interpolated_y', interpolated_z'];

% Load in the Dubins path waypoints
dubin_waypoints = getWaypoints("Data/waypoints_kino_2", 100);

% Linearly interpolate
total_points = 1483;
t_original = linspace(1, 9, size(dubin_waypoints, 1));
t_interpolated = linspace(1, 9, total_points);
interpolated_x = interp1(t_original, dubin_waypoints(:, 1), t_interpolated, 'linear');
interpolated_y = interp1(t_original, dubin_waypoints(:, 2), t_interpolated, 'linear');
interpolated_z = interp1(t_original, dubin_waypoints(:, 3), t_interpolated, 'linear');
dubin_interp_waypoints = [interpolated_x', interpolated_y', interpolated_z'];


% Calculate the cross track error for each guidance algorithm
% RRT waypoints
for i = 1:length(rrt_data.aircraft_array(1,:))
    current_pos = rrt_data.aircraft_array(1:3, i);
    current_pos(3) = current_pos(3) * -1;
    distances = sqrt(sum((rrt_interp_waypoints' - current_pos).^2, 1));
    cte(i) = min(distances);  % Minimum distance to desired path
end

% Calculate the RMS of the cte
rms_cte_rrt = sqrt(mean(cte.^2));
disp(['RRT Cross-Track Error: ', num2str(rms_cte_rrt)]);


% Spline waypoints
for i = 1:length(spline_data.aircraft_array(1,:))
    current_pos = spline_data.aircraft_array(1:3, i);
    current_pos(3) = current_pos(3) * -1;
    distances = sqrt(sum((spline_waypoints' - current_pos).^2, 1));
    cte_spline(i) = min(distances);  % Minimum distance to desired path
end

% Calculate the RMS of the cte
spline_cte_rrt = sqrt(mean(cte_spline.^2));
disp(['Spline Cross-Track Error: ', num2str(spline_cte_rrt)]);


% Dubins waypoints
for i = 1:length(kino_data.aircraft_array(1,:))
    current_pos = kino_data.aircraft_array(1:3, i);
    current_pos(3) = current_pos(3) * -1;
    distances = sqrt(sum((dubin_interp_waypoints' - current_pos).^2, 1));
    cte_dubin(i) = min(distances);  % Minimum distance to desired path
end

% Calculate the RMS of the cte
dubin_cte_rrt = sqrt(mean(cte_dubin.^2));
disp(['Dubin Cross-Track Error: ', num2str(dubin_cte_rrt)]);


%% Plot all paths
fig_num = plot_obstacles("Data/obstacles.txt");
figure(fig_num);

% Define custom colors
color_rrt = [0.2, 0.6, 0.8];  % Light blue
color_spline = [0.8, 0.4, 0.4];  % Soft red
color_kino = [0.2, 0.8, 0.4];  % Soft green

% Plot the data with custom colors
plot(rrt_data.aircraft_array(1,:), rrt_data.aircraft_array(2,:), '-', 'Color', color_rrt, 'LineWidth', 2, 'DisplayName', 'RRT Waypoints');
hold on;
plot(spline_data.aircraft_array(1,:), spline_data.aircraft_array(2,:), '-', 'Color', color_spline, 'LineWidth', 2, 'DisplayName', 'Spline Path Following');
plot(kino_data.aircraft_array(1,:), kino_data.aircraft_array(2,:), '-', 'Color', color_kino, 'LineWidth', 2, 'DisplayName', 'Dubins Path Following');

% Formatting the plot
xlabel('East (m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('North (m)', 'FontSize', 12, 'FontWeight', 'bold');
title('Guidance Algorithm Autopilot Comparison', 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
grid on;

% Customize grid appearance
grid minor; % Add minor grid lines
set(gca, 'GridColor', [0.8 0.8 0.8], 'MinorGridColor', [0.9 0.9 0.9], 'GridAlpha', 0.6, 'MinorGridAlpha', 0.4);

% Add legend with adjusted position
legend('show', 'Location', 'best', 'FontSize', 11);

% Improve visual style of the axes
set(gca, 'FontSize', 11, 'LineWidth', 1, 'Box', 'on');


%% 3D plot
fig_num = plot_obstacles_3D("Data/obstacles.txt");
figure(fig_num);

% Define custom colors
color_rrt = [0.2, 0.6, 0.8];  % Light blue
color_spline = [0.8, 0.4, 0.4];  % Soft red
color_kino = [0.2, 0.8, 0.4];  % Soft green

% Create a 3D plot with custom colors
plot3(rrt_data.aircraft_array(1,:), rrt_data.aircraft_array(2,:), -rrt_data.aircraft_array(3,:), '-', ...
      'Color', color_rrt, 'LineWidth', 2, 'DisplayName', 'RRT Waypoints');
hold on;
plot3(spline_data.aircraft_array(1,:), spline_data.aircraft_array(2,:), -spline_data.aircraft_array(3,:), '-', ...
      'Color', color_spline, 'LineWidth', 2, 'DisplayName', 'Spline Path Following');
plot3(kino_data.aircraft_array(1,:), kino_data.aircraft_array(2,:), -kino_data.aircraft_array(3,:), '-', ...
      'Color', color_kino, 'LineWidth', 2, 'DisplayName', 'Dubins Path Following');

% Formatting the plot
xlabel('East (m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('North (m)', 'FontSize', 12, 'FontWeight', 'bold');
zlabel('Altitude (m)', 'FontSize', 12, 'FontWeight', 'bold');
title('3D Guidance Algorithm Autopilot Comparison', 'FontSize', 14, 'FontWeight', 'bold');
grid on;

% Customize grid appearance
grid minor; % Add minor grid lines
set(gca, 'GridColor', [0.8 0.8 0.8], 'MinorGridColor', [0.9 0.9 0.9], 'GridAlpha', 0.6, 'MinorGridAlpha', 0.4);

% Set aspect ratio for 3D visualization
axis equal;
view(3); % Default 3D view angle

% Add legend with adjusted position
% legend('show', 'Location', 'best', 'FontSize', 11);
legend('off')

% Improve visual style of the axes
set(gca, 'FontSize', 11, 'LineWidth', 1, 'Box', 'on');




%% Plot the controls for each method
time_iter = kino_data.time_iter;
control_array = kino_data.control_array;
customColor = color_kino;

% Plot the control values over time
figure();

% Define line width and color
lineWidth = 2;


% Define common properties for axes
fontSize = 12;
labelFontSize = 14;
titleFontSize = 16;

% Subplot 1: Elevator (de)
subplot(4, 1, 1);
plot(time_iter, control_array(1, :) * 180 / pi, '-', 'Color', customColor, 'LineWidth', lineWidth); hold on;
ylabel('$\delta e$ [$^\circ$]', 'FontSize', labelFontSize, 'FontWeight', 'bold', 'Interpreter', 'latex');
grid on;
set(gca, 'FontSize', fontSize, 'GridLineStyle', '--', 'GridAlpha', 0.6);

% Subplot 2: Aileron (da)
subplot(4, 1, 2);
plot(time_iter, control_array(2, :) * 180 / pi, '-', 'Color', customColor, 'LineWidth', lineWidth); hold on;
ylabel('$\delta a$ [$^\circ$]', 'FontSize', labelFontSize, 'FontWeight', 'bold', 'Interpreter', 'latex');
grid on;
set(gca, 'FontSize', fontSize, 'GridLineStyle', '--', 'GridAlpha', 0.6);

% Subplot 3: Rudder (dr)
subplot(4, 1, 3);
plot(time_iter, control_array(3, :) * 180 / pi, '-', 'Color', customColor, 'LineWidth', lineWidth); hold on;
ylabel('$\delta r$ [$^\circ$]', 'FontSize', labelFontSize, 'FontWeight', 'bold', 'Interpreter', 'latex');
grid on;
set(gca, 'FontSize', fontSize, 'GridLineStyle', '--', 'GridAlpha', 0.6);

% Subplot 4: Throttle (dt)
subplot(4, 1, 4);
plot(time_iter, control_array(4, :), '-', 'Color', customColor, 'LineWidth', lineWidth); hold on;
ylabel('$\delta t$', 'FontSize', labelFontSize, 'FontWeight', 'bold', 'Interpreter', 'latex');
xlabel('Time [sec]', 'FontSize', labelFontSize, 'FontWeight', 'bold');
ylim([-1 1]);
grid on;
set(gca, 'FontSize', fontSize, 'GridLineStyle', '--', 'GridAlpha', 0.6);

% Adjust subplot spacing and add overall title
sgtitle('Dubins Path Following: Aircraft Control Surfaces', 'FontSize', titleFontSize + 2, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Improve subplot spacing
set(gcf, 'Position', [100, 100, 800, 600]); % Set figure size


%% Plot the height of the aircraft states over time

figure();
subplot(3,1,1)
plot(rrt_data.time_iter, -1.*rrt_data.aircraft_array(3,:), 'linewidth', 2, 'Color', color_rrt)
grid on
grid minor; % Add minor grid lines
set(gca, 'GridColor', [0.8 0.8 0.8], 'MinorGridColor', [0.9 0.9 0.9], 'GridAlpha', 0.6, 'MinorGridAlpha', 0.4);
set(gca, 'FontSize', 11, 'LineWidth', 1, 'Box', 'on');
ylim([55 110])
xlim([0 220])
title('RRT Waypoints')

subplot(3,1,2)
plot(spline_data.time_iter, -1.*spline_data.aircraft_array(3,:), 'linewidth', 2, 'color', color_spline)
grid on
grid minor; % Add minor grid lines
set(gca, 'GridColor', [0.8 0.8 0.8], 'MinorGridColor', [0.9 0.9 0.9], 'GridAlpha', 0.6, 'MinorGridAlpha', 0.4);
set(gca, 'FontSize', 11, 'LineWidth', 1, 'Box', 'on');
ylim([55 110])
xlim([0 220])
title('Spline Path Following')
ylabel('Altitude (m)')

subplot(3,1,3)
plot(kino_data.time_iter, -1.*kino_data.aircraft_array(3,:), 'linewidth', 2, 'color', color_kino)
grid on
grid minor; % Add minor grid lines
set(gca, 'GridColor', [0.8 0.8 0.8], 'MinorGridColor', [0.9 0.9 0.9], 'GridAlpha', 0.6, 'MinorGridAlpha', 0.4);
set(gca, 'FontSize', 11, 'LineWidth', 1, 'Box', 'on');

ylim([55 110])
xlim([0 220])
title('Dubins Path Following')

xlabel('Time (s)')
sgtitle('Guidance Algorithm Altitude Comparison')


