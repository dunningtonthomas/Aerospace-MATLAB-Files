function [v_des, lookahead_point] = splineGuidance(state, spline_curve, v, lookahead_dist)
%waypointGuidance Calculates a desired velocity vector given a spline or
%other parameterized curve
% Inputs:
%   state: [x; y; z] position
%   spline_curve: [x_spline, y_spline, z_spline] matrix of x and y waypoints along
%   spline
%   v: current speed
%   lookahead_dist: distance to track next on the curve
%
% Outputs:
%   v_des: desired inertial velocity vector
%   lookahead_point: lookahead point along the curve

% Get state values
x = state(1);
y = state(2);
z = state(3);

% Find the closest point on the curve to the current state
distances = sqrt((spline_curve(:,1) - x).^2 + (spline_curve(:,2) - y).^2);
[~, idx_min] = min(distances);

% Calculate cumulative distances along the curve starting from the closest point
cumulative_distances = [0; cumsum(sqrt(sum(diff(spline_curve(idx_min:end, :)).^2, 2)))];

% Find the index where cumulative distance exceeds the lookahead
lookahead_index = find(cumulative_distances >= lookahead_dist, 1, 'first') + idx_min - 1;

% Check if lookahead index is within bounds
if lookahead_index <= size(spline_curve, 1)
    lookahead_point = spline_curve(lookahead_index, :);
else
    lookahead_point = spline_curve(end, :); % Use the last point if the curve ends before the lookahead
end
lookahead_point = lookahead_point'; 

% Standard waypoint tracking with the lookahead point
prel = lookahead_point - state;
prel_norm = prel ./ norm(prel);
v_des = v .* prel_norm;

end

