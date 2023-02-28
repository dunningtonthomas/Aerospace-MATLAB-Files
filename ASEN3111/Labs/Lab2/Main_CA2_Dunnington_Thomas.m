%% ASEN 3111 - Computational Assignment 2 - Main
%
%
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson
% Date: 2/21/2023

%% Clean Up
close all; clear; clc;


%% Parameters
c = 5; %meters
alpha = 15 * pi/180; %Radius
V_inf = 34; %m/s
p_inf = 101.3 * 10^3;
rho_inf = 1.225; %kg/m^3
N = 500; %The true value

%Plotting streamfunction, equipotential, and pressure contours
[streamfuncTrue,equipotentialTrue,CpTrue] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,1);


%% Performing error study with number of N vortices
streamfuncVals = zeros(100,100,N/5);
equipotentialVals = zeros(100,100,N/5);
CpVals = zeros(100,100,N/5);

streamfuncError = zeros(1,N/5);
equipotentialError = zeros(1,N/5);
CpError = zeros(1,N/5);


%Running up to 500 vortices, going up by 5
for i = 1:100
    [streamfuncVals(:,:,i), equipotentialVals(:,:,i), CpVals(:,:,i)] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,5*i,0);

    %Calculate the error, (actual - expected) / expected
    CpError(i) = mean((CpVals(:,:,1) - CpTrue) ./ CpTrue, 'all') * 100;
    streamfuncError(i) = mean((streamfuncVals(:,:,1) - streamfuncTrue) ./ streamfuncTrue, 'all') * 100;
    equipotentialError(i) = mean((equipotentialVals(:,:,1) - equipotentialTrue) ./ equipotentialTrue, 'all') * 100;

end





