function v_des = waypointGuidance(state, waypoint, v)
%waypointGuidance Calculates a desired velocity vector given a waypoint
% and a current position in 3D space
% Inputs:
%   state: [x; y; z] position
%   waypoint: desired [x; y; z] position
%   v: current speed
%
% Outputs:
%   v_des: desired inertial velocity vector

% Get state values
x = state(1);
y = state(2);
z = state(3);

xd = waypoint(1);
yd = waypoint(2);
zd = waypoint(3);

% Standard waypoint tracking, point velocity toward waypoint
prel = waypoint - state;
prel_norm = prel ./ norm(prel);
v_des = v .* prel_norm;

end

