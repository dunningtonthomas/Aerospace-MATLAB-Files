%% Clean Up
clear; 
%close all; 
clc;


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


%Need lateral and longintudinal feedback control
timeConst1 = 0.5;
timeConst2 = timeConst1 / 10;

%These are the eigenvalues we want from the state space matrix
lamda1 = -1/timeConst1;
lamda2 = -1/timeConst2;

%Set up the A matrix
%Sove this system to get x and y
tempMat = [-1,2,-4;-1,20,-400];
solveMat = rref(tempMat);
tempX = solveMat(1,end);
tempY = solveMat(2,end);

%Finding the lateral gains
k1_lat = -1*Ix*tempY;
k2_lat = -1*Ix*tempX;

%Finding the longitudinal gains
k1_long = -1*Iy*tempY;
k2_long = -1*Iy*tempX;




%% Testing the response 

ALat = [0, 1; -k2_lat / Ix, -k1_lat/Ix];
ALong = [0, 1; -k2_long/ Iy, -k1_long/Iy];


%% Testing the variations

%Create a function handle
odeFunc = @(t,var)QuadrotorEOM_Linearized(t,var,g,mass,I);

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


%3) Plus 0.1 rad/s in roll rate
initPos = [0;0;0];
initAngle = [0;0;0]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0.1;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timeRollRate, finalStateRollRate] = ode45(odeFunc, tspan, x0_steady_hover);


%4) Plus 0.1 rad/s in pitch rate
initPos = [0;0;0];
initAngle = [0;0;0]; %5 degree change in roll angle
initVel = [0;0;0];
initAngleVel = [0;0.1;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];
tspan = [0 10];
[timePitchRate, finalStatePitchRate] = ode45(odeFunc, tspan, x0_steady_hover);

%% Calculating The corresponding controls and the motor forces

%Controls over time

%Roll variation
controlRoll = zeros(length(timeRoll), 4);
motorForcesRoll = zeros(length(timeRoll),4);
for i = 1:length(timeRoll)
    %Finding the controls
    [Fc, Gc] = innerLoopFeedback(finalStateRoll(i,:));
    controlRoll(i,:) = [-1*Fc(3), Gc(1), Gc(2), Gc(3)];
    
    %Finding the motor forces
    motorForcesRoll(i,:) = ComputeMotorForces(Fc, Gc, radialDist, km)';
end

%Roll rate variation CONTROLS and MOTORFORCES
controlRollRate = zeros(length(timeRollRate), 4);
motorForcesRollRate = zeros(length(timeRollRate),4);
for i = 1:length(timeRollRate)
    %Finding the controls
    [Fc, Gc] = innerLoopFeedback(finalStateRollRate(i,:));
    controlRollRate(i,:) = [-1*Fc(3), Gc(1), Gc(2), Gc(3)];
    
    %Finding the motor forces
    motorForcesRollRate(i,:) = ComputeMotorForces(Fc, Gc, radialDist, km)';
end


%Pitch variation CONTROLS and MOTORFORCES
controlPitch = zeros(length(timePitch), 4);
motorForcesPitch = zeros(length(timePitch),4);
for i = 1:length(timePitch)
    %Finding the controls
    [Fc, Gc] = innerLoopFeedback(finalStatePitch(i,:));
    controlPitch(i,:) = [-1*Fc(3), Gc(1), Gc(2), Gc(3)];
    
    %Finding the motor forces
    motorForcesPitch(i,:) = ComputeMotorForces(Fc, Gc, radialDist, km)';
end


%Pitch rate variation CONTROLS and MOTORFORCES
controlPitchRate = zeros(length(timePitchRate), 4);
motorForcesPitchRate = zeros(length(timePitchRate),4);
for i = 1:length(timePitchRate)
    %Finding the controls
    [Fc, Gc] = innerLoopFeedback(finalStatePitchRate(i,:));
    controlPitchRate(i,:) = [-1*Fc(3), Gc(1), Gc(2), Gc(3)];
    
    %Finding the motor forces
    motorForcesPitchRate(i,:) = ComputeMotorForces(Fc, Gc, radialDist, km)';
end


%% Plotting

%Roll variation
PlotAircraftSim(timeRoll, finalStateRoll, controlRoll, 1:6, '-');


%Pitch variation
PlotAircraftSim(timePitch, finalStatePitch, controlPitch, 7:12, '-');


%Roll rate variation
PlotAircraftSim(timeRollRate, finalStateRollRate, controlRollRate, 13:18, '-');


%Pitch rate variation
PlotAircraftSim(timePitchRate, finalStatePitchRate, controlPitchRate, 19:24, '-');






%% Functions

function dvar_dt = QuadrotorEOM_Linearized(t,var,g,m,I) %keep function name
% please put group number here
% INPUTS: t is scalar time
%         var is a column vector of the aircraft state
%         g is scalar gravity
%         m is scalar mass
%         I is the 3x3 inertia matrix


        %Calling the controller to get Fc and Gc
        [Fc, Gc] = innerLoopFeedback(var);
        
        %Finding the CHANGE in the control force since this is the linear
        %function
        Zc0 = -m*g;
        del_Zc = Fc(3) - Zc0;
        
        
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
        dvar_dt(7:9,1) = g*[-theta; phi; 0] + (1/m)*del_Zc;
        
        %Finding the rate of change of the angular rates
        dvar_dt(10:12,1) = Gc ./ diag(I);
end










