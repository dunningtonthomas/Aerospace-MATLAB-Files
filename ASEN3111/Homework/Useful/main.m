%% Clean Up
close all; clear; clc;

%% Calculating shock
u1 = 680;
P1 = 101325;
gamma = 1.4;
R = 287;
T = 288;

a1 = sqrt(gamma*R*T);
M1 = u1 / a1;

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01] = shock_calc(M1);


