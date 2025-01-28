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



%% Inverse Kinematics
syms x1
syms x2
syms x3

T1 = Tfunc(x1, 0);
T2 = Tfunc(x2, 8);
T3 = Tfunc(x3, 8);
Td = [1,0,9; 0,1,0; 0,0,1];

d = T1*T2*T3*Td*[0;0;1];


theta3 = acos(-65/144);

sintheta3 = sqrt(1 - (65/144)^2);

theta3_2 = asin(-1*sintheta3);

x = -8;
y = 4;
costheta3 = -65/144;
costheta2 = 1 / (x^2 + y^2) * (x*(8 + 9*costheta3) + y*9*sqrt(1-costheta3^2));



cos_term = -65/144;
sin_term = sqrt(1 - cos_term^2);


theta2_1 = acos(costheta2);
theta2_2 = acos(-1*costheta2);



% Try forward kinematics
T1 = Tfunc(0, 0);
T2 = Tfunc(1.563, 8);
T3 = Tfunc(2.0391, 8);
Td = [1,0,9; 0,1,0; 0,0,1];

d = T1*T2*T3*Td*[0;0;1];

% Test 2
T1 = Tfunc(0, 0);
T2 = Tfunc(-2.4903, 8);
T3 = Tfunc(-2.0391, 8);
Td = [1,0,9; 0,1,0; 0,0,1];

d2 = T1*T2*T3*Td*[0;0;1];