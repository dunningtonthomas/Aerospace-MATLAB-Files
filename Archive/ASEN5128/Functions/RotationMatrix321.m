function R = RotationMatrix321(euler_angles)
% Calculates the 3-2-1 rotation matrix given a set of yaw, pitch, and roll
% Euler angles
% Inputs: 
%   euler_angles -> [roll; pitch; yaw]
% Output:
%   R -> 3x3 Transformation matrix
% 
% Author: Thomas Dunnington
% Date Modified: 8/30/2024

phi = euler_angles(1);
theta = euler_angles(2);
psi = euler_angles(3);

R = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta);
    sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), sin(phi)*cos(theta);
    cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi), cos(phi)*cos(theta)];
end

