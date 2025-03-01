%% Clean Up
clear; close all; clc;

%% Problem 4
BN_Boi = rotateEB(60 * pi/180, -45 * pi/180, 30 * pi/180);
FN_Boi = rotateEB(-15*pi/180, 25*pi/180, -25*pi/180);

BF_Boi = BN_Boi * (FN_Boi');
     
     
%% Functions
function mat = rotateEB(phi, theta, psi)
%This function applies a rotation matrix from the inertial frame to the
%body frame and outputs the rotated vector, inputs: vector in inertial
%frame, roll, pitch, and yaw Euler angles

rotMat = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta);
         sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), sin(phi)*cos(theta);
         cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi), cos(phi)*cos(theta)];

 mat = rotMat;
     
end