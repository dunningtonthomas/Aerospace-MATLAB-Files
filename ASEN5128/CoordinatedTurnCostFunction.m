function [cost] = CoordinatedTurnCostFunction(trim_variable, trim_definition, aircraft_parameters)
% Returns the cost function for a coordinated turn
% Inputs: 
%   trim_definition -> [Va; gamma0; h0] -> [air speed; air relative flight path angle; height]
%   trim_variable -> [alpha0; dele0, delt0] [angle of attack; elevator;
%   throttle]
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

% Assume zero wind
wind_inertial = [0;0;0];

% Calculate trim
[trim_state, trim_control] = CoordinatedTurnVariableToState(trim_variable,trim_definition);

% Force Calculations
[aircraft_forces, aircraft_moments] = AircraftForcesAndMoments(trim_state, trim_control, wind_inertial, density, aircraft_parameters);

% Acceleration in the inertial Y direction
fdes_inertial = aircraft_parameters.m * [0; Va*Va/R0; 0];

% Rotate to body
fdes_body = TransformFromInertialToBody(fdes_inertial, trim_state(4:6));

% Total force
sum_forces = aircraft_forces - fdes_body;

% Calculate aerodynamic moments
[aero_force, aero_moment] = AeroForcesAndMoments_BodyState_WindCoeffs(trim_state, trim_control, wind_inertial, density, aircraft_parameters);

% Cost
cost = norm(sum_forces) + norm(aircraft_moments) + aero_force(2)^2;

end

