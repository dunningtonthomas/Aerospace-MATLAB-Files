clear all; clc; close all;

Sat1 = [1986.2 ; 6388.2 ; -1237.2 ; -4.93 ; 0.40 ; -5.83]; %Satelite 1 (ISS) initial Position data
Sat2 = [6480.8 ; 1108.2 ; -2145.5 ; -0.29 ; 7.07 ; 2.75]; %Satelite 2 (hubble) initial Position data

f = @OrbitEOM; %creates a function handle for OrbitEOM as f

tspan = [0 86400]; %defines and declares tspan as from 0 to 86400

options1 = odeset('RelTol',1e-12,'AbsTol',1e-12); %declares options 1 for ode45 with relative and absolute tolerance

[~,Sat1Orbit] = ode45(f,tspan,Sat1,options1); %runs ode45 for the first satelite positioning calling f tspan intial values for satelite 1 and options1 setting it equal to satelite 1 orbit data
[~,Sat2Orbit] = ode45(f,tspan,Sat2,options1); %runs ode45 for the second satelite positioning calling f tspan intial values for satelite 2 and options1 setting it equal to satelite 2 orbit data

Sat1Position = Sat1Orbit(:,(1:3)); %grabs all rows of the first through third columns of Sat1Orbit and stores them in Sat1Position
Sat2Position = Sat2Orbit(:,(1:3)); %grabs all rows of the fitst through thrid columns of Sat2Orbit and stores them in Sat2Position

x1 = Sat1Position(:,1); %find the x values from Sat1Position which takes all rows of the first column 
y1 = Sat1Position(:,2); %find the y values from Sat1Position which takes all rows of the second clumn
z1 = Sat1Position(:,3); %find the z values from Sat1Position which takes all rows of the third column

x2 = Sat2Position(:,1); %find the z values from Sat2Position which takes all rows of the first column
y2 = Sat2Position(:,2); %find the z values from Sat2Position which takes all rows of the second column
z2 = Sat2Position(:,3); %find the z values from Sat2Position which takes all rows of the third column

writematrix(Sat1Position, 'Sat1Position.csv'); %writes a csv file matrix titled Sat1Position writing in the data from Sat1Position
writematrix(Sat2Position, 'Sat2Position.csv'); %writes a csv file matrix titled Sat2Position writing in the data from Sat2Position


figure('Name','part1.fig') %names the figure part1.fig
plot3(x1,y1,z1) %plots x y and z data for Satelite 1
hold on %plots on the same figure
plot3(x2,y2,z2) %plots the x y and z data for Satelite 2

xlabel('X Position') %labels the x axis X Position
ylabel('Y Position') %labels the y axis Y Position
zlabel('Z Position') %lables the z axis Z Position
title('ISS and Hubble Satellite Positioning') %titles the graph ISS and Hubble Satellite Positioning
legend('ISS','Hubble') %Makes a legend which shows ISS in blue, and Hubble in red


