close all; clear; clc;

% Sat1 = [xs1; ys1; zs1; vxs1; vys1; vzs1]; % position and velocity state of Sat1
% Sat2 = [xs2; ys2; zs2; vxs2; vys2; vzs2]; % position and velocity state of Sat2
% GS = [xg; yg; zg]; % position of ground station

Sat1_initial = [1986.2; 6388.2; -1237.2; -4.93; 0.40; -5.83]; % initial values of Sat1
Sat2_initial = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75]; % initial values of Sat2
GS_initial = [-2314.87; 4663.275; 3673.747]; % initial values of ground station

%% 1.1 NUMERICAL INTEGRATION STEP
tspan = linspace(0,86400,14400); % tspan! goes in seconds from 0 to 86400, and does it 14400 times

% odeset options! 10^-12 is the relative absolute error tolerance
options = odeset('RelTol',1e-12,'AbsTol',1e-12);

% OrbitEOM handle
OrbitEOM_func = @OrbitEOM; % calling the OrbitEOM function OrbitEOM_func

%calling ode45
[time_vector_1,state_matrix_1] = ode45(OrbitEOM_func,tspan,Sat1_initial,options); % running it first time for 1st satellite
[time_vector_2,state_matrix_2] = ode45(OrbitEOM_func,tspan,Sat2_initial,options); % running it second time for 2nd satellite

x1 = state_matrix_1(:,1);
y1 = state_matrix_1(:,2);
z1 = state_matrix_1(:,3);

x2 = state_matrix_2(:,1);
y2 = state_matrix_2(:,2);
z2 = state_matrix_2(:,3);
%% 1.2 SPACECRAFT ORBIT SIMULATION
% the state vector is [x;y;z;vx;vy;vz]... use position_1 and 2 to store
% these into new matrixes 

Sat1Position = state_matrix_1(: , 1:3); % sat 1 position coloumns 1 to 3(xyz)
Sat2Position = state_matrix_2(:, 1:3); % sat 2 position coloumns 1 to 3(xyz)

% export those two positions to csv files
writematrix(Sat1Position, 'Sat1Position.csv');
writematrix(Sat2Position, 'Sat2Position.csv');

%% 1.3 ORBIT VISUALIZATION
% plot the positions of both ISS and Hubble in the same figure to visualize their orbit in 3D.
% Make sure all axes are clearly labeled, and include a descriptive legend for orbit plots. 
% Also add a descriptive title to your plot. Save the plot as a MATLAB figure named part1.fig.  

% plot ISS
plot3(x1,y1,z1,'k');
hold on;
% plot Hubble
plot3(x2,y2,z2,'b');
hold on;
% labels and legend
xlabel('X');
ylabel('Y');
zlabel('Z');
legend('ISS Satellite', 'Hubble Satellite');
title('Position and Velocity of the ISS and Hubble');
hold off;
savefig('part1.fig'); % saving the figure as part1.fig
