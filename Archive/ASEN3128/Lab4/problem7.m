%% Clean Up
clear; close all; clc;


%% Analysis
%Constants
mass = 0.068;       %kg
radialDist = 0.06;  %m
km = 0.0024;    %N*m/N, controlMomentCoeff
nu = 1e-3;          %N/(m/s)^2, aeroForceCoeff
mu = 2e-6;         %N*m/(rad/s)^2, aeroMomentCoeff
g = 9.81;
Ix = 5.8e-5;    %kg*m^2
Iy = 7.2e-5;    %kg*m^2
Iz = 1.0e-4;   %kg*m^2
I = [Ix, 0, 0; 0, Iy, 0; 0, 0, Iz];



%% Testing Longitudinal and Lateral reference velocities

%Create a function handle LATERAL
latOrLong = "lat";
odeFuncLat = @(t,var)QuadrotorEOMwithControlCommand(t,var,g,mass,nu,mu,I, latOrLong);

%Create a function handle LONGITUDINAL
latOrLong = "long";
odeFuncLong = @(t,var)QuadrotorEOMwithControlCommand(t,var,g,mass,nu,mu,I, latOrLong);


%LATERAL SIMULATION
%Start at initial stationary position with no angles and 0 position
initPos = [0;0;0];
initAngle = [0;0;0];
initVel = [0;0;0]; %Start with the reference velocity
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timeLat, finalStateLat] = ode45(odeFuncLat, tspan, x0_steady_hover);

%LONGITUDINAL SIMULATION
%Start at initial stationary position with no angles and 0 position
initPos = [0;0;0];
initAngle = [0;0;0];
initVel = [0;0;0]; %Start with the reference velocity
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timeLong, finalStateLong] = ode45(odeFuncLong, tspan, x0_steady_hover);


%% Calculating The corresponding controls and the motor forces

%Controls over time

%LATERAL SIMULATION CONTROLS
controlLat = zeros(length(timeLat), 4);
motorForcesLat = zeros(length(timeLat),4);
for i = 1:length(timeLat)
    %Finding the controls
    [Fc, Gc] = VelocityReferenceFeedback(timeLat(i), finalStateLat(i,:), "lat");
    controlLat(i,:) = [-1*Fc(3), Gc(1), Gc(2), Gc(3)];
    
    %Finding the motor forces
    motorForcesLat(i,:) = ComputeMotorForces(Fc, Gc, radialDist, km)';
end


%LONGITUDINAL SIMULATION CONTROLS
controlLong = zeros(length(timeLong), 4);
motorForcesLong = zeros(length(timeLong),4);
for i = 1:length(timeLong)
    %Finding the controls
    [Fc, Gc] = VelocityReferenceFeedback(timeLong(i), finalStateLong(i,:), "long");
    controlLong(i,:) = [-1*Fc(3), Gc(1), Gc(2), Gc(3)];
    
    %Finding the motor forcces
    motorForcesLong(i,:) = ComputeMotorForces(Fc, Gc, radialDist, km)';
end



%% Plotting

%LATERAL
PlotAircraftSim(timeLat, finalStateLat, controlLat, 1:6, '-');


%LONGITUDINAL
%PlotAircraftSim(timeLong, finalStateLong, controlLong, 7:12, 'r');


%% Functions

function var_dot = QuadrotorEOMwithControlCommand(t, var, g, m, nu, mu, I, latOrLong) 
%This function calculates the equations of motion for a quadrotor with a
%controller. 
%Inputs: var = 12by1 state vector; g = gravity; m = mass; nu = aerodynamic
%force coefficient; mu = aerodynamic moment coefficient
%Outputs: var_dot is the rates of change of each variable in the 12by1
%state matrix


        %Define the moments of inertia
        Ix = 5.8e-5;    %kg*m^2
        Iy = 7.2e-5;    %kg*m^2
        Iz = 1.0e-4;   %kg*m^2
        
        Ix = I(1);
        Iy = I(2,2);
        Iz = I(3,3);


        %Inertial positions
        posVec = var(1:3,1);
        
        %Euler Angles
        eulerAngles = var(4:6,1);
        
        %Body frame inertial velocity
        velVec = var(7:9,1);
        
        %Angular rates
        omegaVec = var(10:12,1);
        
        
        %Calling the controller functions to get the control forces and
        %moments
        [Fc, Gc] = VelocityReferenceFeedback(t, var, latOrLong); %Inner loop forces and moments
        
        
        %Calculating velocity
        phi = eulerAngles(1);
        theta = eulerAngles(2);
        psi = eulerAngles(3);
        
        rotMat321 = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi); cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi); -sin(theta), sin(phi)*cos(theta), cos(phi)*cos(theta)];
        
        var_dot(1:3,1) = rotMat321 * velVec;
        
        
        %Calculating Rate of change of the Euler Angles
        rotMatEuler = [1, sin(phi)*tan(theta), cos(phi)*tan(theta); 0, cos(phi), -sin(phi); 0, sin(phi)*sec(theta), cos(phi)*sec(theta)];
        
        var_dot(4:6,1) = rotMatEuler * omegaVec;
        
        
        %Calculating the acceleration in body coordinates
        %The cross product of omega and u,v,w
        p = omegaVec(1);
        q = omegaVec(2);
        r = omegaVec(3);
        u = velVec(1);
        v = velVec(2);
        w = velVec(3);
        
        crossOmegaVel = [r*v - q*w; p*w - r*u; q*u - p*v];
        gravity = g*[-sin(theta); cos(theta)*sin(phi); cos(theta)*cos(phi)];
        controlForce = (1/m)*Fc;
        aeroForce = (1/m)*(-nu*norm(velVec)*velVec);
        
        var_dot(7:9,1) = crossOmegaVel + gravity + controlForce + aeroForce;
        
        
        %Calculating the rates of change of the angular velocity
        angularVelMoment = [((Iy - Iz)/Ix)*q*r; ((Iz-Ix)/Iy)*p*r; ((Ix - Iy)/Iz)*p*q];
        controlMoment = Gc ./ [Ix; Iy; Iz];
        aeroMoment = (-mu*norm(omegaVec)*omegaVec) ./ [Ix; Iy; Iz];
        
        var_dot(10:12,1) = angularVelMoment + controlMoment + aeroMoment; 
end



