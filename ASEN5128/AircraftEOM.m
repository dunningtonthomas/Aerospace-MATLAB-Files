function [xdot] = AircraftEOM(time,aircraft_state,aircraft_surfaces,wind_inertial,aircraft_parameters)
% Calculates the full nonlinear equations of motion of the aircraft given a
% current state
% Inputs: 
%   time -> Time during simulation
%   aircraft_state -> full 12x1 aircraft state
%   aircraft_surfaces -> control input vector [de, da, dr, dt]
%   wind_inertial -> inertial wind velocity in inertial coordinates
%   aircraft_parameters -> aircraft parameter structure
% Output:
%   xdot -> Rate of change of the aircraft state
% 
% Author: Thomas Dunnington
% Date Modified: 9/10/2024

% Allocation
xdot = ones(12,1);

% State parameters
position = aircraft_state(1:3);
euler_angles = aircraft_state(4:6);
velocity_inertial = aircraft_state(7:9);
angular_velocity = aircraft_state(10:12);

% Velocity
vel_inertial = TransformFromBodyToInertial(velocity_inertial, euler_angles);

% Euler rates
phi = euler_angles(1);
theta = euler_angles(2);
psi = euler_angles(3);

ang_vel_mat = [1, sin(phi)*tan(theta), cos(phi)*tan(theta);
    0, cos(phi), -sin(phi);
    0, sin(phi)*sec(theta), cos(phi)*sec(theta)];

euler_rates = ang_vel_mat*angular_velocity;

% Velocity components
p = angular_velocity(1);
q = angular_velocity(2);
r = angular_velocity(3);

% Define skew semetric matrix
omega_b = [0, -r, q; r, 0, -p; -q, p, 0];

% Define inertial matrix
IB = aircraft_parameters.inertia_matrix;

% Aircraft Forces
rho = stdatmo(-1*aircraft_state(3));
[aircraft_forces, aircraft_moments] = AircraftForcesAndMoments(aircraft_state, aircraft_surfaces, wind_inertial, rho, aircraft_parameters);

% Acceleration
vel_body_dot = -omega_b*velocity_inertial + 1/aircraft_parameters.m * aircraft_forces;

% Time rate of change of angular velocity
omega_body_dot = inv(IB)*(-1*omega_b*(IB*angular_velocity) + aircraft_moments);

% Full state derivatives
xdot = [vel_inertial; euler_rates; vel_body_dot; omega_body_dot];

end

