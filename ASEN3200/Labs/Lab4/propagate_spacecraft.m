function [Xout, OEout] = propagate_spacecraft(X0, t0, tf, A, m)
%ROPAGATE_SPACECRAFT 
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


%Two body problem EOM
%State is [x;y;z;vx;vy;vz]
%mu is gravitational constant
% mu = 4.892;
%     
% r = X0(1:3);
% rDot = X0(4:end);
%     
% dr = rDot;
% rDotDot = -1*mu*r ./ (norm(r))^3;
%     
% outVec = [dr; rDotDot];

%Create function handle
mu = 4.892 / 1000^3;
funHandle = @(t, state)EOM(t, state, mu, A, m);

%Define tspan
tspan = [t0 tf];

%Call ode45 to propagate state variables
[tout, stateOut] = ode45(funHandle, tspan, X0);

%Output final state
Xout = stateOut(end,:)';

%Calculating orbital elements
OEout = 0;


%EOM Function
function outVec = EOM(t, state, mu, area, mass)
    %Two body problem EOM
    %State is [x;y;z;vx;vy;vz]
    %t is time
    %mu is gravitational constant
    
    r = state(1:3);
    rDot = state(4:end);
    
    dr = rDot;
    rDotDot = -1*mu*r ./ (norm(r))^3;
    
    outVec = [dr; rDotDot];
end
end
