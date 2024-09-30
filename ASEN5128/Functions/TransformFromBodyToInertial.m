function vector_inertial = TransformFromBodyToInertial(vector_body, euler_angles)
% Converts the body coordinates vector to inertial coordinates using the provided euler
% angles
% Inputs: 
%   euler_angles -> [roll; pitch; yaw]
%   vector_body -> [x_B; y_B; z_B] arbitrary vector in body coordinates
% Output:
%   vector_inertial -> [x_E; y_E, z_E] vector in inertial coordinates
% 
% Author: Thomas Dunnington
% Date Modified: 8/30/2024

vector_inertial = RotationMatrix321(euler_angles)' * vector_body;
end

