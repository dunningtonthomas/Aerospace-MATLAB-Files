%% Clean Up
close all; clear; clc;

%% Calculating shock
rho1 = 1.22586;
p1 = 101325;
M1 = 2.6;
T1 = 288;
p01 = 2.02184e6;

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01] = shock_calc(M1);


%% Problem 9.5
theta = 22.2 * pi / 180; 
M1 = 2.5;
p1 = 101325;
T1 = 300;
beta = BTMeq( theta,M1 );

Mn1 = M1 * sin(beta);

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01] = shock_calc(Mn1);


%% Problem 9.8
theta = 25.3 * pi / 180;
M1 = 4;
p1 = 1;
beta = BTMeq( theta,M1 );

Mn1 = M1 * sin(beta);

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01] = shock_calc(Mn1);

M2 = M2n / sin(beta - theta);

[M3n,p3op2,rho3orho2,t3ot2,deltasoR,p03op02] = shock_calc(M2);



%Second part
M2 = 2.1876;
theta = 20 * pi / 180;
beta = BTMeq( theta,M2 );

Mn2 = M2 * sin(beta);

[M3n,p3op2,rho3orho2,t3ot2,deltasoR,p03op02] = shock_calc(Mn2);


M3 = M3n / sin(beta - theta);

[M3n,p4op3,rho3orho2,t3ot2,deltasoR,p03op02] = shock_calc(M3);


%% Problem 9.9
M1 = 3.2;
theta = 18.2 * pi / 180;
beta = BTMeq( theta,M1 );

Mn1 = M1 * sin(beta);

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01] = shock_calc(Mn1);

M2 = M2n / sin(beta - theta);

beta = BTMeq( theta,M2 );
phi = beta - theta;

Mn2 = M2 * sin(beta);

[M3n,p3op2,rho3orho2,t3ot2,deltasoR,p03op02] = shock_calc(Mn2);

M3 = M3n / sin(beta - theta);


%% Problem 9.13
M1 = 2.6;
nu1 = NuFromM(M1);

theta = 5 * pi / 180;
beta = BTMeq( theta,M1 );

Mn1 = M1 * sin(beta);

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01] = shock_calc(Mn1);


%% Problem 9.14
M1 = 3;
nu1 = NuFromM(M1);

theta = 25 * pi / 180;
beta = BTMeq( theta,M1 );
Mn1 = M1 * sin(beta);

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01] = shock_calc(Mn1);

%% Problem 10.7
areaRatio = 1.616;
Me3 = nozzle_area(areaRatio);

[ p0op,t0ot,rho0orho ] =isentropic(Me3);

Pe = 1 / p0op;

[MeReal] = isentropicFindM(1.4,1/0.947);
[Arat] = AratFindA(1.4,MeReal);

AtOAs = 1/ areaRatio * Arat;

[M_sub M_sup] = nozzle(AtOAs);

[ p0op,t0ot,rho0orho ] =isentropic(M_sub);

Pt = 1 / p0op;

%% Problem 10.9
AR = 1.53;

[M3_sub, M3_sup] = nozzle(AR);

[ p0op,t0ot,rho0orho ] =isentropic( M3_sub );

Pe3 = 1 / p0op;

[Me_1] = isentropicFindM(1.4,1 / 0.94);

[Me_2] = isentropicFindM(1.4,1 / 0.886);
[Me_3] = isentropicFindM(1.4,1 / 0.75);


[ p0op,t0ot,rho0orho ] =isentropic( M3_sup );

Pe6 = 1 / p0op;







