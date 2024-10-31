function control_objectives = getControlObjectives(vel_d, height)
%GET This function takes as input a desired velocity vector and outputs the
%desired course angle, airspeed, and climb rate
% Inputs:
%   vel_d = desired velocity vector in intertial coordinates
%   height = aircraft height
% Outputs:
%   control_objectives = [h_c; h_dot_c; chi_c; chi_dot_ff; Va_c]

% Desired course angle
chi_c = atan2(vel_d(1), vel_d(2));
chi_dot_ff = 0;

% Desired height
h_dot_c = vel_d(3);

% Make desired height the position propagation after 1 second in the
% veritcal direction
h_c = height + h_dot_c * 1;

% Desired airspeed
Va_c = norm(vel_d);

control_objectives = [h_c; h_dot_c; chi_c; chi_dot_ff; Va_c];
end

