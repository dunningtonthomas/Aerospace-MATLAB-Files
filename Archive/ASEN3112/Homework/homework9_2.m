%% Clean Up
clear; close all; clc;


%% Problem 4
%Natural Frequencies
w1 = sqrt(15 - (1/2)*(sqrt(500)));
w2 = sqrt(15 + (1/2)*(sqrt(500)));

%Mass and K
M = [10, 0; 0, 10];
K = [200, -100; -100, 100];


%Solving for the eigenvectors
matEig1 = -w1^2 * M + K;
matEig2 = -w2^2 * M + K;

%Adding the bar 3
angle3 = -45*pi/180;
K3 = elementStiff(1000,1,sqrt(2)*10,angle3);

k1Tot = [100, 0, -100, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    -100, 0, 100, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0];

k2Tot = [0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 100, 0, -100, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, -100, 0, 100, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0];

val3 = K3(1);
k3Tot = [0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, val3, -val3, 0, 0, -val3, val3;
    0, 0, -val3, val3, 0, 0, val3, -val3;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, -val3, val3, 0, 0, val3, -val3;
    0, 0, val3, -val3, 0, 0, -val3, val3];

Ktot = k3Tot + k2Tot + k1Tot;


%Simple k matty boi
ksimp = [Ktot(3,3), -100; -100, 100];


%Finding eigenvectors of the second part
w1_2 = (33.54-sqrt(33.54^2 - 4*135.36))/2;
w2_2 = (33.54+sqrt(33.54^2 - 4*135.36))/2;

K = [235.4, -100; -100, 100];

mattyBoi1 = -w1_2*M + K;
mattyBoi2 = -w2_2*M + K;


%% Functions
function Ke = elementStiff(E, A, L, angle)

    rotMat = [cos(angle)^2, sin(angle)*cos(angle), -1*cos(angle)^2, -sin(angle)*cos(angle);
        sin(angle)*cos(angle), sin(angle)^2, -sin(angle)*cos(angle), -1*sin(angle)^2;
        -1*cos(angle)^2, -sin(angle)*cos(angle), cos(angle)^2, sin(angle)*cos(angle);
        -1*sin(angle)*cos(angle), -1*sin(angle)^2, sin(angle)*cos(angle), sin(angle)^2];
    
    Ke = (E*A/L) * rotMat;

end
