function [cost] = CoordinatedTurnCostFunction(trim_variable, trim_definition, wind_inertial, aircraft_parameters)
% Returns the cost function for a coordinated turn
% Inputs: 
%   trim_definition -> [Va; gamma0; h0] -> [air speed; air relative flight path angle; height]
%   trim_variable -> [alpha0; dele0, delt0] [angle of attack; elevator;
%   throttle]
%   wind_inertial -> inertial wind velocity vector in the inertial frame
%   aircraft_parameters -> Aircraft parameters structure
% Output:
%   cost -> Coordinate turn cost function
% 
% Author: Thomas Dunnington
% Date Modified: 9/16/2024

% Get input variables
Va = trim_definition(1);
gamma0 = trim_definition(2);
h0 = trim_definition(3);
R0 = trim_definition(4);

alpha = trim_variable(1);
elevator = trim_variable(2);
throttle = trim_variable(3);
roll = trim_variable(4);
beta = trim_variable(5);
aileron = trim_variable(6);
rudder = trim_variable(7);

% Air Density
density = stdatmo(h0);

% Calculate trim
[trim_state, trim_control] = CoordinatedTurnVariableToState(trim_variable,trim_definition);

% Force Calculations
[aircraft_forces, aircraft_moments] = AircraftForcesAndMoments(trim_state, trim_control, wind_inertial, density, aircraft_parameters);

% Desired acceleration in inertial coordinates
%inertial_velocity = TransformFromBodyToInertial(trim_state(7:9), trim_state(4:6)) + wind_inertial;
% a_dir = [inertial_velocity(2); -inertial_velocity(1); 0] ./ norm([inertial_velocity(2); -inertial_velocity(1); 0]);
% ades_inertial = Va^2 / R0 * a_dir;

% Acceleration in the inertial Y direction
ades_inertial = [0; Va^2 / R0; 0];

% Rotate to body
%trim_state(4:6)
ades_body = TransformFromInertialToBody(ades_inertial, trim_state(4:6));

% Cost
cost = norm(aircraft_forces - (aircraft_parameters.m .* ades_body)) + norm(aircraft_moments) + aircraft_forces(2)^2;
%cost = norm(aircraft_forces) + norm(aircraft_moments);

end

