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



%% Problem 2
Qin = 85600;
mdot = 102;
Cp = 1;
Tt3 = 500;
M1 = 0.25;
g = 1.4;

Tt4 = Qin / (mdot * Cp) + Tt3;

Tt4 = 100 * Tt3 / (mdot) + Qin / (mdot*Cp);

%Total pressure ratio
Tt2oTt1 = Tt4 / Tt3;

%Root solve for mach
[mach2] = RayleighMach(Tt2oTt1, M1, g);

%Calculate star values at the end of heat addition
[PtoPtStar, TtoTtStar, ToTStar, PoPStar] = RayleighStar(mach2, g);

Pt4 = PtoPtStar * 1/1.218 * 250;

%Pressure loss
P3 = 250 * 0.9575;

%P4
[ P4oPt4,t0ot,rho0orho ] =isentropic( mach2 );
P4 = 1/P4oPt4 * Pt4;

PressureLoss = P3 - P4;



%% Problem 8
Tt9 = 527 + 273.15;
R = 287;

%Solve for mach unmber given pressure ratio
g = 1.4;
Pt9oP9 = 2;
M9 = sqrt((Pt9oP9^((g-1)/g) - 1)*2 / (g-1));

[ ~,Tt9oT9,~ ] =isentropic( M9 );

T9 = 1/Tt9oT9 * Tt9;

V9 = M9*sqrt(g*R * T9);

F = 0.3 * V9;
