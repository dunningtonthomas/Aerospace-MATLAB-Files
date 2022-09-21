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
initAngle = [5*pi/180;0;0];
initVel = [0;0;0];
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];


%Force and moment deviations
delZc = 0;
delLc = 0;
delMc = 0;
delNc = 0;

%Creating a function handle
odeFunc = @(t,var)AircraftEOM_Linear(t,var,g,mass,I,[0;0;delZc],[delLc;delMc;delNc]);

%Calling ode45
%options = odeset('RelTol',1e-13,'AbsTol',1e-13);
tspan = [0 10];
[time, finalState] = ode45(odeFunc, tspan, x0_steady_hover);





%% Plotting

control = zeros(length(time),4); %[delZc; delLc; delMc; delNc]
PlotAircraftSim(time, finalState, control, [1,2,3,4,5,6], '--');


%% Functions

function dvar_dt = AircraftEOM_Linear(t,var,g,m,I,deltaFc,deltaGc) %keep function name
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





