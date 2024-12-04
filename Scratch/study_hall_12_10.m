%% 
close all; clear; clc;


%% 

% Define the range of x values
x = linspace(0, 2*pi, 500); % From -2π to 2π

% Calculate sine, cosine, and tangent values
y_sin = sin(x);
y_cos = cos(x);
y_tan = tan(x);

% Create the figure
figure;
sgtitle('Trig Functions')

% Subplot 1: Sine function
subplot(3, 1, 1); % 3 rows, 1 column, 1st subplot
plot(x, y_sin, 'b', 'LineWidth', 2);
grid on;
title('Sin');
xlabel('x');
ylabel('sin(x)');
xlim([0 2*pi])

% Subplot 2: Cosine function
subplot(3, 1, 2); % 3 rows, 1 column, 2nd subplot
plot(x, y_cos, 'r', 'LineWidth', 2);
grid on;
title('Cos');
xlabel('x');
ylabel('cos(x)');
xlim([0 2*pi])

% Subplot 3: Tangent function
subplot(3, 1, 3); % 3 rows, 1 column, 3rd subplot
plot(x, y_tan, 'g', 'LineWidth', 2);
grid on;
title('Tan');
xlabel('x');
ylabel('tan(x)');

% Adjust y-axis limits for tangent to avoid infinity spikes
ylim([-10, 10]);
xlim([0 2*pi])

% Add vertical dashed lines for undefined points in tangent
hold on
xline(pi/2, 'Color', 'k', 'LineStyle', '--', 'label', 'Undefined', 'FontSize',10)
xline(3*pi/2, 'Color', 'k', 'LineStyle', '--', 'label', 'Undefined')



%% Line plot
% Create the 3D plot
figure();
plot3(y_sin, y_cos, x, 'LineWidth', 2, 'Color', 'b'); % Thicker blue line
grid on;

% Add labels and a title
xlabel('sin(t)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('cos(t)', 'FontSize', 12, 'FontWeight', 'bold');
zlabel('t', 'FontSize', 12, 'FontWeight', 'bold');
title('Parametric 3D Plot', 'FontSize', 14, 'FontWeight', 'bold');

% Enhance appearance
set(gca, 'FontSize', 10, 'GridLineStyle', ':'); % Adjust font and grid style
% view(45, 30); % Set a better viewing angle
%axis equal; % Equal scaling for all axes

% Add a legend
legend('Parametric Curve', 'Location', 'best');






% Define the grid
[X, Y] = meshgrid(linspace(-3, 3, 1000)); % Grid range and resolution

% Define the surface function
Z = sin(sqrt(X.^2 + Y.^2)) .* cos(2 * X) .* sin(2 * Y); % Cool surface equation

% Create the surface plot
figure;
surf(X, Y, Z, 'EdgeColor', 'none'); % Surface with no edges for smoothness
colormap(turbo); % Use a vibrant colormap
colorbar; % Add a colorbar for reference

% Add lighting for a 3D effect
%lighting gouraud; % Smooth lighting
shading interp; % Interpolated shading
%light('Position', [0, 0, 10], 'Style', 'infinite'); % Add a light source

% Add labels and a title
xlabel('X', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Y', 'FontSize', 12, 'FontWeight', 'bold');
zlabel('Z', 'FontSize', 12, 'FontWeight', 'bold');
title('Surface Plot', 'FontSize', 14, 'FontWeight', 'bold');

% Set view and axis
view(45, 30); % Set a nice angle
axis tight; % Remove unnecessary space
grid on; % Add grid lines for better perception



