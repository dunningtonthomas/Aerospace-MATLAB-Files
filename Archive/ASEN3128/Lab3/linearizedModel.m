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
I = [5.8e-5,0,0; 0, 7.2e-5,0; 0, 0, 1e-4]; %Moment of inertias

%Initial Conditions
initPos = [0;0;0];
initAngle = [0;0;0];
initVel = [0;0;0];
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];

%Force and moment deviations
Zc_trim = -1*mass * g;

delZc = 0; %zero deviations from the trim condition
delLc = 0;
delMc = 0;
delNc = 0;

%Creating a function handle
odeFunc = @(t,var)QuadrotorEOM_Linearized(t,var,g,mass,I,[0;0;delZc],[delLc;delMc;delNc]);



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
steadyHoverControlRoll(:,1) = -1*Zc_trim*ones(length(timeRoll),1);

steadyHoverControlPitch = zeros(length(timePitch),4);
steadyHoverControlPitch(:,1) = -1*Zc_trim*ones(length(timePitch),1);

steadyHoverControlYaw = zeros(length(timeYaw),4);
steadyHoverControlYaw(:,1) = -1*Zc_trim*ones(length(timeYaw),1);

steadyHoverControlRollRate = zeros(length(timeRollRate),4);
steadyHoverControlRollRate(:,1) = -1*Zc_trim*ones(length(timeRollRate),1);

steadyHoverControlPitchRate = zeros(length(timePitchRate),4);
steadyHoverControlPitchRate(:,1) = -1*Zc_trim*ones(length(timePitchRate),1);

steadyHoverControlYawRate = zeros(length(timeYawRate),4);
steadyHoverControlYawRate(:,1) = -1*Zc_trim*ones(length(timeYawRate),1);


%% Plotting

%Roll variation
PlotAircraftSim(timeRoll, finalStateRoll, steadyHoverControlRoll, 1:6, '--');


%Pitch variation
controlTemp = zeros(length(timePitch), 4);
PlotAircraftSim(timePitch, finalStatePitch, steadyHoverControlPitch, 7:12, '--');


%Yaw variation
controlTemp = zeros(length(timeYaw), 4);
PlotAircraftSim(timeYaw, finalStateYaw, steadyHoverControlYaw, 13:18, '--');


%Roll rate variation
controlTemp = zeros(length(timeRollRate), 4);
PlotAircraftSim(timeRollRate, finalStateRollRate, steadyHoverControlRollRate, 19:24, '--');


%Pitch rate variation
controlTemp = zeros(length(timePitchRate), 4);
PlotAircraftSim(timePitchRate, finalStatePitchRate, steadyHoverControlPitchRate, 25:30, '--');


%Yaw rate variation
controlTemp = zeros(length(timeYawRate), 4);
PlotAircraftSim(timeYawRate, finalStateYawRate, steadyHoverControlYawRate, 31:36, '--');

%% Functions

function dvar_dt = QuadrotorEOM_Linearized(t,var,g,m,I,deltaFc,deltaGc) %keep function name
% please put group number here
% INPUTS: t is scalar time
%         var is a column vector of the aircraft state
%         g is scalar gravity
%         m is scalar mass
%         I is the 3x3 inertia matrix
%         deltaFc is a 3x1 column vector of Body-Frame Control Forces Deviations from Trim
%         deltaGc is a 3x1 column vector of Body-Frame Control Moments Deviations from Trim

        %Inertial positions
        posVec = var(1:3,1);
        
        %Euler Angles
        eulerAngles = var(4:6,1);
        
        %Body frame inertial velocity
        velVec = var(7:9,1);
        
        %Angular rates
        omegaVec = var(10:12,1);
        
        
        %CALCULATING THE RATES OF CHANGE
        
        %The rate of change of the positions are just the velocities
        dvar_dt(1:3,1) = velVec;
        
        %The rate of change of the Euler Angles are just the angular rates
        dvar_dt(4:6,1) = omegaVec;

        %Finding the rate of change of the velocities
        phi = eulerAngles(1);
        theta = eulerAngles(2);
        dvar_dt(7:9,1) = g*[-theta; phi; 0] + (1/m)*deltaFc;
        
        %Finding the rate of change of the angular rates
        dvar_dt(10:12,1) = deltaGc ./ diag(I);
end





