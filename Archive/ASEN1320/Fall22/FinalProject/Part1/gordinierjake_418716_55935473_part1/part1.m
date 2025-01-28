% clean up
close all; clear all; clc;

% variable declaration
x0 = -2314.87;
y0 = 4663.275;
z0 = 3673.747;
gs = [x0;y0;z0];

xg = gs(1,1);
yg = gs(2,1);
zg = gs(3,1);

tspan = [0 86400];

sat1init = [1986.2;6388.2;-1237.2;-4.93;0.40;-5.83];
sat2init = [6480.8;1108.2;-2145.5;-0.29;7.07;2.75];

% creating a function handle for the OrbitEOM function
f = @OrbitEOM;

% setting the options for the ode integration to improve accuracy
options = odeset('Reltol',1e-12,'AbsTol',1e-12);

% using ode45 to integrate 
[~,Sat1Orbit] = ode45(f,tspan,sat1init,options);
[~,Sat2Orbit] = ode45(f,tspan,sat2init,options);

Sat1Position = Sat1Orbit(:,(1:3));
Sat2Position = Sat2Orbit(:,(1:3));

x1 = Sat1Position(:,1);
y1 = Sat1Position(:,2);
z1 = Sat1Position(:,3);

x2 = Sat2Position(:,1);
y2 = Sat2Position(:,2);
z2 = Sat2Position(:,3);

% writing the sat positions to csv files for c++
writematrix(Sat1Position,'Sat1Position.csv');
writematrix(Sat2Position,'Sat2Position.csv');


% Plotting the positions of the two objects over time
figure('Name','part1.fig')
plot3(x1,y1,z1,x2,y2,z2,xg,yg,zg);
title('Positions of ISS and Hubble in Orbit Relative to a Ground Station');
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
legend('ISS','Hubble');