clear all; close all; clc;

sat1init = [1986.2; 6388.2; -1237.2; -4.93; 0.40; -5.83];
sat2init = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];

tspan = 1:(60 * 60 * 24);

settings = odeset('RelTol', 10^-12, 'AbsTol', 10^-12);
[tspan, sat1] = ode45(@(t, s) OrbitEOM(t, s), tspan, sat1init, settings);
[tspan, sat2] = ode45(@(t, s) OrbitEOM(t, s), tspan, sat2init, settings);

Sat1Position(:,1) = sat1(:,1);
Sat1Position(:,2) = sat1(:,2);
Sat1Position(:,3) = sat1(:,3);

Sat2Position(:,1) = sat2(:,1);
Sat2Position(:,2) = sat2(:,2);
Sat2Position(:,3) = sat2(:,3);

writematrix(Sat1Position, 'Sat1Position.csv');
writematrix(Sat2Position, 'Sat2Position.csv');

hold on;
plot3(Sat1Position(:,1), Sat1Position(:,2), Sat1Position(:,3));
plot3(Sat2Position(:,1), Sat2Position(:,2), Sat2Position(:,3));

xlabel('x');
ylabel('y');
zlabel('z');

title('Orbits of ISS & Hubble');

legend('ISS', 'Hubble');