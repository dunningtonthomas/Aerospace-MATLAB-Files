%% Clean up
clear; close all; clc;

%% Problem 3
a = 2.949e7 / 1000; %km
mu = 3.986e14 / 1000^3;
T = 14;
e = 0.661;
n = 2*pi / T;
t = 10;
func = @(E)(E - e*sin(E) - n*(t));
tol = 1e-2;

E = rootSolve(func, 0, 2*pi, tol);

r = a*(1 - e*cos(E));
v = sqrt(2*mu/r - mu/a);

%Find theta
theta = 2* atan(sqrt((1+e)/(1-e)) * tan(E/2));
theta = theta + 2*pi;

%Find h
h = sqrt(mu*a*(1-e^2));

%Vr
vr = mu / h * e * sin(theta);






