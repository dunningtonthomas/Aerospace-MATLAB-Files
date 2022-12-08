% Project Part 3 Rubric Breakdown (25 pts)

% *****************************NOTE**************************************
% The Final Project PDF for Part 3 does not require the GS to be visualized
% on the 3D plot. So while this version shows both satellite orbits and the 
% Ground Station position, the students are not required to do this. 
% ***********************************************************************

%% Part 3 -  Orbit Visualization                                                        % (2 pt) *.fig file format                                                         (0 pt) not *.fig file format
close all; clear all; clc;                                                              % (5 pt) 3D plot showing Sat1 and Sat2 orbits with visibility is visibly correct   (0 pt) Plot is not visibly correct

% Read data from CSV files
Sat1Position = readmatrix('Sat1Position.csv');
Sat2Position = readmatrix('Sat2Position.csv');
GSPosition  = readmatrix('GSPosition.csv');

% Only read visibility when > 0
Sat1Vis     = readmatrix('Sat1Visibility.csv') > 0;
Sat2Vis     = readmatrix('Sat2Visibility.csv') > 0; 

% Create a figure
figure(1)

plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3),'r');                       % (2.5 pt) Sat 1 orbit displayed                                                    (0 pt) Sat 1 orbit is missing
hold on;

plot3(Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3),'b');                       % (2.5 pt) Sat 2 orbit displayed                                                    (0 pt) Sat 2 orbit is missing
hold on;

plot3(GSPosition(:,1),GSPosition(:,2),GSPosition(:,3),'k');                             
hold on;

plot3(Sat1Position(Sat1Vis,1),Sat1Position(Sat1Vis,2),Sat1Position(Sat1Vis,3),'ok');    % (5 pt) Sat1 visibility to GS during orbit                                         (0 pt) Sat1 visibility is missing
hold on;

plot3(Sat2Position(Sat2Vis,1),Sat2Position(Sat2Vis,2),Sat2Position(Sat2Vis,3),'ok');    % (5 pt) Sat2 visibility to GS during orbit                                         (0 pt) Sat 2 visibility is missing
hold on;

plot3(GSPosition(Sat1Vis,1),GSPosition(Sat1Vis,2),GSPosition(Sat1Vis,3),'xr');          
hold on;

plot3(GSPosition(Sat2Vis,1),GSPosition(Sat2Vis,2),GSPosition(Sat2Vis,3),'xb');
hold on;

% Graphics information                 % (1 pt) axes are labeled   (0 pt) axes are not labels
xlabel('X-axis (km)');
ylabel('Y-axis (km)');
zlabel('Z-axis (km)');
title('Orbit');                        % (1 pt) title on plot      (0 pt) no title
legend('Sat 1','Sat 2','GS');          % (1 pt) legend on plot     (0 pt) no legend
grid on;

