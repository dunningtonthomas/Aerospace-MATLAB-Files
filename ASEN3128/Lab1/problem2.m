% Thomas Dunnington, Kate, Eric, Andrew, 
% ASEN 3128
% main.m
% Created 8/24/2022
%% Clean up
close all; clear; clc

%% Main, no wind
Cd = 0.6;
mass = 30 / 1000; %kg
area = ((3 / 100) / 2)^2 * pi; %Cross sectional area in meters
g = 9.81;
wind = [0;0;0];
rho = 1.125;

initialState = [0; 0; 0; 0; 20; -20];

funcHandle = @(t, x)objectEOM(t, x, rho, Cd, area, mass, g, wind);

%Event for hitting the ground
opts = odeset('Events',@ProjectileEventsFcn);

[time, finalVec] = ode45(funcHandle, [0 10], initialState, opts);

%% Wind
windVec = zeros(100, 3);
windVec(:,1) = linspace(0,20,100);

%Variable for the deflection in the x direction
xDeflection = zeros(100, 1);

for i = 1:length(windVec)
    funcHandle = @(t, x)objectEOM(t, x, rho, Cd, area, mass, g, windVec(i));
    
    [time, finalVecWind] = ode45(funcHandle, [0 10], initialState, opts);  
    xDeflection(i) = finalVecWind(end, 1); %The landing spot in x coordinates
end

%% Plotting
figure();
set(0, 'defaultTextInterpreter', 'latex');
plot3(finalVec(:,1), finalVec(:,2), -1*finalVec(:,3), 'linewidth', 2);
grid on
xlim([-3,3]);
ylim([0 70]);
zlim([0 25]);

xlabel('North');
ylabel('East');
zlabel('Upwards');

figure();
plot(windVec(:,1), xDeflection);


%% Functions

function xdot = objectEOM(t, x, rho, Cd, A, m, g, wind)
    %Inputs:
    %The x state vector includes the inertial position and the inertial
    %velocity vector, to calculate the air relative velocity, we subtract
    %the wind from the inertial velocity
 
        %Finding the air relative velocity
        airRelVel = x(4:6) - wind;
        
        headingVec = airRelVel / norm(airRelVel);

        %Calculating Drag
        drag = 1/2 * (rho * norm(airRelVel)^2) * A * Cd;

        %The forces are drag and gravity
        forceVec = -drag*headingVec + [0; 0; m * g];

        %Calculating the rate of change
        xdot = [x(4); x(5); x(6); forceVec(1) / m; forceVec(2) / m; forceVec(3) / m];    
end


%Events function, used to determine when the projectile has hit the ground
function [value,isterminal,direction] = ProjectileEventsFcn(t,X)
    value = X(3) >= 0;
    isterminal = 1;
    direction = 0;
end

