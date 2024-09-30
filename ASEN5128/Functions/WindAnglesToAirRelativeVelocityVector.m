function [velocity_body] = WindAnglesToAirRelativeVelocityVector(wind_angles)
% Calculates the air relative velocity vector given the wind angles and air
% relative speed in body coordinates
% Inputs: 
%   wind_angles -> [air speed; sideslip angle; angle of attack]
% Output:
%   velocity_body -> The air relative velocity vector in body coordinates
% 
% Author: Thomas Dunnington
% Date Modified: 8/30/2024

Va = wind_angles(1);
beta = wind_angles(2);
alpha = wind_angles(3);

velocity_body = Va .* [cos(alpha)*cos(beta); sin(beta); sin(alpha)*cos(beta)];
end

