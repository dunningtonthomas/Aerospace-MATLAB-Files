close all; clear; clc;
%Declaring initial states
sat1Init = [1986.2; 6388.2; -1237.2; -4.93; 0.40; -5.83];
sat2Init = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];

%Setting up for ode45
tspan = 0:60:86400;
f = @OrbitEOM;
options = odeset('RelTol',1e-12,'AbsTol',1e-12);

%Calling ode45
[Time1,Sat1] = ode45(f,tspan,sat1Init,options);
[Time2,Sat2] = ode45(f,tspan,sat2Init,options);

%Creating position matrix and dividing into position vectors
Sat1Position = Sat1(:,1:3);
x1 = Sat1Position(:,1);
y1 = Sat1Position(:,2);
z1 = Sat1Position(:,3);
Sat2Position = Sat2(:,1:3);
x2 = Sat2Position(:,1);
y2 = Sat2Position(:,2);
z2 = Sat2Position(:,3);

%Saving position matrices as csv files
writematrix(Sat1Position,'Sat1Position.csv');
writematrix(Sat2Position,'Sat2Position.csv');

%Plotting
figure;
plot3(x1,y1,z1);
hold on;
plot3(x2,y2,z2);
grid on;
title('Orbit models for ISS and Hubble')
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
legend('ISS (Satellite 1)','Hubble (Satellite 2)');
savefig('part1.fig');