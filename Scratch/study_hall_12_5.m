%% 
close all; clear; clc;


%% Orbit around earth
mu = 398600;
r0 = [7000; 0; 0];
v0 = 7.5 .* [0; 1; 1] ./ norm([0; 1; 1]);
x0 = [r0; v0];


% Create function handle
eomFunc = @(t,x)satelliteEOM(t,x,mu);

% Setup ode45 parameters
T_orbit = 2*pi*sqrt(norm(r0)^3 / mu);
tspan = [0 T_orbit];

% Call ode45
[TOUT, YOUT] = ode45(eomFunc, tspan, x0);


%% Plotting
% Earth's radius in meters
earth_radius = 6371;

% Generate the sphere
[X, Y, Z] = sphere(50); % Generates a unit sphere (default resolution 50x50)

% Scale the sphere to Earth's size
X = X * earth_radius;
Y = Y * earth_radius;
Z = Z * earth_radius;

% Plot the sphere
figure;
surf(X, Y, Z, 'FaceColor', 'blue', 'EdgeColor', 'none'); % Earth's surface
hold on;

% Plot the satellite orbit
plot3(YOUT(:,1), YOUT(:,2), YOUT(:,3), 'r', 'LineWidth', 2);

% Set plot settings
axis equal;
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
title('Satellite Orbit Around Earth');
grid on;


%% Function
function xdot = satelliteEOM(t, x, mu)
    % Get position and velocity
    r = x(1:3);
    v = x(4:6);
    
    % Derivatives
    drdt = v;
    dvdt = -mu / norm(r)^3 * r;
    
    % Return derivative vector
    xdot = [drdt; dvdt];
end



