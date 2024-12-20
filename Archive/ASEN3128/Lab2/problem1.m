%% Clean Up
clear; close all; clc;

%% Problem 1
mass = 0.068;       %kg
radialDist = 0.06;  %m
controlMomentCoeff = 0.0024;    %N*m/N
aeroForceCoeff = 1e-3;          %N/(m/s)^2
aeroMomentCoeff = 2e-6;         %N*m/(rad/s)^2
g = 9.81;

%Initial Conditions
initPos = [0;0;-10];
initAngle = [0;0;0];
initVel = [0;0;0];
initAngleVel = [0;0;0];

x0_steady_hover = [initPos; initAngle; initVel; initAngleVel];

%Control Thrust vector
Zc_hover = mass * g;
forces_steady_hover = -1*(Zc_hover / 4) * ones(4,1);

%Control Moment Vector
f1 = forces_steady_hover(1);
f2 = forces_steady_hover(2);
f3 = forces_steady_hover(3);
f4 = forces_steady_hover(4);

moment_steady_hover = [radialDist/sqrt(2) * (-f1 - f2 + f3 + f4); radialDist/sqrt(2) * (f1 - f2 - f3 + f4); controlMomentCoeff*(f1 - f2 + f3 - f4)];


%Creating a function handle
odeFunc = @(t,var)AircraftEOM_No_Aero(t,var,g,mass,aeroForceCoeff,aeroMomentCoeff,forces_steady_hover,moment_steady_hover);

%Calling ode45
tspan = [0 100];
[time, finalState] = ode45(odeFunc, tspan, x0_steady_hover);


%% Plotting
figure();
plot3(finalState(:,1),finalState(:,2),finalState(:,3));
grid on

figure();
plot(time, finalState(:,3));


%% Functions 


function dvar_dt = AircraftEOM_No_Aero(t,var,g,m,nu,mu,Fc,Gc) %keep function name
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
        Ix = 6.8e-5;    %kg*m^2
        Iy = 9.2e-5;    %kg*m^2
        Iz = 1.35e-4;   %kg*m^2


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
        controlForce = (1/m)*[0;0;sum(Fc)];
        
        dvar_dt(7:9,1) = crossOmegaVel + gravity + controlForce;
        
        
        %Calculating the rates of change of the angular velocity
        angularVelMoment = [((Iy - Iz)/Ix)*q*r; ((Iz-Ix)/Iy)*p*r; ((Ix - Iy)/Iz)*p*q];
        controlMoment = Gc ./ [Ix; Iy; Iz];
        
        dvar_dt(10:12,1) = angularVelMoment + controlMoment;  
end









