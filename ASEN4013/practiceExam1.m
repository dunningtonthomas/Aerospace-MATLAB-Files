%% Clean Up
close all; clear; clc;


%% Problem 1
M1 = 1.4;
P1 = 4;
T0 = -55 + 460;

[ p0op,t0ot,rho0orho ] =isentropic( M1 );
Tt0 = t0ot*T0;



[ M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01 ] = shock_calc( M1 );

P2 = p2op1*P1;


[ p0op,t0ot,rho0orho ] =isentropic( M2n );

Pt2 = p0op*P2;



% Solve for area ratio
gamma = 1.4;
A1Rat = Astar(M2n, gamma);
A2Rat = Astar(0.3, gamma);

A2A1 = A2Rat / A1Rat;



