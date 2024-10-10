function control_objectives = OrbitGuidance(aircraft_state, orbit_speed, orbit_radius, orbit_center, orbit_flag, orbit_gains)
% Guidance level control that returns gc = [hc, hcdot, xc, xcdot, Vac]
% Inputs: 
%   aircraft_state -> 12x1 aircraft state vector
%   orbit_speed -> speed of the orbit
%   orbit_radius -> radius of the desired circle
%   orbit_center -> (x,y) location of the center of the orbit
%   orbit_flag -> direction of the orbit, 1 is counter-clockwise -1 is
%   clockwise
%   orbit_gains -> .kr and .kz gains
% Output:
%   control_objectives -> [hc, hcdot, xc, xcdot, Vac]
% 
% Author: Thomas Dunnington
% Date Modified: 10/8/2024

% Current position
aircraft_position = aircraft_state(1:3);

% Calculate the clock angle
phi = atan2(aircraft_position(2) - orbit_center(2), aircraft_position(1) - orbit_center(1));

% Clamp to between 0 and 2pi
% if(phi < 0)
%     phi = phi + 2*pi;
% end
phi = mod(phi + 2*pi, 2*pi);

% Desired height
hc = -orbit_center(3);

% Desired speed
Vac = orbit_speed;

% Desired altitude rate
hcdot = 0;

% Desired course angle
d = norm(aircraft_position(1:2) - orbit_center(1:2));
xc = phi + orbit_flag * (pi/2 + atan(orbit_gains.kr*(d - orbit_radius)/orbit_radius));

% Desired course angle rate
xcdot = orbit_flag*orbit_speed / orbit_radius;

control_objectives = [hc, hcdot, xc, xcdot, Vac];
end