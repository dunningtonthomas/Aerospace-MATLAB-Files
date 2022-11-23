close all; clear all; clc;

s1 = [1986.2; 6388.2; -1237.2; -4.93; 0.4; -5.83];      %Initializing state vectors
s2 = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];
t = 0;
EOM1 = @(t,s1)OrbitEOM(t,s1);                           %Creating function handles
EOM2 = @(t,s2)OrbitEOM(t,s2);

tspan = linspace(0, 86400, 1440);                       %Initializing tspan 

options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12);     %Setting tolorences

[Tout1, Yout1] = ode45(EOM1, tspan, s1, options);       %Using ode45
[Tout2, Yout2] = ode45(EOM2, tspan, s2, options);

Sat1Position = zeros(1440,3);                           %Initializing position matracies 
Sat2Position = zeros(1440,3);

Sat1Position(:,1) = Yout1(:,1);                         %Assigning values
Sat1Position(:,2) = Yout1(:,2);
Sat1Position(:,3) = Yout1(:,3);

Sat2Position(:,1) = Yout2(:,1);
Sat2Position(:,2) = Yout2(:,2);
Sat2Position(:,3) = Yout2(:,3);

writematrix(Sat1Position, 'Sat1Position.csv');          %Writing matricies to files
writematrix(Sat2Position, 'Sat2Position.csv');

plot3(Yout1(:,1),Yout1(:,2),Yout1(:,3), Yout2(:,1),Yout2(:,2), Yout2(:,3), 'LineWidth', 1.5);       %PLotting 3d graph and exporting to figure
title('Orbit of the ISS and the Hubble Space Telescope')
ylabel('Y (km)')
xlabel('X (km)')
zlabel('Z (km)')
legend('Orbit of ISS', 'Orbit of Hubble Space Telescope')
saveas(gcf,'part1',"fig")