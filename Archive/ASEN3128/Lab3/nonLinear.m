%% Clean Up
%close all; 
clear; clc;

%% Analysis
mass = 0.068;       %kg
radialDist = 0.06;  %m
km = 0.0024;    %N*m/N, controlMomentCoeff
nu = 1e-3;          %N/(m/s)^2, aeroForceCoeff
mu = 2e-6;         %N*m/(rad/s)^2, aeroMomentCoeff
g = 9.81;

%Initial Conditions
initPos = [0;0;0];
initAngle = [0;0;0];
initVel = [0;0;0];
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];

%Control Thrust vector
Zc_trim = mass * g;
forces_steady_hover = -1*(Zc_trim / 4) * ones(4,1);

%Control Moment Vector
f1 = -1*forces_steady_hover(1);
f2 = -1*forces_steady_hover(2);
f3 = -1*forces_steady_hover(3);
f4 = -1*forces_steady_hover(4);

moment_steady_hover = [radialDist/sqrt(2) * (-f1 - f2 + f3 + f4); radialDist/sqrt(2) * (f1 - f2 - f3 + f4); mu*(f1 - f2 + f3 - f4)];

%Calculating the control force vector
fControl_steady = [0;0;-1*Zc_trim];


%Creating a function handle
odeFunc = @(t,var)AircraftEOM(t,var,g,mass,nu,mu,fControl_steady,moment_steady_hover);


%Variations:

%1) Plus 5 degrees in roll
initPos = [0;0;0];
initAngle = [5*pi/180;0;0]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timeRoll, finalStateRoll] = ode45(odeFunc, tspan, x0_steady_hover);


%2) Plus 5 degrees in pitch
initPos = [0;0;0];
initAngle = [0;5*pi/180;0]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timePitch, finalStatePitch] = ode45(odeFunc, tspan, x0_steady_hover);


%3) Plus 5 degrees in yaw
initPos = [0;0;0];
initAngle = [0;0;5*pi/180]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timeYaw, finalStateYaw] = ode45(odeFunc, tspan, x0_steady_hover);

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



%% Calculating the control
%In this case, the control does not change and is equal to steady hover
steadyHoverControlRoll = zeros(length(timeRoll),4);
steadyHoverControlRoll(:,1) = Zc_trim*ones(length(timeRoll),1);

steadyHoverControlPitch = zeros(length(timePitch),4);
steadyHoverControlPitch(:,1) = Zc_trim*ones(length(timePitch),1);

steadyHoverControlYaw = zeros(length(timeYaw),4);
steadyHoverControlYaw(:,1) = Zc_trim*ones(length(timeYaw),1);

steadyHoverControlRollRate = zeros(length(timeRollRate),4);
steadyHoverControlRollRate(:,1) = Zc_trim*ones(length(timeRollRate),1);

steadyHoverControlPitchRate = zeros(length(timePitchRate),4);
steadyHoverControlPitchRate(:,1) = Zc_trim*ones(length(timePitchRate),1);

steadyHoverControlYawRate = zeros(length(timeYawRate),4);
steadyHoverControlYawRate(:,1) = Zc_trim*ones(length(timeYawRate),1);


%% Calculating the motor forces
force = Zc_trim / 4;
motorForcesRollRate = force*ones(length(timeRollRate),4);

motorForcesPitchRate = force*ones(length(timeRollRate),4);

motorForcesYawRate = force*ones(length(timeRollRate),4);



%% Plotting
%Roll variation
PlotAircraftSim(timeRoll, finalStateRoll, steadyHoverControlRoll, 1:6, '-');


%Pitch variation
PlotAircraftSim(timePitch, finalStatePitch, steadyHoverControlPitch, 7:12, '-');


%Yaw variation
PlotAircraftSim(timeYaw, finalStateYaw, steadyHoverControlYaw, 13:18, '-');


%Roll rate variation
PlotAircraftSim(timeRollRate, finalStateRollRate, steadyHoverControlRollRate, 19:24, '-');


%Pitch rate variation
PlotAircraftSim(timePitchRate, finalStatePitchRate, steadyHoverControlPitchRate, 25:30, '-');


%Yaw rate variation
PlotAircraftSim(timeYawRate, finalStateYawRate, steadyHoverControlYawRate, 31:36, '-');



%Plotting the motor forces
%Roll Rate Variation
plotMotorForces(timeRollRate, motorForcesRollRate,100,'-');

%Pitch Rate Variation
plotMotorForces(timePitchRate, motorForcesPitchRate,101,'-');

%Yaw Rate Variation
plotMotorForces(timeYawRate, motorForcesYawRate,102,'-');


%% Functions

%Aircraft EOM no control
function dvar_dt = AircraftEOM(t,var,g,m,nu,mu,Fc,Gc) %keep function name
% please put group number here
% INPUTS: t is scalar time
%         var is a column vector of the aircraft state
%         g is scalar gravity
%         m is scalar mass
%         nu is the scalar aerodynamic force coefficient
%         mu is the scalar aerodynamic moment coefficient
%         Fc is a column vector of Body-Frame Control Forces
%         Gc is a column vector of Body-Frame Control Moments

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
        
        
        %Calculating velocity
        phi = eulerAngles(1);
        theta = eulerAngles(2);
        psi = eulerAngles(3);
        
        rotMat321 = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi); cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi); -sin(theta), sin(phi)*cos(theta), cos(phi)*cos(theta)];
        
        dvar_dt(1:3,1) = rotMat321 * velVec;
        
        
        %Calculating Rate of change of the Euler Angles
        rotMatEuler = [1, sin(phi)*tan(theta), cos(phi)*tan(theta); 0, cos(phi), -sin(phi); 0, sin(phi)*sec(theta), cos(phi)*sec(theta)];
        
        dvar_dt(4:6,1) = rotMatEuler * omegaVec;
        
        
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
        
        dvar_dt(7:9,1) = crossOmegaVel + gravity + controlForce + aeroForce;
        
        
        %Calculating the rates of change of the angular velocity
        angularVelMoment = [((Iy - Iz)/Ix)*q*r; ((Iz-Ix)/Iy)*p*r; ((Ix - Iy)/Iz)*p*q];
        controlMoment = Gc ./ [Ix; Iy; Iz];
        aeroMoment = (-mu*norm(omegaVec)*omegaVec) ./ [Ix; Iy; Iz];
        
        dvar_dt(10:12,1) = angularVelMoment + controlMoment + aeroMoment; 
end




