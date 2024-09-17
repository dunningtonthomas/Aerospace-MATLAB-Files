function [trim_state, trim_control] = TrimVariableToState(trim_variable, trim_definition)
% Calculates the aircraft trim state vector and control surface vector
% Inputs: 
%   trim_definition -> [Va; gamma0; h0] -> [air speed; air relative flight path angle; height]
%   trim_variable -> [alpha0; dele0, delt0] [angle of attack; elevator;
%   throttle]
% Output:
%   trim_state -> full 12x1 aircraft state in trim
%   trim_control -> [de; da; dr; dt] -> [elevator; aileron; rudder;
%   throttle]
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

% Pitch
theta = gamma0 + alpha;

% z position
z = -h0;

% u velocity
u = Va*cos(alpha);

% w velocity
w = Va*sin(alpha);

% Aicraft state vector
trim_state = [0;0;z;0;theta;0;u;0;w;0;0;0];

% Control Surface
trim_control = [elevator; 0; 0; throttle];

end

