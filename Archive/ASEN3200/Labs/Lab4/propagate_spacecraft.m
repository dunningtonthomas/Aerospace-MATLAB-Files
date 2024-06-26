function [Xout, OEout, Tout] = propagate_spacecraft(X0, t0, tf, A, m)
%PROPAGATE_SPACECRAFT 
%Author: Thomas Dunnington
%Date: 4/6/2023
%Summary: Description: This function accepts an initial state, initial time, final time, SRP area, and spacecraft mass in km,
% kg, s units and outputs the state and orbital elements at the final time.
% Inputs:
%   X0 - [6 by 1 ] spacecraft Cartesian state vector in the ACI frame [x, y, z,  ̇x,  ̇y,  ̇z]T at the initial time
%   t0 - scalar, initial time in seconds
%   tf - scalar, final time in seconds
%   A - scalar, SRP area in km2
%   m - scalar, spacecraft mass in kg
% Outputs:
%   Xout - [6 by 1 ] spacecraft Cartesian state vector in the ACI frame [x; y; z; x;̇y; z] at the final time
%   OEout - [6 by 1 ] spacecraft orbital elements relative to the ACI frame [a; e; i; OMEGA; omega; Theta] at the final
%   time tf in km and degrees on [−180, 180]

%Assume bennu is located at the 0, 0, 0


%Create function handle
mu = 4.892 / 1000^3;
A = A * 1000^2; %Convert to m^2
funHandle = @(t, state)EOM(t, state, mu, A, m);

%Define tspan
tspan = t0:60:tf;

%Call ode45 to propagate state variables
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[Tout, stateOut] = ode45(funHandle, tspan, X0, options);

%Output final state
Xout = stateOut;

%Velocity
Vout = Xout(:,4:end);
speed = vecnorm(Vout, 2, 2); 

%Distance
Rout = Xout(:,1:3);
distance = vecnorm(Rout, 2, 2); 

%Computing the specific agular momentum
hVec = cross(Rout, Vout, 2);
h = vecnorm(hVec, 2, 2);

%Calculating line of nodes vector
Zhat = [zeros(length(stateOut(:,1)), 1), zeros(length(stateOut(:,1)), 1), ones(length(stateOut(:,1)), 1)];
nVec = cross(Zhat, hVec, 2);
n = vecnorm(nVec, 2, 2);

%Calculate a
energy = 0.5*speed.^2 - mu./distance;
a = -mu ./ (2*energy);

%Computing the eccentricity vector
eVec = (1/mu)*cross(Vout, hVec, 2) - (1./vecnorm(Rout, 2, 2)).*Rout;
e = vecnorm(eVec, 2, 2);

%Calculating i
hz = hVec(:,3);
i = acosd(hz ./ h);

%Calculating OMEGA
nx = nVec(:,1);
OMEGA = acosd(nx ./ n);

%Quadrant Check
nyLog = nVec(:,2) < 0;
OMEGA(nyLog) = 360 - OMEGA(nyLog);

%Calculating omega
nDote = dot(nVec, eVec, 2) ./ (vecnorm(eVec, 2, 2) .* vecnorm(nVec, 2, 2));
omega = acosd(nDote);

%Quadrant Check
ezLog = eVec(:,3) < 0;
omega(ezLog) = 360 - omega(ezLog);

%Calculating theta
eDotr = dot(eVec, Rout, 2) ./ (vecnorm(eVec, 2, 2) .* vecnorm(Rout, 2, 2));
theta = acosd(eDotr);

%Quadrant Check
rDotv = dot(Rout, Vout, 2);
tempLog = rDotv < 0;
theta(tempLog) = 360 - theta(tempLog);


%Output elements
OEout = [a, e, i*pi/180, OMEGA*pi/180, omega*pi/180, theta*pi/180];


end

