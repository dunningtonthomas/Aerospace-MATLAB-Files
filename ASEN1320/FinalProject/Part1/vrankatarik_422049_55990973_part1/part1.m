clear; close all; clc;

tspan = 0:60:86400;      %setting timespan to 86400 seconds in minute increments
stateVector = [1986.2, 6388.2, -1237.2, -4.93, 0.40, -5.83];   %setting statevectors as position and velocity states of the two satellites
stateVector1 = [6480.8, 1108.2, -2145.5, -0.29, 7.07, 2.75];

f = @OrbitEOM;   %function handle for OrbitEOM

options = odeset('AbsTol',1e-12 ,'RelTol', 1e-12);            %setting relative and absolute tolerance of ode45 to specified value
[t,s] = ode45(f,tspan,stateVector,options);             %calling ode45 function with OrbitEOM twice for each satellite
[t1,s1] = ode45(f,tspan,stateVector1,options); 

Sat1Position1 = s(:,1);          %building the sat1 and sat2 position vectors
Sat1Position2 = s(:,2);
Sat1Position3 = s(:,3);

Sat2Position1 = s1(:,1);
Sat2Position2 = s1(:,2);
Sat2Position3 = s1(:,3);

Sat1Position = [Sat1Position1 Sat1Position2 Sat1Position3];
Sat2Position = [Sat2Position1 Sat2Position3 Sat2Position3];

writematrix(Sat1Position, "Sat1Position.csv");      %making csv files
writematrix(Sat2Position, "Sat2Position.csv");

plot3(Sat1Position1, Sat1Position2, Sat1Position3)   %creating 3d plot using components of both sat position arrays
hold on
plot3(Sat2Position1, Sat2Position2, Sat2Position3)   
legend("ISS", "Hubble")
xlabel("x")
ylabel("y")
zlabel("z")
title("Orbits of Hubble Space Telescope and ISS Visualized")
hold off

