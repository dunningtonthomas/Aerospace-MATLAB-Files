%% Clean Up
clear; close all; clc;

%% Problem 2

%Setting up rotation matrices
psi = pi / 2;
rotZaxis = [cos(psi), sin(psi), 0; -sin(psi), cos(psi), 0; 0, 0, 1];

theta = pi / 2;
rotYaxis = [cos(theta), 0, -sin(theta); 0, 1, 0; sin(theta), 0, cos(theta)];

phi = pi / 2;
rotXaxis = [1, 0, 0; 0, cos(phi), sin(phi); 0, -sin(phi), cos(phi)];

%Hypothetical maneuver
aircraft1 = [1; 1; 1];

aircraft2 = [1; 1; 1];


aircraft1Final = rotZaxis*(rotXaxis*(rotYaxis*aircraft1));

psi = -pi / 2;
rotZaxis = [cos(psi), sin(psi), 0; -sin(psi), cos(psi), 0; 0, 0, 1];

theta = -pi / 2;
rotYaxis = [cos(theta), 0, -sin(theta); 0, 1, 0; sin(theta), 0, cos(theta)];

phi = -pi / 2;
rotXaxis = [1, 0, 0; 0, cos(phi), sin(phi); 0, -sin(phi), cos(phi)];


aircraft2Final = rotYaxis*(rotZaxis*(rotXaxis*aircraft2));




%Testing syms
syms phi;
syms theta;
syms psi;

phi = pi / 2;
theta = pi / 2;
psi = pi / 2;

test = phi + theta + psi;

rotZaxis = [cos(psi), sin(psi), 0; -sin(psi), cos(psi), 0; 0, 0, 1];
rotYaxis = [cos(theta), 0, -sin(theta); 0, 1, 0; sin(theta), 0, cos(theta)];
rotXaxis = [1, 0, 0; 0, cos(phi), sin(phi); 0, -sin(phi), cos(phi)];

rot1 = rotYaxis * rotXaxis * rotZaxis;
rot2 = rotXaxis * rotZaxis * rotYaxis;


%% Problem 3
phi = -30 * pi/180;
theta = 0 * pi/180; 
psi = 123 * pi/180;

RotEB = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta); sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), sin(phi)*cos(theta); cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi), cos(phi)*cos(theta)];
trans = RotEB';
inv = RotEB^-1;

velBody = [25; 0; -4];

velInert = trans*velBody;




