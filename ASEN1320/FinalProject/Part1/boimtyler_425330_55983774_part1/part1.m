clc;
clear;
close all;

% Declares Initial conditions
Sat1init = [1986.2; 6388.2; -1237.2; -4.93; 0.4; -5.83];
Sat2init = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75;];
GS = [-2314.87; 4663.275; 3673.747];

%Sat1 = [Xs1; Ys1; Zs1; VXs1; VYs1; VZs1];
%Sat2 = [Xs2; Ys2; Zs2; VXs2; VYs2; VZs2];

% Sets up inputs for function handle
t = [0,86400];
s = [Sat1init Sat2init];

% Function Handle for Equations of Motion
f = @(t,s)OrbitEOM(t,s);

% Sets up ODE45 Function for both Sat1 and Sat2
options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12);    
[timeVector1,Sat1Position] = ode45(f, t, Sat1init, options);

options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12);    
[timeVector2,Sat2Position] = ode45(f, t, Sat2init, options);

% Writes both CSV files for both Sattelites
writematrix(Sat1Position,'Sat1Position.csv'); 
writematrix(Sat2Position,'Sat2Position.csv'); 

% Plots 3D graph of both sattelite positions
plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3),'lineWidth', 2.5);
title('Orbit Visualization');
xlabel('X-Position');
ylabel('Y-Position');
zlabel('Z-Position');
hold on
grid on
plot3(Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3),'lineWidth', 2.5);
plot3(0,0,0, 'b.', 'MarkerSize', 650);
plot3(Sat1init(1,1),Sat1init(2,1),Sat1init(3,1),'b.', 'MarkerSize', 50);
plot3(Sat2init(1,1),Sat2init(2,1),Sat2init(3,1),'r.', 'MarkerSize', 50);
legend('ISS','Hubble', 'Earth', 'Initial ISS Position','Initial Hubble Position');

% Saves the 3D graph
savefig('part1.fig');


