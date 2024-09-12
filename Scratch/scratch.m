%%
close all; clear; clc;

F = [0;0;-450];

theta = 50*pi/180;
phi = 60*pi/180;
Rx = [1,0,0; 0,cos(theta),-sin(theta); 0, sin(theta), cos(theta)];
Ry = [cos(phi), 0, sin(phi); 0, 1, 0; -sin(phi), 0, cos(phi)];

F_final = Ry*Rx*F;

x_comp = 450*cos(theta);
y_comp = 450*cos(phi);
z_comp = sqrt(450^2-x_comp^2-y_comp^2);

F_final = [x_comp; y_comp; z_comp];