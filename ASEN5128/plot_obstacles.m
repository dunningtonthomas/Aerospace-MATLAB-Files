function fig_number = plot_obstacles(filename)
%PLOT_OBSTACLES Plots obstacles specified by the filename and returns the
%figure number

% Load obstacle data
data = readmatrix(filename); % Replace with your file name

% Plot settings
figObs = figure();
hold on;
axis equal;
grid on;

% Iterate through each obstacle
for i = 1:size(data, 1)
    % Extract vertices for the obstacle
    x_vertices = [data(i, 1), data(i, 3), data(i, 5), data(i, 7), data(i, 1)]; % Close the loop
    y_vertices = [data(i, 2), data(i, 4), data(i, 6), data(i, 8), data(i, 2)]; % Close the loop
    
    if i == 1
        % Include only the first obstacle in the legend
        fill(x_vertices, y_vertices, 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 1.5, ...
            'DisplayName', 'Prohibited Region');
    else
        % Exclude other obstacles from the legend
        fill(x_vertices, y_vertices, 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 1.5, ...
            'HandleVisibility', 'off');
    end
end

% Formatting the plot
xlabel('X (m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Y (m)', 'FontSize', 12, 'FontWeight', 'bold');
title('Prohibited Regions', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 11, 'LineWidth', 1);


xlim([0 2000])
ylim([0 2000])


fig_number = figObs.Number;
end

