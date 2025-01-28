function [flight_angles] = FlightPathAnglesFromState(aircraft_state)
% Calculates the ground speed, course angle, and the flight path angle
% Inputs: 
%   aircraft_state -> 12x1 aircraft state
% Output:
%   flight_angles -> [Vg; chi; gamma] (ground speed, course angle, flight
%   path angle)
% 
% Author: Thomas Dunnington
% Date Modified: 9/30/2024

% Inertial velocity
inertial_vel_body = aircraft_state(7:9);
euler_angles = aircraft_state(4:6);

% Groundspeed
Vg = norm(inertial_vel_body);

% Rotate the inertial velocity into the inertial frame
inertial_vel_inertial = TransformFromBodyToInertial(inertial_vel_body, euler_angles);

% Calculate the course angle
chi = atan2(inertial_vel_inertial(2), inertial_vel_inertial(1));

% Calculate the flight path angle
gamma = asin(-1*inertial_vel_inertial(3)/Vg);

flight_angles = [Vg; chi; gamma];
end

