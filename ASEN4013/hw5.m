%% Clean Up
close all; clear; clc;


%% Problem 5.13
M0 = 0.9;
Tt4 = 3000;

g = 1.4;
pic = 20;
pif = 2;
alpha = 5;
cp = 0.24 * 778.16;
hpr = 18400 * 778.16;
T0 = -69.7 + 459.7;
rho0 = 0.0189;
p0 = 2.73 * 144;
R = cp*(1 - 1/g);
gc = 32.174;
a0 = sqrt(g*R*T0*gc);

%Isentropic relations
tc = pic^((g-1)/g);
tf = pif^((g-1)/g);
tr = 1 + (g-1)/2 * M0^2;
tlam = Tt4 / T0;
tt = 1 - tr/tlam * (tc-1 + alpha*(tf - 1));

%Turbojet exit
v9oa0 = sqrt(2/(g-1) * (tlam - tr*(tc - 1 + alpha*(tf - 1)) - tlam/(tr*tc)));

%Turbofan exit
v19oa0 = sqrt(2 / (g-1) * (tr*tf - 1));

%Specific thrust
F0M0 = a0 / gc * (1 / (1 + alpha))*(sqrt(2/(g-1) * tlam/(tr*tc) * (tr*tc*tt - 1)) - M0 + alpha*(sqrt(2/(g-1) * (tr*tf - 1)) - M0));
F0M0_2 = a0/gc * (1/(1+alpha))*(v9oa0 - M0 + alpha*(v19oa0 - M0));


%Fuel to air
f = cp*T0/hpr * (tlam - tr*tc);

%Specific fuel consumption
s = f / ((1+alpha)*F0M0);
s = s * 3600;



%% Problem 6.7
g = 1.4;
T0 = 15 + 273;
delT = 50;
ef = 0.88;
ts = 1 + delT/T0;

pis = ts^((g*ef)/(g-1));




%% Problem 6.8
Pt25 = 54;
Pt2 = 14.969;
Pt3 = 167;
Pt4 = 158;
Pt5 = 36;
Pt6 = Pt5;
Pt7 = 31.9;
Tt25 = 330 + 459.7;
Tt2 = 518.7;
Tt3 = 660 + 459.7;
Tt4 = 1570 + 459.7;
Tt5 = 1013 + 459.7;
Tt6 = Tt5;
Tt7 = 2540 + 459.7;
gLow = 1.4;
gHigh = 1.39;
gTurb = 1.33;

picLow = Pt25 / Pt2;
picHigh = Pt3/Pt25;

tcLow = Tt25/Tt2;
tcHigh = Tt3/Tt25;

%Efficiencies
ncLow = (picLow^((gLow-1)/gLow) - 1)/ (tcLow - 1);
ecLow = 1/gLow * (log(picLow^(gLow-1)) / log(tcLow));

ncHigh = (picHigh^((gHigh-1)/gHigh) - 1)/ (tcHigh - 1);
ecHigh = 1/gHigh * (log(picHigh^(gHigh-1)) / log(tcHigh));


%Turbine
tt = Tt5/Tt4;
pit = Pt5/Pt4;


%Effiency:
nt = (1 - tt) / (1 - pit^((gTurb - 1)/gTurb));
et = 1/(gTurb-1) * (log(tt^gTurb) / log(pit));

%Burner
pib = Pt4 / Pt3;
tb = Tt4/Tt3;

%Afterburner
piAB = Pt7/Pt6;
tAB = Tt7/Tt6;


%% Problem 6.13
Pt13 = 47.5;
Pt2 = 14.7;
Tt13 = 307 + 459.7;
Tt2 = 59 + 459.7;
gf = 1.4;
gt = 1.3;

pif = Pt13/Pt2;
tf = Tt13/Tt2;

ef = 1/gf * (log(pif^(gf-1)) / log(tf));

%High pressure compressor
Pt3 = 387.7;
Tt3 = 1459.7;
Pt25 = 47.5;
Tt25 = 307 + 459.7;

pihc = Pt3/Pt25;
thc = Tt3/Tt25;

ec = 1/gf * (log(pihc^(gf-1)) / log(thc));


%Turbine
Pt5 = 44.8;
Pt4 = 350.5;
Tt5 = 1362+459.7;
Tt4 = 2739;

pit = Pt5/Pt4;
tt = Tt5/Tt4;

et = 1/(gt-1) * (log(tt^gt) / log(pit));

%Power
m0 = 228;
alpha = 0.63;

mc = m0/(1+alpha);
mb = alpha*mc;

cp = 0.24*778.16;

wc = mc*cp*(Tt3 - Tt25);
wf = mb*cp*(Tt13 - Tt2);

wcB = wc/778.16;
wfB = wf/778.16;

wt = mc*cp*(Tt5 - Tt4)/778.16;
