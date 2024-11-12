%%
close all; clear; clc;


%% 

vee = [14; 15; -1];
euler_angles = [2; 10; 45] .* pi/180;
wind_angles = [23; 8*pi/180; 2*pi/180];

R1 = [1,0,0; 0, cos(euler_angles(1)), sin(euler_angles(1)); 0, -sin(euler_angles(1)), cos(euler_angles(1))];
R2 = [cos(euler_angles(2)), 0, -sin(euler_angles(2)); 0, 1, 0; sin(euler_angles(2)), 0, cos(euler_angles(2))];
R3 = [cos(euler_angles(3)), sin(euler_angles(3)), 0; -sin(euler_angles(3)), cos(euler_angles(3)), 0; 0, 0, 1];

vbe = (R1*R2*R3)*vee;
vbe_check = TransformFromInertialToBody(vee, euler_angles);

V = WindAnglesToAirRelativeVelocityVector(wind_angles);

Wbe = vbe - V
% 
% vector_body = [20; 2; 3];
% vector_inertial = TransformFromBodyToInertial(vector_body, euler_angles)