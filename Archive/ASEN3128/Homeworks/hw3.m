%% Clean Up
clear; close all; clc;

%% Problem 1
%Parrot Mimbo parameters
mass = 0.068;
g = 9.81;
nu = 1e-3;
mu = 2e-6;
d = 0.06; %Radial distance to motors (m)
km = 0.0024; %Control moment coefficient (N*m/N)

%Initial state vector
X = [100; 100; -1600; 0.17; 0.17; 2.4; 1; -1; 0; 0; 0; 0];

%Total Force Vector
fTot = mass*[-1.68;1.65;-0.3];

%Gravity Force Vector
gravE = [0;0;mass*g];
gravB = rotateEB(gravE,X(4), X(5), X(6)); 

%Aerodynamic Force vector
Va = X(7:9);
dragB = -nu*norm(Va)*Va;

%Finding the control force
fCont = fTot - gravB - dragB;



%Moment Analysis
Ib = [6.8e-5, 0, 0; 0, 9.2e-5, 0; 0, 0, 1.35e-4]; %Moment of inertia matrix
wbDot = [-20.79; -15.37; 0]; %Rate of change of the angular rates

totalMoments = Ib*wbDot;

%Aerodynamic Moments
wb = X(10:12);
aeroMoment = -mu*norm(wb)*wb;

%Finding the control moments
mCont = totalMoments - aeroMoment;



%Finding the forces for each motor
finalForces = motorForces([fCont(3); mCont],d, km);


%Adding in wind
windE = [2;1.5;-2];
windB = rotateEB(windE,X(4), X(5), X(6));

airRelVel = [1;-1;0] - windB;

newDrag = -nu*norm(airRelVel)*airRelVel;

%Finding the new total force
forceTotal = newDrag + gravB + fCont;

%Acceleration
accelFinal = forceTotal / mass;

%% Problem 4
Ix = 5.8e-5;
Iy = 7.2e-5;
Iz = 1e-4;
k1 = 0.01;
k2 = 0.05;
k3 = 0.01;
k4 = 1;

A = [0, 1, 0, 0; 0, 0, 9.81, 0; 0, 0, 0, 1; -k3*k4/Ix, -k3/Ix, -k2/Ix, -k1/Ix];

eigenValues = eig(A);
damp(A)

imaginaryPart = imag(eigenValues(3));
realPart = real(eigenValues(3));

naturalFreq = sqrt(realPart^2 + imaginaryPart^2);

dampingRatio = realPart/ naturalFreq;


k1 = 1.6e-4;
k2 = 4e-4;
k3 = 0;
k4 = 0;

Iy = 1e-4;


Amatrix = [0,1,0,0;0,0,-9.81,0; 0,0,0,1; -k3*k4/Iy, -k3/Iy, -k2/Iy, -k1/Iy];
Amatrix2 = [0,1;-k2/Iy, -k1/Iy];

[eigenValues2, eigenVectors] = eig(Amatrix2);
damp(Amatrix2)








