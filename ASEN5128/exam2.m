%%
close all; clear; clc;


%% Problem 2
angles = linspace(0, 2*pi, 10000);
wind_vecs_1 = -17 .* [cos(angles); sin(angles)] + [20; 0];
wind_vecs_2 = -18 .* [cos(angles); sin(angles)] + [11; -9];

% Find where they intersect
angle_diff = vecnorm(wind_vecs_2 - wind_vecs_1, 2, 1);

% Plot
figure();
plot(wind_vecs_1(2,:), wind_vecs_1(1,:), 'linewidth', 2, 'color', 'b')
hold on
grid on
plot(wind_vecs_2(2,:), wind_vecs_2(1,:), 'linewidth', 2, 'color', 'r')
scatter([-15.0286; 7.96325], [27.9604; 4.9794], 'filled', 'MarkerEdgeColor', 'm', 'MarkerFaceColor', 'm', 'Marker', 'o', 'SizeData', 120)


xlabel('w_e (East Wind Velocity m/s)')
ylabel('w_n (North Wind Velocity m/s)')
title('Possible Wind Velocity Vectors')
legend('First Measurement', 'Second Measurement', 'Possible Wind Velocity Vector', 'location', 'best')
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
nom_speed = norm(nominal_wind);
nom_direction = atan2(nominal_wind(2), nominal_wind(1));

% Sensitivity analysis
del_anlge = 0.001 * pi/180;
del_phi = del_anlge;
del_theta = del_anlge;
del_psi = del_anlge;

% Calculate the wind with the sensitivity variables
euler_phi = euler_angles + [del_phi; 0; 0];
euler_theta = euler_angles + [0; del_theta; 0];
euler_psi = euler_angles + [0; 0; del_psi];

% Calculate the wind
phi_wind = CalculateInertialWind(Vee, euler_phi, Va, beta, alpha);
theta_wind = CalculateInertialWind(Vee, euler_theta, Va, beta, alpha);
psi_wind = CalculateInertialWind(Vee, euler_psi, Va, beta, alpha);

% Calculate the speed and direction
phi_speed = norm(phi_wind);
phi_direction = atan2(phi_wind(2), phi_wind(1));
theta_speed = norm(theta_wind);
theta_direction = atan2(theta_wind(2), theta_wind(1));
psi_speed = norm(psi_wind);
psi_direction = atan2(psi_wind(2), psi_wind(1));

% Sensitivity calculation
phi_speed_sens = (phi_speed - nom_speed) / del_phi;
phi_direction_sens = (phi_direction - nom_direction) / del_phi;
theta_speed_sens = (theta_speed - nom_speed) / del_theta;
theta_direction_sens = (theta_direction - nom_direction) / del_theta;
psi_speed_sens = (psi_speed - nom_speed) / del_psi;
psi_direction_sens = (psi_direction - nom_direction) / del_psi;

% Output results
% Display using fprintf
fprintf('Sensitivities:\n');
fprintf('Phi Speed Sensitivity: %.3f\n', phi_speed_sens);
fprintf('Phi Direction Sensitivity: %.3f\n', phi_direction_sens);
fprintf('Theta Speed Sensitivity: %.3f\n', theta_speed_sens);
fprintf('Theta Direction Sensitivity: %.3f\n', theta_direction_sens);
fprintf('Psi Speed Sensitivity: %.3f\n', psi_speed_sens);
fprintf('Psi Direction Sensitivity: %.3f\n', psi_direction_sens);


