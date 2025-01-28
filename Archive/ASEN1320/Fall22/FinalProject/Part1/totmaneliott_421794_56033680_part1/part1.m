%Housekeeping
close all;clear;clc;

%Function Handle
EOMFunc = @OrbitEOM;

%Constants column vectors set. GSInit was not used.
Sat1Init = [1986.2;6388.2;-1237.2;-4.93;0.4;-5.83];
Sat2Init = [6480.8;1108.2;-2145.5;-0.29;7.07;2.75];
GSInit = [-2314.87 4663.275 3673.747];

%Options customization for ode45 sets relative and absolute tolerance
OPTIONS = odeset('RelTol',1e-10,'AbsTol',1e-12);

%TSpan equivalent
TimeVector = 0:60:86400;

%ODE45 Functions called for each satellite
[Time1,Sat1Data] = ode45(EOMFunc,TimeVector,Sat1Init,OPTIONS);
[Time2,Sat2Data] = ode45(EOMFunc,TimeVector,Sat2Init,OPTIONS);

%Satellite Positions logged into matrices to turn into .csv files later
Sat1Position = Sat1Data(:,1:3);
Sat2Position = Sat2Data(:,1:3);

%CSV Files written from data in Sat1Position and Sat2Position
writematrix(Sat1Position,"Sat1Position.csv");
writematrix(Sat2Position,"Sat2Position.csv");

%3D Plot made with labels and legend, figure saved in .fig file
plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3),Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3));
xlabel("X Position (km)");
ylabel("Y Position (km)");
zlabel("Z Position (km)");
legend("Satellite 1 Position","Satellite 2 Position");
title("Plotted orbits of Satellites 1 and 2");
savefig('part1.fig');