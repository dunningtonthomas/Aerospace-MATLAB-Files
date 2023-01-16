%% Clean Up
close all; clear; clc;


%% Problem 4
theta = 0;
phi = 0.25;
psi = -1.9;

RotEB = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta);
    sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), sin(phi)*cos(theta);
    cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi), cos(phi)*cos(theta)];

windInert = [8;0;0];

windBody = RotEB*windInert;

realVel = [24.59; -4.34; 6.87];
testVel = [6.1;-1.1;1.7];

realNorm = realVel / norm(realVel);
testNorm = testVel / norm(testVel);

testAngles = [cos(theta)*cos(phi); sin(theta); cos(theta)*sin(phi)];


