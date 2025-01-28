function vector_body = TransformFromInertialToBody(vector_inertial, euler_angles)
% Converts the inertial vector to body coordinates using the provided euler
% angles
% Inputs: 
%   euler_angles -> [roll; pitch; yaw]
%   vector_inertial -> [x_E; y_E, z_E] arbitrary inertial vector
% Output:
%   vector_body -> [x_B; y_B; z_B] vector in body coordinates
% 
% Author: Thomas Dunnington
% Date Modified: 8/30/2024

vector_body = RotationMatrix321(euler_angles)*vector_inertial;
end

    