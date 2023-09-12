%% Clean Up
close all; clear; clc;

%% Problem 1
cl0 = 0.75;
M = 0.6;

cl = cl0 / sqrt(1 - M^2);


%% Problem 2
Cpr = -0.41;
cp0 = -0.41;
M_inf_g = 0.5;

[M_cr ]=PGlimit(cp0,M_inf_g);

%% Problem 3
M = 2.6;

clFP = @(alpha)(4*alpha / sqrt(M^2 - 1));
cdFP = @(alpha)(4*alpha^2 / sqrt(M^2 - 1));

cl_1 = clFP(5*pi/180);
cd_1 = cdFP(5*pi/180);

cl_2 = clFP(15*pi/180);
cd_2 = cdFP(15*pi/180);

cl_3 = clFP(30*pi/180);
cd_3 = cdFP(30*pi/180);



%% Problem 5
M = 3;
alpha = 15 * pi / 180;
epsilon = 10 * pi / 180;

cl = 4*alpha / sqrt(M^2 - 1);
cd = 4*epsilon^2 / sqrt(M^2 - 1) + 4*alpha^2 / sqrt(M^2 - 1);





