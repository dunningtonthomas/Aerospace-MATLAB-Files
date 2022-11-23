clear; close all; clc;


sat1init = [1986.2; 6388.2; -1237.2; -4.93; 0.4; -5.83];
sat2init = [6840.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];

tspan = [1, 86400];

f = @OrbitEOM;

options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t1, sat1] = ode45(f, tspan, sat1init,options);
[t2, sat2] = ode45(f, tspan, sat2init,options);

sat1Position = [sat1(:, 1), sat1(:,2), sat1(:, 3)]; %iss position
sat2Position = [sat2(:, 1), sat2(:,2), sat2(:, 3)]; %hubble position

writematrix(sat1Position, "Sat1Position.csv");
writematrix(sat2Position, "Sat2Position.csv");

fig = plot3(sat1Position(:,1), sat1Position(:,2), sat1Position(:,3));
hold on
fig = plot3(sat2Position(:,1), sat2Position(:,2), sat2Position(:,3));

xlabel("x")
ylabel("y")
zlabel("z")
title("ISS and Hubble position")
legend("ISS", "Hubble")
saveas(fig, "part1.fig")