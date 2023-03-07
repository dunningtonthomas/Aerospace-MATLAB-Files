%% ASEN 3111 - Computational Assignment 3 - Main
%SUMMARY: 
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase
% Rupprecht
% Date: 4/6/2023

%% Clean Up
close all; clear; clc;

%% Problem 1
m = 4 / 100;
p = 4 / 10;
t = 15 / 100;
c = 5;
N = 100;

[x,y] = NACA_Airfoils(m,p,t,c,N);


%Plotting
figure();
plot(x,y);
axis equal;


%NACA 0012 airfoil
m = 0;
p = 0;
t = 12 / 100;
c = 5;
N = 100;

[x,y] = NACA_Airfoils(m,p,t,c,N);


%Plotting
figure();
plot(x,y);
axis equal;


