% Thomas Dunnington, Kate Kosmicki, Eric Dean, Andrew Pearson, Jacob VerMeer
% ASEN 3128
% MassSensitivity.m
% Created 8/31/2022
%% Clean up
close all; clear; clc

%% Overall Inputs
Cd = 0.6;
area = ((3 / 100) / 2)^2 * pi; %Cross sectional area in meters
g = 9.81;
wind = [0;0;0];
rho = 1.125;
mass = 30/1000; % initial mass in kg

%% Mass Variation
%Limiting from the Kinetic Energy
altitude = 0;
velocity_total = sqrt(2*20^2); %Calculating the total Velocity of the two components
% E = KE + PE
totalEnergy = .5 * mass * velocity_total^2 + mass * g * altitude;

mass = .01:.001:1; % From .01 kg (10 g) to 1 kg (1000 g)
%Variable for the deflection in the x direction
xDeflection = zeros(991, 1);

for i = 1:1:991
    % Calculating new velocity based on energy
    velocity = sqrt((2*totalEnergy)/mass(i));
    velocity_component = sqrt(velocity^2/2); 
    initialState = [0; 0; 0; 0; velocity_component; -velocity_component];
    funcHandle = @(t, x)objectEOM(t, x, rho, Cd, area, mass(i), g, wind);
    [time, final] = ode45(funcHandle, [0 10], initialState);  
    xDeflection(i) = final(end, 2); %The landing spot in x coordinates
end

%% Plotting
figure();
hold on
grid on
plot(mass, xDeflection');
xlabel('Mass of the Golf Ball (kg)')
ylabel('Distance the Ball Travelled (m)')
title('2.D Sensitivity of the Mass of the Golf Ball')


%% Functions

function xdot = objectEOM(t, x, rho, Cd, A, m, g, wind)
    % Inputs: x = The x state vector which includes the inertial positions velocities vector
    %           = [x, y, z, u, v, w];
    %       t = time
    %       rho = Density of the air
    %       Cd = coefficient of drag 
    %       A = area of the ball
    %       m = mass of the ball
    %       g = gravity 
    %       wind = wind velocity vector
    %           = [wu, wv, wz]
    % Output: xdot = Vector with inertial velocity and acceleration in each
    %           of the 3 directions
    % Methodology: Use the state vector and wind vector to calculate the air relative velocity
    %           Calculate acceleration from forces (gravity and drag)
 
        %Finding the air relative velocity
        airRelVel = x(4:6) - wind;
        
        headingVec = airRelVel / norm(airRelVel);

        %Calculating Drag
        drag = -.5 * (rho * norm(airRelVel)^2) * A * Cd;

        %The forces are drag and gravity
        forceVec = drag*headingVec + [0; 0; m * g];

        %Calculating the rate of change
        xdot = [x(4); x(5); x(6); forceVec(1) / m; forceVec(2) / m; forceVec(3) / m];    
end
