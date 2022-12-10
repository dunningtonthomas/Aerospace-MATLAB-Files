%% clean up
close all; clear all; clc;

%% opening all of the csv files
filename = "Sat1Position.csv";
matrixdata = readmatrix(filename);

filename2 = "Sat2Position.csv";
matrixdata2 = readmatrix(filename2);

Sat1Visibility = load('Sat1Visibility.csv');

Sat2Visibility = load('Sat2Visibility.csv');

%% Setting Variables
x1 = matrixdata(:,1);
y1 = matrixdata(:,2);
z1 = matrixdata(:,3);

x2 = matrixdata2(:,1);
y2 = matrixdata2(:,2);
z2 = matrixdata2(:,3);

%% Creating logical vectors for the visibility data
LogicalVector1 = Sat1Visibility == 1;
LogicalVector2 = Sat2Visibility == 1;

%% Using the logical vectors 
Sat1Visibilityx = x1(LogicalVector1);
Sat1Visibilityy = y1(LogicalVector1);
Sat1Visibilityz = z1(LogicalVector1);

Sat2Visibilityx = x2(LogicalVector2);
Sat2Visibilityy = y2(LogicalVector2);
Sat2Visibilityz = z2(LogicalVector2);


%% plotting the orbits and visibility of the spacecraft

Linspec1 = 'k*';
Linspec2 = 'b*';

figure('Name','part3.fig');
plot3(x1,y1,z1,x2,y2,z2,Sat1Visibilityx,Sat1Visibilityy,Sat1Visibilityz,Linspec1,Sat2Visibilityx,Sat2Visibilityy,Sat2Visibilityz, Linspec2);

title('Visibility of Spacecraft Throughout Their Orbits');
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
legend('ISS Orbit','Hubble Orbit','ISS Visibility','Hubble Visibility');
