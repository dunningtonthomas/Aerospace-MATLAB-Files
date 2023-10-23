%% Clean Up
close all; clear; clc;


%% Problem 7.19
%Givens
M0 = 0.8;
T0 = 390;
P0P9 = 0.9;
P0P19 = 0.9;
gc = 1.4;
cpc = 0.24 * 778.16;
pid = 0.99;
ec = 0.9;
pic = 36;
hpr = 18400 * 778.16;
pib = 0.96;
nb = 0.99;
gt = 1.33;
cpt = 0.276 * 778.16;
et = 0.89;
nm = 0.98;
Tt4 = 3000;
pin = 0.99;
pifn = 0.99;
ef = 0.89;
pif = 1.65;
alpha = 10;
g_c = 32.174;


%Find the performance:
Rc = (gc - 1) / gc * cpc;
Rt = (gt - 1) / gt * cpt;
a0 = sqrt(gc*Rc*g_c*T0);

tr = 1 + (gc - 1)/2 * M0^2;
pir = tr^(gc/(gc-1));

tc = pic^((gc-1)/(gc*ec));
tf = pif^((gc-1)/(gc*ef));

tlam = cpt*Tt4 / (cpc*T0);

Tt0 = tr*T0;
Tt2 = Tt0;
Tt3 = tc * Tt2;

ht3 = cpc*Tt3;
ht4 = cpt*Tt4;

f = (ht4 - ht3) / (hpr * nb - ht4);

tt = 1 - 1 / (nm * (1 + f)) * tr / tlam * (tc - 1 + alpha*(tf - 1));
pit = tt^(gt/((gt-1)*et));

Pt9P0 = pir*pid*pic*pib*pit*pin;
Pt9P9 = P0P9*Pt9P0;

M9 = sqrt(2/(gt-1) * (Pt9P9^((gt-1)/gt) - 1));
[Pt9P9,Tt9T9,rho0orho] =isentropic(M9);

Pt9P0 = Pt9P9 / P0P9;

T9T0 = Tt4 * tt / T0 / ((Pt9P0)^((gt-1)/gt));

v9a0 = M9 * sqrt(gt*Rt / (gc * Rc) * T9T0);

Pt19P0 = pir*pid*pif*pifn;

Pt19P19 = P0P19 * pir * pid * pif * pifn;

T19T0 = tr*tf / (Pt19P19^((gc-1)/gc));

M19 = sqrt(2/(gc-1) * (Pt19P19^((gc-1)/gc) - 1));

v19a0 = M19*sqrt(T19T0);

Fm0_1 = 1 / (1 + alpha) * a0/g_c *((1 + f)*v9a0 - M0 + (1 + f)*Rt*T9T0 / (Rc*v9a0) *(1 - P0P9)/gc);
Fm0_2 = alpha/(1+alpha) * a0 / g_c *(v19a0 - M0 + T19T0 / v19a0 * (1 - P0P19)/gc);
Fm0 = Fm0_1 + Fm0_2;

S = 3600 * f / (1+alpha) / Fm0;

np = 2*M0*((1+f)*v9a0 + alpha*v19a0 - (1+alpha)*M0) / ((1+f)*v9a0^2 + alpha*v19a0^2 - (1+alpha)*M0^2);
nth = a0^2 * ((1+f)*v9a0^2 + alpha*v19a0^2 - (1+alpha)*M0^2) / (2*g_c*f*hpr);












