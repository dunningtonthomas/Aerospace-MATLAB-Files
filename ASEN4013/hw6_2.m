%% Clean up
close all; clear; clc;

%% Problem 11.20
g = 1.3;
gc = 32.174;
R = 53.34;
mdot = 150;
Tt8 = 3600;
Pt8 = 25;
CD = 0.98;

MFP = (1 + (g-1)/2)^(-1*(g+1)/(2*(g-1)))*sqrt(gc*g/R);

A8 = mdot * sqrt(Tt8) / (Pt8 * CD * MFP);
A9 = 1.8*A8;

Astar = 1/0.98 * 1.8;
[Msup, Msub] = AoverAstar(g,Astar);

%Temperature at the exit
[p0op,t0ot,rho0orho] =isentropic(Msup);
T9i = Tt8 / t0ot;
P9i = Pt8 / p0op;

V9i = Msup * sqrt(g*R*gc*T9i);
mdoti = mdot / 0.98;


