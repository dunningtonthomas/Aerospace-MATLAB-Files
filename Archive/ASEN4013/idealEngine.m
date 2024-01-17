%% Clean Up
close all; clear; clc;


%% Ideal Engine Analysis
%Givens
M0 = 3;
g = 1.4;
R = 287;
Cp = 1.004;
tc = 4;
hpr = 42000;

%Burner enthalpy or temperature
Tt4 = 2000;
T0 = 300; %From static conditions

%Ram/total ratios
tr = 1 + (g-1)/2 * M0^2;
pir = (1 + (g-1)/2 * M0^2)^(g/(g-1));

%Burner exit total enthalpy to ambient enthalpy
tlambda = Tt4/T0;

%Turbine temperature ratio
tt = 1 - tr/tlambda * (tc - 1);

%Speed of sound
a0 = sqrt(g*R*T0);

%Specific thrust
gc = 1;
Fm0 = a0 / gc * (sqrt(2/(g-1) * tlambda/(tr*tc) * (tr*tc*tt - 1)) - M0);

%Fuel to oxidizer ratio
f = Cp*T0/hpr * (tlambda - tr*tc);

%Thrust specific fuel consumption
S = f / Fm0;



