function [trim_state, trim_control] = CoordinatedTurnVariableToState(trim_variable, trim_definition)
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
R0 = trim_definition(4);

alpha = trim_variable(1);
elevator = trim_variable(2);
throttle = trim_variable(3);
roll = trim_variable(4);
beta = trim_variable(5);
aileron = trim_variable(6);
rudder = trim_variable(7);

% Position
pos_vec = [0; 0; -h0];

% Euler Angles
phi = roll;
theta = gamma0 + alpha;
psi = 0;
euler_anlges = [phi; theta; psi];

% Velocity vector
vel_vec = Va .* [cos(alpha)*cos(beta); sin(beta); sin(alpha)*cos(beta)];

% Angular velocity
chi_dot = Va / R0;
omega = TransformFromInertialToBody([0;0;chi_dot], euler_anlges);
%omega = [-sin(theta); sin(phi)*cos(theta); cos(phi)*cos(theta)] .* chi_dot;

% Aicraft state vector
trim_state = [pos_vec; euler_anlges; vel_vec; omega];

% Control Surface
trim_control = [elevator; aileron; rudder; throttle];
end


