%clearing the command window each time I run it
close all;clear all;clc

%declaring the time span t, the function handel f, the initial velocity and position of satellite one and 2, and the position of the ground station 
t = [0,86400];
f = @OrbitEOM;
Sat1 = [1986.2; 6388.3 ; -1237.2; -4.93; -0.40; -5.83];
Sat2 = [6480.8; 1108.2; -2145.5; -0.29;7.07;2.75];


%creating a relative error tolerance along with the ode functions for the
%new positions of Sat1 and Sat2
Tolerance = odeset('RelTol',1e-12,'AbsTol',1e-12);
[~,Sat1Pos] = ode45(f,t,Sat1,Tolerance);
[~,Sat2Pos] = ode45(f,t,Sat2,Tolerance);


%exporting a csv matrix of the position for satellite 1 and 2
writematrix(Sat1Pos, 'Sat1Position.csv');
writematrix(Sat2Pos, 'Sat2Position.csv');


%nameing the figure of our graph
figure('Name', 'part1.fig')

%plotting the first sattelite position
plot3( Sat1Pos(:,1), Sat1Pos(:,2), Sat1Pos(:,3));

%allowing there to be two functions on one graph
hold on;

%plotting the second sattelite position (Hubble)
plot3(Sat2Pos(:,1),Sat2Pos(:,2),Sat2Pos(:,3));


%ending the hold function
hold off;

%creating the title, key, x label, y label, and z label for the graph
title('Position of ISS and Hubble Relative to the Ground Station')
xlabel ('X Position')
ylabel('Y Position')
zlabel('Z position')
legend ('ISS', 'Hubble')







