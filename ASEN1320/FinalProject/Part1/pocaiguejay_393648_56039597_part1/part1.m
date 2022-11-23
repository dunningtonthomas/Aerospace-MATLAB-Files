close all; clear all; clc;

%==========================Initial Conditions==============================
ISS = [1985.2; 6388.2; -1237.2; -4.93; 0.40; -5.83];
Hubble = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];

tspan = [0 86400];              % Time Vector For 1 Day in Seconds
f = @OrbitEOM;                  % Orbit EOM Function Handle

%==========================Computation=====================================
options = odeset('RelTol',1e-12 , 'AbsTol',1e-12);
[TSOL1,Sat1] = ode45(f, tspan, ISS, options);
[TSOL2,Sat2] = ode45(f, tspan, Hubble, options);

%==========================Satellite Arrays================================
Sat1Position = [Sat1(:,1:3)];
Sat2Position = [Sat2(:,1:3)];

%==========================Exporting Satellites to CSV Files===============
writematrix(Sat1Position, 'Sat1Position.csv');
writematrix(Sat2Position,'Sat2Position.csv');

%==========================3 Dimensional Plotting==========================
plot3(Sat1(:,1), Sat1(:,2), Sat1(:,3)); % International Space Station
hold on;
plot3(Sat2(:,1), Sat2(:,2), Sat2(:,3)); % Hubble Telescope

title('Satellite Orbital Position Data');
xlabel('X'); ylabel('Y'); zlabel('Z');
legend('International Space Station','Hubble Telescope','Location','northwest');

