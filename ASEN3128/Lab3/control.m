%% Clean Up
clear; clc;


%% Analysis
mass = 0.068;       %kg
radialDist = 0.06;  %m
km = 0.0024;    %N*m/N, controlMomentCoeff
nu = 1e-3;          %N/(m/s)^2, aeroForceCoeff
mu = 2e-6;         %N*m/(rad/s)^2, aeroMomentCoeff
g = 9.81;
I = [5.8e-5,0,0; 0, 7.2e-5,0; 0, 0, 1e-4]; %Moment of inertias

%Initial Conditions
initPos = [0;0;0];
initAngle = [0;0;0];
initVel = [0;0;0];
initAngleVel = [0;0;0];

%Creating the function handle
odeFunc = @(t,var)QuadrotorEOMwithControl(t,var,g,mass,nu,mu);


%4) Plus 0.1 rad/s in roll rate
initPos = [0;0;0];
initAngle = [0;0;0]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0.1;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timeRollRate, finalStateRollRate] = ode45(odeFunc, tspan, x0_steady_hover);

%5) Plus 0.1 rad/s in pitch rate
initPos = [0;0;0];
initAngle = [0;0;0]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0;0.1;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timePitchRate, finalStatePitchRate] = ode45(odeFunc, tspan, x0_steady_hover);

%6) Plus 0.1 rad/s in yaw rate
initPos = [0;0;0];
initAngle = [0;0;0]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0;0;0.1];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timeYawRate, finalStateYawRate] = ode45(odeFunc, tspan, x0_steady_hover);



%% Plotting

%Roll rate variation
controlTemp = zeros(length(timeRollRate), 4);
PlotAircraftSim(timeRollRate, finalStateRollRate, controlTemp, 19:24, '--');


%Pitch rate variation
controlTemp = zeros(length(timePitchRate), 4);
PlotAircraftSim(timePitchRate, finalStatePitchRate, controlTemp, 25:30, '--');


%Yaw rate variation
controlTemp = zeros(length(timeYawRate), 4);
PlotAircraftSim(timeYawRate, finalStateYawRate, controlTemp, 31:36, '--');


%% Functions

function var_dot = QuadrotorEOMwithControl(t, var, g, m, nu, mu) 
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
        [Fc, Gc] = RotationDerivativeFeedback(var, m, g); %Need to get this value during the ode sim
        
        
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





