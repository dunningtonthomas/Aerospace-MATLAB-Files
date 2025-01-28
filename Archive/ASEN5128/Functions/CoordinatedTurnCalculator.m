function [trim_state,trim_control] = CoordinatedTurnCalculator(trim_definition, aircraft_parameters)
% Uses fmincon to calculate the aircraft state and control surface
% variables
% Inputs: 
%   trim_definition -> [Va; gamma0; h0] -> [air speed; air relative flight path angle; height]
%   aircraft_parameters -> Aircraft parameters structure
%   wind_inertial -> inertial wind velocity vector in the inertial frame
% Output:
%   cost -> Trim condition cost function
% 
% Author: Thomas Dunnington
% Date Modified: 9/16/2024

% Cost Function handle
cost_func = @(trim_variable)CoordinatedTurnCostFunction(trim_variable, trim_definition, aircraft_parameters);

% Fmincon call
x0 = zeros(7,1);
[trim_variables_final, fval] = fmincon(cost_func, x0);

% Get trim state and control variables
[trim_state, trim_control] = CoordinatedTurnVariableToState(trim_variables_final, trim_definition);
end

