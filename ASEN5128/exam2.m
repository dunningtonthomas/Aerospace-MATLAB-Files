%%
close all; clear; clc;


%% Problem 2
angles = linspace(0, 2*pi, 100);
wind_vecs_1 = -17 .* [cos(angles); sin(angles)] + [20; 0];
wind_vecs_2 = -18 .* [cos(angles); sin(angles)] + [11; -19];

% Find where they intersect
angle_diff = vecnorm(wind_vecs_2 - wind_vecs_1, 2, 1);

% Plot
figure();
plot(wind_vecs_1(2,:), wind_vecs_1(1,:), 'linewidth', 2, 'color', 'b')
hold on
grid on
plot(wind_vecs_2(2,:), wind_vecs_2(1,:), 'linewidth', 2, 'color', 'r')
scatter([-14.8; -2.627], [28.557; 3.223], 'filled', 'MarkerEdgeColor', 'm', 'MarkerFaceColor', 'm', 'Marker', 'o', 'SizeData', 120)


xlabel('w_e (East Wind Velocity m/s)')
ylabel('w_n (North Wind Velocity m/s)')
title('Possible Wind Velocity Vectors')
legend('First Measurement', 'Second Measurement', 'Possible Wind Velocity Vector', 'location', 'best')
%legend('Second Measurement', 'location', 'best')
axis equal



%% Problem 3
% Wind sensitivity analysis
Vee = [20; 0; 0];
Va = 15;
phi = 0;
theta = 5 * pi/180;
psi = 0;

beta = 2 * pi/180;
alpha = 8 * pi/180;

% Euler angles
euler_angles = [phi; theta; psi];

nominal_wind = CalculateInertialWind(Vee, euler_angles, Va, beta, alpha);


% Sensitivity analysis
