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
N = 50; %Just to start

Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N);

