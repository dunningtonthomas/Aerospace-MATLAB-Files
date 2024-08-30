function [wind_angles] = AirRelativeVelocityVectorToWindAngles(velocity_body)
% Calculates the wind angles and air speed given the air relative velocity
% vector
% Inputs: 
%   velocity_body -> The air relative velocity vector in body coordinates
% Output:
%   wind_angles -> [air speed; sideslip angle; angle of attack]
% 
% Author: Thomas Dunnington
% Date Modified: 8/30/2024

Va = norm(velocity_body);
beta = asin(velocity_body(2) / Va);
alpha = atan2(velocity_body(3), velocity_body(1));

wind_angles = [Va; beta; alpha];
end

