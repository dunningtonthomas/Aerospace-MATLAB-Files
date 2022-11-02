%% CLean Up
clear; close all; clc;


%% Problem 1
L = 30;
L2 = sqrt(30^2 + (30^2)/3);
E = 3000;
A2 = 4;
angle2 = 30 * pi/180;
Ke2 = elementStiff(E, A2, L2, angle2);


%Bar 3
L3 = (L/sqrt(3))/sin(60*pi/180);
A3 = 3;
angle3 = -60*pi/180;

Ke3 = elementStiff(E, A3, L3, angle3);

%Solve for displacements
mat = [573, -45; -45, 425];
forces = [0;-100];

disp = mat \ forces;



%Next parttttt
mattyBoi = [200, 0, 0, 0, 0, 0, -200, 0;
    0, 0, 0, 0, 0, 0, 0 , 0;
    0, 0, 260, 150, 0, 0, -260, -150;
    0, 0, 150, 87, 0, 0, -150, -87;
    0, 0, 0, 0, 113, -195, -113, 195;
    0, 0, 0, 0, -195, 338, 195, -338;
    -200, 0, -260, -150, -113, 195, 573, -45;
    0, 0, -150, -87, 195, -338, -45, 425];

dispVec = [0;0;0;0;0;0;-0.0186;-0.2373];
globDisp = dispVec;

forcessssss = mattyBoi * dispVec;


%Internal forces
A1 = 2;
angle1 = 0;
globDisp1 = [0;0;-0.0186;-0.2373];
globDisp2 = [0;0;-0.0186;-0.2373];
globDisp3 = [0;0;-0.0186;-0.2373];

intBar1 = barChangeLength(E, A1, L, angle1, globDisp1);
intBar2 = barChangeLength(E, A2, L2, angle2, globDisp2);
intBar3 = barChangeLength(E, A3, L3, angle3, globDisp3);


%% Functions


function Ke = elementStiff(E, A, L, angle)

    rotMat = [cos(angle)^2, sin(angle)*cos(angle), -1*cos(angle)^2, -sin(angle)*cos(angle);
        sin(angle)*cos(angle), sin(angle)^2, -sin(angle)*cos(angle), -1*sin(angle)^2;
        -1*cos(angle)^2, -sin(angle)*cos(angle), cos(angle)^2, sin(angle)*cos(angle);
        -1*sin(angle)*cos(angle), -1*sin(angle)^2, sin(angle)*cos(angle), sin(angle)^2];
    
    Ke = (E*A/L) * rotMat;

end



function internalForce = barChangeLength(E, A, L, angle, globDisp)

    rotMat = [cos(angle), sin(angle), 0, 0;
        -sin(angle), cos(angle), 0, 0;
        0, 0, cos(angle), sin(angle);
        0, 0, -sin(angle), cos(angle)];
    
    localDisp = rotMat*globDisp;
    
    changeLength = localDisp(3) - localDisp(1);
    
    internalForce = (E*A/L) * changeLength;
end



