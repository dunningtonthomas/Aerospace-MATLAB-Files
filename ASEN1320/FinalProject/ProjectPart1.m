%% Housekeeping
clear; clc; close all;

%% Given parameters
% Initial State of Satellite 1 (ISS)
Sat1init =[1986.2;6388.3;-1237.2;-4.93;0.40;-5.83];                        
                       
% Initial State of Satellite 2 (Hubble)
Sat2init =[6480.8;1108.2;-2145.5;-0.29;7.07;2.75];

% Initial Cartesian Coordinates of GS (Goldstone DSN, California)
GSinit = [-2314.87;4663.28;3673.75];  

tv = 0:60:86400;                                       % Time vector (every 60 secs)
 
tolerance = 1e-12;
opts = odeset('RelTol',tolerance,'AbsTol',tolerance);  % ODE45 options

%% Part 1.1 and 1.2 -  Orbit Simulation
[~,Sat1] = ode45(@OrbitEOM,tv,Sat1init,opts);
Sat1Position = Sat1(:,1:3);

[~,Sat2] = ode45(@OrbitEOM,tv,Sat2init,opts);
Sat2Position = Sat2(:,1:3);

% Grader assessment via Sat1Postion and Sat2Position (size 1441x3)

%% Part 1.3 -  Orbit Visualization 
figure
hold on
plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3))
plot3(Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3))
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
title('LEO Orbits of Sat1 and Sat2')
legend('Sat 1','Sat 2')
axis equal
view(-15,35);
% figure submitted to Canvas (manually graded during interview) 

%% Output to CSV using csvwrite
writematrix(Sat1Position,'Sat1Position.csv','Delimiter','comma');
writematrix(Sat2Position,'Sat2Position.csv','Delimiter','comma');
% csv file submitted to Canvas (check for completion)