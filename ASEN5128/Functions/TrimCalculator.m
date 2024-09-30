function [trim_state, trim_control, trim_variables_final] = TrimCalculator(trim_definition, aircraft_parameters)
% Uses fmincon to calculate the aircraft state and control surface
% variables
% Inputs: 
%   trim_definition -> [Va; gamma0; h0] -> [air speed; air relative flight path angle; height]
%   aircraft_parameters -> Aircraft parameters structure
%   wind_inertial -> inertial wind velocity vector in the inertial frame
% Output:
%   trim_state -> Full aircraft state in trim
%   trim_control -> Full aircraft control surfaces in trim
% 
% Author: Thomas Dunnington
% Date Modified: 9/16/2024

% Cost Function handle
cost_func = @(trim_variable)TrimCostFunction(trim_variable, trim_definition, aircraft_parameters);

% Fmincon call
x0 = zeros(3,1);
[trim_variables_final, ~] = fmincon(cost_func, x0);

% Get trim state and control variables
[trim_state, trim_control] = TrimVariableToState(trim_variables_final,trim_definition);
end