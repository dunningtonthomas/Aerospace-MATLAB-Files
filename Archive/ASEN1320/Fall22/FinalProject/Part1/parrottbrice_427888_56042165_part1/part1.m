close all; clear; clc;

%declare variables
Sat1init=[1986.2;6388.2;-1237.2;-4.93;0.4;-5.83];
Sat2init=[6480.8;1108.2;-2145.5;-0.29;7.07;2.75];
timeVector=[0,86400,60];
% timeVector=[0:60:86400];

%create function handle for OrbitEOM
f=@OrbitEOM;

%create vector to represent timestamp
tspan=linspace(0,86400,60);
tspan = [0:60:86400];

%use odeset to improve accuracy
options=odeset('Reltol',1e-12,'AbsTol',1e-12);

%integrate using ode45
[~,Sat1]=ode45(f,tspan,Sat1init,options);
[~,Sat2]=ode45(f,tspan,Sat2init,options);

%declare position matrices
Sat1Position=Sat1(:,(1:3));
Sat2Position=Sat2(:,(1:3));

%declare position vecots for each component of each satelite
Sat1Positionx=Sat1Position(:,1);
Sat1Positiony=Sat1Position(:,2);
Sat1Positionz=Sat1Position(:,3);

Sat2Positionx=Sat2Position(:,1);
Sat2Positiony=Sat2Position(:,2);
Sat2Positionz=Sat2Position(:,3);

%export data to CSV files
writematrix(Sat1Position, 'Sat1Position.csv');
writematrix(Sat2Position, 'Sat2Position.csv');

%plot position data and detail plot
plot3(Sat1Positionx,Sat2Positiony,Sat2Positionz);
hold on;
plot3(Sat2Positionx,Sat2Positiony,Sat2Positionz);
xlabel('X Position (km)');
ylabel('Y Position(km)');
zlabel('Z Position (km)');
legend('International Space Station (ISS)','Hubble Space Telescope');
title('Spacecraft Orbit Trajectories');









