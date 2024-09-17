function [cost] = TrimCostFunction(trim_variable, trim_definition, aircraft_parameters)
% Returns the cost function for the trim condition 
% Inputs: 
%   trim_definition -> [Va; gamma0; h0] -> [air speed; air relative flight path angle; height]
%   trim_variable -> [alpha0; dele0, delt0] [angle of attack; elevator;
%   throttle]
%   aircraft_parameters -> Aircraft parameters structure
% Output:
%   cost -> Trim condition cost function
% 
% Author: Thomas Dunnington
% Date Modified: 9/16/2024

% Get input variables
Va = trim_definition(1);
gamma0 = trim_definition(2);
h0 = trim_definition(3);

alpha = trim_variable(1);
elevator = trim_variable(2);
throttle = trim_variable(3);

% Assume zero wind
wind_inertial = [0;0;0];

% Air Density
density = stdatmo(h0);

% Calculate trim
[trim_state, trim_control] = TrimVariableToState(trim_variable,trim_definition);

% Force Calculations
[aircraft_forces, aircraft_moments] = AircraftForcesAndMoments(trim_state, trim_control, wind_inertial, density, aircraft_parameters);

% Cost
cost = norm(aircraft_forces) + norm(aircraft_moments);

end


