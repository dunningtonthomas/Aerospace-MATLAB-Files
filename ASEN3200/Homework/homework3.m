%% Clean Up
clear; close all; clc;

%% Problem 1
I0 = [1000, 0, -300; 0, 1000, 500; -300, 500, 1000];

eig(I0);

%Convert the inertia matrix to the principal inertia matrix


%% Problem 2
I = [5, 0, 0; 0, 5, 0; 0, 0, 10];
wtilda = [0, -0.5, 100; 0.5, 0, 0; -100, 0, 0];
w0 = [0; 100; 0.5];
Lc = [600; 0; 0];

IomegaDot = -1*wtilda*I*w0 + Lc;
omegaDot = inv(I) * IomegaDot;


%% Problem 9
Ic = [15, 0, 0; 0, 11, 5; 0, 5, 16];
psi = 30*pi/180;
thet = 10*pi/180;
phi = -12*pi/180;

psiD = -1*pi/180;
thetD = 4*pi/180;
phiD = 0.5*pi/180;

euler2omega = [-sin(thet), 0, 1; 
    sin(phi)*cos(thet), cos(phi), 0; 
    cos(phi)*cos(thet), -sin(phi), 0];

omega = euler2omega*[psiD; thetD; phiD];

Hc = Ic * omega;

Trot = Hc .* omega;
Dp = 0.5* sum(Trot);
