%% Clean Up
clear; close all; clc;


%% Problem 2
%Aircraft parameters
b = 59.6433;
c = 8.3241;
omega = 0.0523598;
u0 = 67.3608;
phi = 0.34514;

CyBeta = -0.8771;
CyRudder = 0.1146;
ClBeta = -0.2797;
ClRudder = 6.976 * 10^-3;
ClAileron = -1.368*10^-2;
CnBeta = 0.1946;
CnRudder = -0.1257;
CnAileron = -1.973 * 10^-4;

mat1 = [CyBeta, CyRudder, 0; ClBeta, ClRudder, ClAileron; CnBeta, CnRudder, CnAileron];


CyP = 0;
CyR = 0;
ClP = -0.3295;
ClR = 0.304;
CnP = -0.04073;
CnR = -0.2737;

mat2 = [CyP, CyR; ClP, ClR; CnP, CnR];



CmAlpha = -1.023;
CmElevator = -1.444;
ClAlpha = 4.92; %negative of Cz
ClElevator = 0.3648; %negative of Cz

mat3 = [CmAlpha, CmElevator; ClAlpha, ClElevator];


Cmq = -23.92;
Clq = 5.921;

mat4 = [Cmq; Clq];

%Matrix equations
rhs1 = mat2*[0;-cos(phi)]*(omega*b/(2*u0));

n = 1 / cos(phi);
Cw = 1.75074;
rhs2 = -mat4*((omega*c*sin(phi))/(2*u0)) + [0; (n-1)*Cw];

%Solving for the values
solMat1 = mat1 \ rhs1;

solMat2 = mat3 \ rhs2;


%Converting to degrees
solMat1 * (180/pi)
solMat2 * (180/pi)





