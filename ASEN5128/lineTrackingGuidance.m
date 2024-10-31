function vel_vector = lineTrackingGuidance(t, state, line, params)
%LINETRACKINGGUIDANCE Calculates a desired velocity vector given a line
%definition and a current position in 3D space
% Inputs:
%   line: struct with fields line.q unit vector of line and line.r point
%   state: [x; y; z] position
%   params: parameters for gain values

% Get state values
x = state(1);
y = state(2);
z = state(3);

% Line parameters
r = line.r;
q = line.q;

%% Lateral Tracking
% Project q and r into the north east plane
% r_xy = r(1:2);
% q_xy = q(1:2) ./ norm(q(1:2));
% 
% % Calculate chi_q
% chi_q = atan2(q_xy(1), q_xy(2));
% 
% % Calculate lateral tracking error
% px = xy_pos - r_xy;
% px_proj = dot(px, q_xy) .* q_xy;
% epy = norm(px - px_proj);
% 
% % Lateral tracking
% chi_inf = chi - chi_q;
% chi_d = -chi_inf * 2/pi * atan(params.k_path * epy);


%% Longitudinal tracking
% Find point along the line nearest to the current location
p = [x; y; z];
pr = p - r;

% Project onto q
q_proj = dot(pr, q) / dot(q, q) .* q;

% Nearest point
nearest_point = r + q_proj;

% Determine next waypoint to track
next_waypoint = nearest_point + (params.lookahead .* q);
    
% Get vector from current position to new lookahead position
dir_vector = (next_waypoint - p) ./ norm(next_waypoint - p);

% Use desired airspeed to get desired velocity vector
vel_vector = dir_vector .* params.vel_d;


end

