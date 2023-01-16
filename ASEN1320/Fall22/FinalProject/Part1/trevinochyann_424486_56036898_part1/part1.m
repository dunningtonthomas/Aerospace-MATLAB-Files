clear; close all; clc;


f = @OrbitEOM; %%call fucntion handle from function

tspan = linspace(0,86400,1441); %%set the side from 0 to 86400 with 1441 points all 60 apart

%%set the initial position provided for sat 1 and 2
Sat1init = [1986.2; 6388.2; -1237.2; -4.93; 0.40; -5.83];
Sat2init = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];

%%set odeset to use in ode45
opts = odeset('RelTol',1e-12,'AbsTol',1e-12);

%%two seperate odesets for each initial position which outputs the postion
%%and velocity
[SpacePos1,SpaceVel1] = ode45(f,tspan,Sat1init, opts);
[SpacePos2,SpaceVel2] = ode45(f,tspan,Sat2init, opts);

%%sets the position and velicity from bot satelittes to sat1 and sat2
Sat1 = [SpacePos1,SpaceVel1];
Sat2 = [SpacePos2,SpaceVel2];

%%set row 2 3 and 4 from sat and and sat2 to sat1position and sat2position
Sat1Position = Sat1(:,2:4);
Sat2Position = Sat2(:,2:4);

%%writes both positions to csv files
writematrix(Sat1Position,'Sat1Position.csv');
writematrix(Sat2Position,'Sat2Position.csv');

%%sets each row from respective positions to x, y and z (number after :
%%says what column to call from
x = Sat1Position(:,1);
y = Sat1Position(:,2);
z = Sat1Position(:,3);
x2 = Sat2Position(:,1);
y2 = Sat2Position(:,2);
z2 = Sat2Position(:,3);

%%plot the ISS orbit 
p1 = plot3(x,y,z,'DisplayName', 'ISS Orbit');
hold on %%allows us to graph both orbits

%%plot the hubble orbit
p2 = plot3(x2,y2,z2, 'DisplayName', 'Hubble Orbit');
legend([p1,p2]);
grid

%%labels eavh axis
xlabel('x-position');
ylabel('y-position');
zlabel('z-position');

%%titles the graph
title('Plot of ISS and Hubble Orbits');