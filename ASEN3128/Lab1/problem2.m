% Thomas Dunnington, Eric Dean, Andrew Pearson, Kate Kosmicki, Jacob
% VerMeer
% ASEN 3128
% problem2.m
% Created 8/24/2022
%% Clean up
close all; clear; clc

%% Main, no wind
Cd = 0.6;
mass = 30 / 1000; %kg
area = ((3 / 100) / 2)^2 * pi; %Cross sectional area in meters
g = 9.81;
wind = [0;0;0];
rho = 1.225;

initialState = [0; 0; 0; 0; 20; -20];

funcHandle = @(t, x)objectEOM(t, x, rho, Cd, area, mass, g, wind);

%Event for hitting the ground
opts = odeset('Events',@ProjectileEventsFcn);

[time, finalVec] = ode45(funcHandle, [0 10], initialState, opts);

%% Wind Analysis
windVec = zeros(100, 3);
windVec(:,1) = linspace(0,20,100);

%Variable for the deflection in the x direction
windDistance = zeros(100, 2);

%Color Vector for gradient
blueGrad = zeros(100, 3);
blueGrad(:,3) = 1;
blueGrad(:,2) = linspace(1,0.5,100);

%Varying wind speed and plotting resulting trajectories.
figure();
for i = 1:length(windVec(:,1))
    funcHandle = @(t, x)objectEOM(t, x, rho, Cd, area, mass, g, windVec(i,:)');
    
    [timeTemp, finalVecWind] = ode45(funcHandle, [0 10], initialState, opts);  
    windDistance(i,1) = finalVecWind(end, 1); %The landing spot in x coordinates
    windDistance(i,2) = finalVecWind(end, 2); %The landing spot in y coordinates
    
    plot3(finalVecWind(:,1), finalVecWind(:,2), finalVecWind(:,3), 'linewidth', 2, 'color', blueGrad(i,:));
    set(gca, 'Zdir', 'reverse');
    hold on;
end

%Finding the total distance from the origin
totalDistance = sqrt(windDistance(:,1).^2 + windDistance(:,2).^2);

grid on;
xlabel('North $$(m)$$');
ylabel('East $$(m)$$');
zlabel('Down $$(m)$$');
title('Problem 2c Wind Sensitivity Trajectory');

%% Plotting

%Golf Ball states vs time
figure();
subplot(3,1,1)
plot(time, finalVec(:,1), 'linewidth', 2, 'color', rgb('purple'));

ylabel('North $$(m)$$');
title('Problem 2b: Golf Ball Positions');

subplot(3,1,2)
plot(time, finalVec(:,2), 'linewidth', 2, 'color', rgb('light blue'));

ylabel('East $$(m)$$');

subplot(3,1,3)
plot(time, finalVec(:,3), 'linewidth', 2, 'color', rgb('aqua'));

xlabel('Time $$(s)$$');
ylabel('Downward $$(m)$$');

%Golf Ball Velocities
figure();
subplot(3,1,1)
plot(time, finalVec(:,4), 'linewidth', 2, 'color', 'r');

ylabel('North $$(\frac{m}{s})$$');
title('Problem 2b: Golf Ball Velocities');

subplot(3,1,2)
plot(time, finalVec(:,5), 'linewidth', 2, 'color', rgb('light orange'));

ylabel('East $$(\frac{m}{s})$$');

subplot(3,1,3)
plot(time, finalVec(:,6), 'linewidth', 2, 'color', rgb('pink'));

xlabel('Time $$(s)$$');
ylabel('Downward $$(\frac{m}{s})$$');

%Golf Ball Trajectory
figure();
set(0, 'defaultTextInterpreter', 'latex');
plot3(finalVec(:,1), finalVec(:,2), finalVec(:,3), 'linewidth', 2);
set(gca, 'Zdir', 'reverse');
grid on
xlim([-3,3]);
ylim([0 70]);
%zlim([0 25]);

xlabel('North $$(m)$$');
ylabel('East $$(m)$$');
zlabel('Down $$(m)$$');
title('Problem 2b: Golf Ball Trajectory');

%Wind total distance plotted
figure();
plot(windVec(:,1), totalDistance, 'linewidth', 2);

xlabel('Wind Speed $$(\frac{m}{s})$$');
ylabel('Range Traveled $$(m)$$');
title('Problem 2c: Sensitivity to Wind');

%% Mass Variation
%Limiting from the Kinetic Energy
mass = 30 / 1000;
% E = KE + PE
totalEnergy = .5 * mass * (20^2 + 20^2);

massVec = linspace(0.01,0.25,1000); % From .01 kg (10 g) to 1 kg (1000 g)
%Variable for the deflection in the x direction
xDeflection = zeros(1000, 1);

for i = 1:length(massVec)
    % Calculating new velocity based on energy
    velocity = sqrt((2*totalEnergy)/massVec(i));
    
    %Getting the component with 45 degree angle
    velocity_component = velocity * cos(pi / 4); 
    initialState = [0; 0; 0; 0; velocity_component; -velocity_component];
    funcHandle = @(t, x)objectEOM(t, x, rho, Cd, area, massVec(i), g, wind);
    [time, final] = ode45(funcHandle, [0 10], initialState, opts);  
    xDeflection(i) = final(end, 2); %The landing spot in x coordinates
end

%Finding the optimal mass for the farthest distance
[value, index] = max(xDeflection);
optimalMass = massVec(index);

%% Plotting Problem 2d
figure();
hold on
grid on
plot(massVec, xDeflection', 'linewidth', 2);
xlabel('Mass of the Golf Ball $$(kg)$$')
ylabel('Distance the Ball Travelled $$(m)$$')
title('Problem 2d: Sensitivity of the Mass of the Golf Ball')


%% Functions

function xdot = objectEOM(t, x, rho, Cd, A, m, g, wind)    
%     Inputs:     x = column vector of the state of the golf ball with its position and velocity
%                   = [xPosition; yPosition; zPosition; xVelocity; yVelocity; zVelocity];
%                Cd = coefficient of drag
%                 A = cross sectional area
%                 m = mass of the golf ball
%                 g = acceleration due to gravity
%              wind = wind velocity vector
%              
%     Outputs: xdot = rates of change of the state vector
%                   = [xVelocity; yVelocity; zVelocity; xAcceleration; yAcceleration; zAcceleration]
%                   
%     This function calculates the rate of change of the position vector and
%     the velocity vector for a golf ball projectile
    
        %Finding the air relative velocity
        airRelVel = x(4:6) - wind;
        
        %Normalizing the air relative velocity into a unit vector
        headingVec = airRelVel / norm(airRelVel);

        %Calculating Drag
        drag = 1/2 * (rho * norm(airRelVel)^2) * A * Cd;

        %Summing the forces (drag and gravity)
        forceVec = -drag*headingVec + [0; 0; m * g];
        
        %Finding the acceleration
        accelVec = forceVec ./ m;

        %Calculating the rate of change
        xdot = [x(4); x(5); x(6); accelVec(1); accelVec(2); accelVec(3)];    
end


%Events function, used to determine when the projectile has hit the ground
function [value,isterminal,direction] = ProjectileEventsFcn(t,X)
    value = X(3) >= 0;
    isterminal = 1;
    direction = 0;
end

