function [aircraft_forces, aircraft_moments] = AircraftForcesAndMoments(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters)
% Takes as input the aircraft state, the control input vector,
% the inertial wind velocity in inertial coordinates, the air density, and the aircraft parameters 
% structure and returns the total force and moment acting on the aircraft expressed in body coordinates
% 
% Inputs: 
%   aircraft_state -> full 12x1 aircraft state
%   aircraft_surfaces -> control input vector [de, da, dr, dt]
%   wind_inertial -> inertial wind velocity in inertial coordinates
%   density -> air density
%   aircraft_parameters -> aircraft parameter structure
% Output:
%   aircraft_forces -> total aircraft force in body coordinates
%   aircraft_moments -> total aircraft moment in body coordinates
% 
% Author: Thomas Dunnington
% Date Modified: 9/10/2024

% Euler Angles
euler_angles = aircraft_state(4:6);

% Aerodynamic Forces and Moments
[aero_force, aero_moment] = AeroForcesAndMoments_BodyState_WindCoeffs(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);

% Gravity
fgE = [0; 0; aircraft_parameters.m * 9.81];
fgB = TransformFromInertialToBody(fgE, euler_angles);

% Total Forces and Moments
aircraft_forces = aero_force + fgB;
aircraft_moments = aero_moment;
end

