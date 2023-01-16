close all; clear all; clc;

%%time span to differentiate and integrate
tspan = [0:60:86400];

%ISS initial position 
Sat1 = [1986.2; 6388.2; -1237.2; -4.93; 0.40; -5.83];

%HUBBLE initial position 
Sat2 = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];

%Ground station initial position 
GS = [-2314.87; 4663.275; 3673.747];

%%function handle
f = @OrbitEOM;

%%ode 45 integration
options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12);

[tsol, Sat1] = ode45(f, tspan, Sat1, options);
[tsol2, Sat2] = ode45(f, tspan, Sat2, options);

%setting up matrices for exporting to .csv files
Sat1Position = Sat1(:, 1:3);
Sat2Position = Sat2(:, 1:3);


%%Write to .csv files
writematrix(Sat1Position, 'Sat1Position.csv');
writematrix(Sat2Position, 'Sat2Position.csv');


%%Plotting sattelite positions
plot3(Sat1(:,1), Sat1(:,2), Sat1(:,3));
hold on
plot3(Sat2(:,1), Sat2(:,2), Sat2(:,3));
grid on 

%title and labeling all three axis
title('Positions of both ISS and Hubble over Time');
xlabel('x Position');
ylabel('y Position');
zlabel('z Position');






