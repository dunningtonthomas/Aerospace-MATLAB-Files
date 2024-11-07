function inertial_wind = CalculateInertialWind(Ve, euler_angles, Va, beta, alpha)
% Calculates the inertial wind vector in inertial coordinates
% Inputs: (n is the number of measurements)
%   Ve = nx3 matrix of inertial velocities
%   euler_angles = n x 3 matrix of euler angles
%   Va = n x 1 vector of airspeeds
%   beta = n x 1 of sideslip
%   alpha = n x 1 of angle of attack
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