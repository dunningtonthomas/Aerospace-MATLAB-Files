%% Clean
close all; clear; clc;

%% 
theta1 = pi/4;
theta2 = pi/2;
theta3 = -pi/6;
origin = [0;0;1];
a = 8;

Tfunc = @(theta, trans) ([cos(theta), -sin(theta), trans; sin(theta), cos(theta), 0; 0, 0, 1]);

T1 = Tfunc(theta1, 0);
T2 = Tfunc(theta2, 8);
T3 = Tfunc(theta3, 8);
Ta = Tfunc(0, 4);
Tb = Tfunc(0, 9);
Tc = Tfunc(0, 9);
Tc(2,3) = 1;
Td = Tfunc(0, 9);

a = T1*Ta*origin;
b = T1*T2*Tb*origin;
c = T1*T2*T3*Tc*origin;
d = T1*T2*T3*Td*origin;

