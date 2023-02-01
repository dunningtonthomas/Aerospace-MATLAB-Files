%% Clean Up
clear; close all; clc;

%% Problem 1



inertMatrix = 10*f(0.7333,1.2666,0.7333) + 10*f(-1.2666,-0.7333,-1.2666) + 8*f(3.7333,-3.7333,3.7333) + 8*f(-2.2666,2.2666,-2.2666) + 12*f(2.7333,-2.7333,-3.2666) + 12*f(-3.2666,3.2666,2.7333);


%% Problem 4
%Eigenvalues

[eigVals, eigVecs] = eig(inertMatrix);

rotMat = eigVals';

Iprincipal = rotMat * inertMatrix * rotMat';


v1 = [-0.6829, 0.695, 0.2243];
v2 = [0.2167, -0.1005, 0.9711];

v3 = cross(v1, v2);


%% Problem 5

Isphere = [1.8, 0, 0; 0, 1.8, 0; 0, 0, 1.8];
Icube = 4/3 * eye(3,3);

Rcube = [0, 0, -2.75; 0, 0, 0; 2.75, 0, 0];
Rsphere = [0, 0, 2.75; 0, 0, 0; -2.75, 0, 0];

IgCube = Icube + 2*(Rcube)*Rcube';
IgSphere = Isphere + 2*(Rsphere)*Rsphere';

Itot = IgCube + IgSphere;


%b
unitAxis = [0, 1/sqrt(2), 1/sqrt(2)];

IaboutUnit = unitAxis*Itot*unitAxis';

%c
omega = 3.1*[0; 1/sqrt(2); 1/sqrt(2)];
angMomentum = Itot*omega;


%d
Icube = (1/6)*4*4 * eye(3,3);

Rcube = [0, 0, -1.5; 0, 0, 0; 1.5, 0, 0];
Rsphere = [0, 0, 4; 0, 0, 0; -4, 0, 0];

IgCube = Icube + 4*(Rcube)*Rcube';
IgSphere = Isphere + 2*(Rsphere)*Rsphere';

Itot = IgCube + IgSphere;


%% Functions

function outMat = f(r1, r2, r3)
    outMat = [r2^2 + r3^2, -r1*r2, -r1*r3; -r1*r2, r1^2 + r3^2, -r2*r3; -r1*r3, -r2*r3, r1^2 + r2^2];
    
end


