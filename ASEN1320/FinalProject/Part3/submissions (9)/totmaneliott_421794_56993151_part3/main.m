%Housekeeping
close all; clear; clc;

%Read In Data from Files
Sat1Position = readmatrix("Sat1Position.csv");
Sat2Position = readmatrix("Sat2Position.csv");
Sat1Visibility = readmatrix("Sat1Visibility.csv");
Sat2Visibility = readmatrix("Sat2Visibility.csv");

%Plot all data from Position and Visibility Graphs
plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3),Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3),Sat1Visibility(:,1),Sat1Visibility(:,2),Sat1Visibility(:,3),"g*",Sat2Visibility(:,1),Sat2Visibility(:,2),Sat2Visibility(:,3),"y*");
xlabel("X Position (km)");
ylabel("Y Position (km)");
zlabel("Z Position (km)");
legend("Satellite 1 Position","Satellite 2 Position","Satellite 1 Visibility","Satellite 2 Visibility");
title("Plotted orbits of Satellites 1 and 2");
savefig("Part3.fig");