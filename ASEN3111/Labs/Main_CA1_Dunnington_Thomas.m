%% ASEN 3111 - Computational Assignment 1 - Main
% Provide a breif summary of the problem statement and code so that
% you or someone else can later understand what you attempted to do
% it doesn’t have to be that long.
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson
% Date: 1/17/2023

%Clean Up
close all; clear; clc;

%% Problem 1

%Symbolic integration to determine the sectional lift and drag coefficients
    %%%%Double check that it is ok to have the symbolic implementation
syms theta;
Cp_syms = (1 - (4*(sin(theta)).^2 + 4*sin(theta) + 1));
cl = int(-0.5*Cp_syms*sin(theta), theta, 0, 2*pi);
cd = int(-0.5*Cp_syms*cos(theta), theta, 0, 2*pi);
fprintf("Analytical sectional lift and drag coefficients:\n\t cl: %f \n\t cd: %f\n", double(cl), double(cd));

%Numerical integration with the trapezoidal composite method

%Anonymous function for the coefficient of pressure with the given
%circulation
Cp_cl = @(th)(-0.5*sin(th))*(1 - (4*(sin(th)).^2 + 4*sin(th) + 1));
Cp_cd = @(th)(-0.5*cos(th))*(1 - (4*(sin(th)).^2 + 4*sin(th) + 1));

%Computing the coefficient 100 times from 1 to 100 discretizations of the
%cylinder








