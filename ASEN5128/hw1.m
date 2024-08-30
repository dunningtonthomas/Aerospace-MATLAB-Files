%% Clean up
close all; clear; clc;

%% Problem 1 test
vb = [15;0;2];
euler_angles = [-3;10;123] .* pi/180;
wb = [1;1;-1];

wind_angles = AirRelativeVelocityVectorToWindAngles(vb);
aoa = wind_angles(3) * 180/pi;
R = RotationMatrix321(euler_angles);

ve = TransformFromBodyToInertial(vb + wb, euler_angles);
vg = norm(ve);