close all; clear all; clc;
%====================Load Sat1 and Sat2 Position Data==
fileName1 = "Sat1Position.csv";
Sat1 = readmatrix(fileName1);

fileName2 = "Sat2Position.csv";
Sat2 = readmatrix(fileName2);
%====================Load Sat1 and Sat Visibility Data=
fileName3 = "Sat1Visibility.csv";
Sat1Vis = readmatrix(fileName3) == 1;

fileName4 = "Sat2Visibility.csv";
Sat2Vis = readmatrix(fileName4) == 1;
% Vector of Sat1Pos if Visibility is True
xPos = Sat1(:,1);   yPos = Sat1(:,2);   zPos = Sat1(:,3);

xPosVis = xPos(Sat1Vis);
yPosVis = yPos(Sat1Vis);
zPosVis = zPos(Sat1Vis);  
% Vector of Sat2Pos if Visibility is True
xPos2 = Sat2(:,1);  yPos2 = Sat2(:,2);  zPos2 = Sat2(:,3);

xPosVis2 = xPos2(Sat2Vis);
yPosVis2 = yPos2(Sat2Vis);
zPosVis2 = zPos2(Sat2Vis);
%====================Plot the data====================
plot3(Sat1(:,1),Sat1(:,2),Sat1(:,3), "-b"); 
hold on
plot3(xPosVis, yPosVis, zPosVis, '>r');
hold on;

plot3(Sat2(:,1),Sat2(:,2),Sat2(:,3), "-r");
hold on;
plot3(xPosVis2, yPosVis2, zPosVis2, 'db');
grid on;

title('Satellite Orbital Position Data');
xlabel('X Coordinate'); ylabel('Y Coordinate'); zlabel('Z Coordinate');
legend("ISS Position","ISS Visibility to GS", "Hubble Position", "Hubble Visibility to GS","Location","northwest");