function inertial_wind = CalculateInertialWind(Ve, euler_angles, Va, beta, alpha)
% Calculates the inertial wind vector in inertial coordinates
% Inputs: (n is the number of measurements)
%   Ve = inertial velocity in inertial coordinates
%   euler_angles = vector of euler angles
%   Va = airspeed
%   beta = sideslip
%   alpha = angle of attack
% Outputs:
%   inertial_wind = inertial wind vector in inertial coordinates
%
% Author: Thomas Dunnington
% Modified: 11/6/2024

% Get the air relative velocity vector
wind_angles = [Va; beta; alpha];
air_rel_velocity = WindAnglesToAirRelativeVelocityVector(wind_angles);

% Convert to inertial coordinates
air_rel_velocity_inertial = TransformFromBodyToInertial(air_rel_velocity, euler_angles);

% Calculate the wind
inertial_wind = Ve - air_rel_velocity_inertial;
end