function vectorB = rotateEB(vectorE, phi, theta, psi)
%This function applies a rotation matrix from the inertial frame to the
%body frame and outputs the rotated vector, inputs: vector in inertial
%frame, roll, pitch, and yaw Euler angles

rotMat = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta);
         sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), sin(phi)*cos(theta);
         cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi), cos(phi)*cos(theta)];

 vectorB = rotMat*vectorE;
     
end

