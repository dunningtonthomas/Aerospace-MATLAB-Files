%%Housekeeping 
close all; clear all; clc; 

%Initial Conditions for Satellite 1
xs1 = 1986.2; 
ys1 = 6388.2; 
zs1 = -1237.1; 
vxs1 = -4.93;
vys1 = 0.40;
vzs1 = -5.83;

%Initial Conditions for Satellite 2
xs2 = 6480.8; 
ys2 = 1108.2; 
zs2 = -2145.5; 
vxs2 = -0.29;
vys2 = 7.07;
vzs2 = 2.75;

%Initial Conditions for Goldstone Observatory 
x0 = -2314.87; 
y0 = 4663.275; 
z0 = 3673.747; 

%Vector Initialization for the Initial Conditions 
Sat1Initial = [xs1; ys1; zs1; vxs1; vys1; vzs1]; 
Sat2Initial = [xs2; ys2; zs2; vxs2; vys2; vzs2]; 
GSInitial = [x0; y0; z0]; 

%Creation of tspan with a vector starting at 0 going to 86400 with 1440
%evenly spaced values. 
tspan = linspace(0, 86400, 1440);

% %Function handle for OrbitEOM function 
% f = @OrbitEOM;
% 
% %Setting the relative and absolute tolerance using odeset
% options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12);
% 
% %Using ode45 to compute the spacecraft position and velocity along orbit
% [tsat1, sat1pos] = ode45(f, tspan, Sat1Initial, options);
% [tsat2, sat2pos] = ode45(f, tspan, Sat2Initial, options);
sat1pos = readmatrix('Sat1Position.csv');
sat2pos = readmatrix('Sat2Position.csv');
%Creation of 2D matrices
% writematrix(sat1pos, 'Sat1Position.csv'); 
% writematrix(sat2pos, 'Sat2Position.csv'); 

%Graph specifications for plot3
LineSpec1 = 'r';
LineSpec2 = 'b'; 

%Plotting the positions of the ISS and Hubble to visualize their 3D orbit
plot3(sat1pos(:,1),sat1pos(:,2), sat1pos(:,3), LineSpec1); 
hold on; 
plot3(sat2pos(:,1),sat2pos(:,2), sat2pos(:,3), LineSpec2); 

% %Graph specifications for plot3
title 'Hubble and ISS Satellite Path Visualization';
xlabel 'X Position';
ylabel 'Y Posision';
zlabel 'Z Position'; 
legend ('Hubble Orbit', 'ISS Orbit');

visability1 = readmatrix("Sat1Visibility.csv"); 
visability2 = readmatrix("Sat2Visibility.csv"); 

A = find(visability1);
B = find(visability2);
Linespec3 = 'g*';
Linespec4 = 'k*';

for i = 1:length(A)
    plot3(sat1pos(A(i),1), sat1pos(A(i),2), sat1pos(A(i),3), Linespec3);
end

hold on

for i = 1:length(B)
    plot3(sat2pos(B(i),1), sat2pos(B(i),2), sat2pos(B(i),3), Linespec4);
end




