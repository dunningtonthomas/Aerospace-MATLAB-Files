%% Clean up
close all; clear; clc;


%% 1
fracSpill = (1.3904 - 1.213)/1.3904;


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

%Solve for mach
Pt8P0 = 25/3;
Ms = sqrt(2/(g-1)*(Pt8P0^((g-1)/g) - 1));

[p0op,t0ot,rho0orho] =isentropic(Ms);

Vs = Ms*sqrt(g*R*gc/t0ot*Tt8);

Fideal = mdoti*Vs/gc;

[M9, Msub] = AoverAstar(g,1.8);

[p0op,t0ot,rho0orho] =isentropic(M9);

T9 = Tt8/t0ot;
P9 = Pt8 * 0.98 / p0op;

V9 = M9*sqrt(g*R*gc*T9);

Factual = mdot*V9/gc + (P9 - 3)*A9;
Cfg = Factual/Fideal;
Cv = V9 / Vs;
