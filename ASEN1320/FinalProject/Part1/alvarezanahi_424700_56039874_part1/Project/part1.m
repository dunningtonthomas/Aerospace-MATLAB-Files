
close all; clear all; clc

%calling the function
f = @OrbitEOM;

% span of initial and final times
tspan = [0:60:86400];


%initial positions and velocities of both satellites
Sat1 = [1986.2;6388.2;-1237.2;-4.93;0.40;-5.83]; %ISS

Sat2 = [6480.8;1108.2;-2145.5;-0.29;7.07;2.75]; %Hubble


% Setting ode45 options for relative and absolute error tolerance
options = odeset('RelTol',1e-12,'AbsTol',1e-12);


%ode45 functions
[t,Sat1]=ode45(f,tspan,Sat1,options); %ISS

[t2,Sat2]=ode45(f,tspan,Sat2,options); %Hubble


% 2 matricies that store position data set to the first 3 columns
Sat1Position = Sat1(:,1:3);
Sat2Position = Sat2(:,1:3);

%exporting both matricies to csv files
writematrix(Sat1Position,'Sat1Position.csv');
writematrix(Sat2Position,'Sat2Position.csv');

%Plotting
figure('Name','Part1.fig','NumberTitle','off');
title('Orbit of ISS and Hubble Satellites');
xlabel('X Positon');
ylabel('Y Position');
plot3(Sat1(:, 1),Sat1(:,2),Sat1(:,3));
hold on;
plot3(Sat2(:,1),Sat2(:,2),Sat2(:,3));
legend('ISS Satellite','Hubble Satellite');

