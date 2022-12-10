clear all; close all; clc; %cleans up the workspace


Sat1P = readmatrix("Sat1Position.csv"); %reads in the data from Sat1Position.csv and sets it equal to Sat1P
Sat2P = readmatrix("Sat2Position.csv"); %reads in the data frm Sat2Position.csv and sets it equal to Sat2P
Sat1V = readmatrix("Sat1Visibility.csv"); %reads in the data from Sat1Visibility.csv and sets it equal to Sat1V
Sat2V = readmatrix("Sat2Visibility.csv"); %reads in the data from Sat2Visibility.csv and sets it equal to Sat2V


x1P  = Sat1P(:,1); %Sets x1P equal to the first column of data from sat1P
y1P  = Sat1P(:,2); %sets y1P equal to the second column of data from sat1P
z1P  = Sat1P(:,3); %sets z1P equal to the thrid column of data from sat1P

x2P  = Sat2P(:,1); %sets x2P equal to the first column of data from Sat2P
y2P  = Sat2P(:,2); %sets y2P equal to the second column of data from Sat2P
z2P  = Sat2P(:,3); %sets z2P equal to the thrid column of data from Sat2P


plot3(x1P,y1P,z1P) %plots a 3D plot for the values from Sat1
hold on; %plots on the same graph
plot3(x2P,y2P,z2P) %plots a 3D plot for the values from Sat2

Visibility1 = 'm*'; %makes the points for Visibility1 and makes them red asterisks
Visibility2 = 'm*'; %makes the points for Visibility2 and makes them magenta asterisks


for i = 1:1441 %begins a for loop for i from 1 to 1441
    if (Sat1V(i) == 1) %starts an if statment to check if the value from Sat1V is equal to 1
        plot3(x1P(i),y1P(i),z1P(i), Visibility1) %if the condition is true then it plots the 3D points for the visibility function
    end %ends the if statment

    if (Sat2V(i) == 1) %begins another if statment ot check if the value from Sat2V is equal to 1
        plot3(x2P(i),y2P(i),z2P(i), Visibility2) %plots a 3D plot of the values for Visibility2 if the condtion above is true
    end %ends the if statement
end %ends the for loop

xlabel('X Position') %labels the x axis X Position
ylabel('Y Position') %labels the y axis Y Position
zlabel('Z Position') %lables the z axis Z Position
title('ISS and Hubble Satellite Positioning and Ground Station Visibility') %titles the graph ISS and Hubble Satellite Positioning
legend('ISS Orbit','Hubble Orbit','Visibility') %Makes a legend which shows ISS in blue, Hubble in red, and the Visibilitys set to asterisks
grid on %turns the grid of the plot on



