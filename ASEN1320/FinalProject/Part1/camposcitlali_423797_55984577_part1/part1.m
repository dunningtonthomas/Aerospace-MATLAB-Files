close all; clear all; clc; 

%satallite 1(ISS) initals
Sat1 = [1986.2, 6388.2, -1237.2,-4.93, 0.40, -5.83];

%satallite 2(Hubble Tele) initials 
Sat2 = [6480.8, 1108.2, -2145.5, -0.29, 7.07, 2.75];

%given values 
tspan = [0:60:86400];

%function handdles 
f =@OrbitEOM;

%odeset 
options = odeset('RelTol',1e-12,'AbsTol',1e-12);

%ode45
[t,Sat1] = ode45(f,tspan,Sat1,options);
[t2,Sat2] = ode45(f,tspan,Sat2,options);

%turning Sat1Position & Sat2Position into csv files 
writematrix(Sat1(:,1:3),'Sat1Position.csv')
writematrix(Sat2(:,1:3),' Sat2Position.csv')

%plotting x,y,and z
plot3(Sat1(:,1),Sat1(:,2),Sat1(:,3))
hold on
plot3(Sat2(:,1),Sat2(:,2),Sat2(:,3))

%Linespecs
xlabel('x position')
ylabel('y position')
zlabel('z position')
legend('ISS', 'Hubble Tele')
title('Orbit for ISS & Hubble')








