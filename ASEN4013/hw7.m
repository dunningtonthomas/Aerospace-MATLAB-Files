%% Clean Up
close all; clear; clc;


%% Problem 7.9
% Givens 
ec = 0.85;
et = 0.88;
pic = 9;
gc = 1.4;
gt = 1.3;
M0 = 0.8;
P0 = 29.92;
T0 = 229;
pid = 0.95;
cpc = 1.004;
cpt = 1.235;
nb = 0.96;
hpr = 42800;
nm = 0.98;
pib = 0.94;
pin = 0.98;

% Compressor exit values
tc = pic^((gc-1)/(gc*ec));

[p0op,t0ot,rho0orho] = isentropic(M0);
tr = t0ot;
pir = p0op;

Tt0 = t0ot * T0;
Tt2 = Tt0;
Pt0 = p0op * P0;

Pt2 = pid * Pt0;

Tt3 = tc * Tt2;
Pt3 = pic * Pt2;

Tt4 = 1780;

%Burner
ht3 = cpc*Tt3;
ht4 = cpt*Tt4;
Pt4 = pib * Pt3;

f = (ht4 - ht3)/(nb*hpr - ht4);

tlam = ht4 / (cpc * T0);

tt = 1 - tr / (nm *(1 + f)*tlam) * (tc - 1);
pit = tt^(gt / ((gt-1)*et));

Tt5 = tt * Tt4;
Pt5 = pit * Pt4;

Pt9P9 = 0.8*pir*pid*pic*pib*pit*pin;

M9 = sqrt(2/(gt-1) * (Pt9P9^((gt-1)/gt) - 1));

