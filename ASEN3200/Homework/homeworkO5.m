%% Clean
close all; clear; clc;

%% Problem 1
R = 6378;
mu = 398600;

%Find initial velocity
v1 = sqrt(mu / (R+300));

%Transfer orbit
ra = 3000 + R;
rp = 300 + R;
a = 0.5*(ra + rp);

v2 = sqrt(2*mu / rp - mu / a);

delV1 = v2 - v1;

vT3 = sqrt(2*mu / ra - mu / a);
v3 = sqrt(mu / ra);
delV2 = v3 - vT3;

delV = abs(delV1) + abs(delV2);

Tt = 2*pi*sqrt(a^3 / mu);
t = 1/2 * Tt;

%% Problem 2
mu = 1.327e11;
Re = 1.496e8;
Rm = 2.279e8;

a = 0.5*(Re + Rm);
Tt = 2*pi*sqrt(a^3 / mu);
time = 0.5*Tt;
daysTime = time / 3600 / 24;

Tm = 2*pi *sqrt(Rm^3 / mu);
n = 2*pi / Tm;
delAlpha = n * time;
alpha = pi - delAlpha;
alphaDeg = alpha * 180 / pi;


%% Problem 3
mu = 398600;
R = 350 + 6378;
thetaS = 600 / R;

thetaA = 2*pi - thetaS;
T = 2*pi*sqrt(R^3 / mu);
n = 2*pi / T;
Ta = thetaA / n;
TaMin = Ta / 60;


thetaB = 2*pi + thetaS;
Tb = thetaB / n;
Tbmin = Tb / 60;

vcirc = sqrt(mu / R);

aA = ((Ta / (2*pi))^2 * mu)^(1/3);
vA = sqrt(2*mu / R - mu / aA);

delVA = (vA - vcirc) * 1000;


aB = ((Tb / (2*pi))^2 * mu)^(1/3);
vB = sqrt(2*mu / R - mu / aB);

delVB = (vB - vcirc) * 1000;


%% Problem 4
mu = 398600;
h = 60000;
e = 0.3;

a = h^2 / (mu * (1 - e^2));
ra = a*(1 + e);
va = sqrt(2*mu/ra - mu/a);
delV = 2*va*sind(45);

%% Problem 5

n = 2*pi / (90 * 60);
t = 15 * 60;
x0 = [1;0;0];
xdot0 = [0;10/1000;0];
phi_RR = [4 - 3*cos(n*t), 0, 0; 6*(sin(n*t)-n*t), 1, 0; 0, 0, cos(n*t)];
phi_RV = [1/n * sin(n*t), 2/n * (1 - cos(n*t)), 0; 2/n * (cos(n*t) - 1), 4/n *sin(n*t) - 3*t, 0; 0, 0, 1/n *sin(n*t)];
rVec =  phi_RR * x0 + phi_RV* xdot0;
dist = norm(rVec);

%% Problem 6
R = 6600;
mu = 398600;
T = 2*pi*sqrt(R^3 / mu);
n = 2*pi / T;
tf = 1/3 * T;
t = tf;

r0 = [1;1;1];


phi_RR = [4 - 3*cos(n*tf), 0, 0; 6*(sin(n*tf)-n*tf), 1, 0; 0, 0, cos(n*tf)];
phi_RV = [1/n * sin(n*tf), 2/n * (1 - cos(n*tf)), 0; 2/n * (cos(n*tf) - 1), 4/n *sin(n*tf) - 3*tf, 0; 0, 0, 1/n *sin(n*tf)];
phi_VR = [3*n*sin(n*t), 0, 0; 6*n*(cos(n*t) - 1), 0, 0; 0, 0, -n*sin(n*t)];
phi_VV = [cos(n*t), 2*sin(n*t), 0; -2*sin(n*t), 4*cos(n*t) - 3, 0; 0, 0, cos(n*t)];



v0P = -1000*inv(phi_RV) * phi_RR * r0;
v0pMag = norm(v0P);


phiTilde = phi_VR - phi_VV * inv(phi_RV) * phi_RR;
vfN = 1000.*(phiTilde * r0);
vfNmag = norm(vfN);

v0M = [0; 0; 5];
delV0 = v0P - v0M;
delVf = -vfN;

totalV = norm(delV0) + norm(delVf);

%% Problem 7
mu = 6.319e10;
R4 = 4.286e7;
R7 = 1.434e8;

vInit = sqrt(mu / R4);
vT0 = [0; vInit; 0] + [-1.5; 9; 0];
R4Vec = [R4; 0; 0];
vT0Mag = norm(vT0);

h = cross(R4Vec, vT0);
E = 0.5*vT0Mag^2 - mu / R4;
a = -mu / (2*E);

e = sqrt(1 + 2*norm(h)^2*E / mu^2);
eVec = cross(vT0, h) / mu - R4Vec / R4;
theta = 360 - acosd(dot(eVec, R4Vec) / (norm(eVec)*norm(R4Vec)));
gamma = atand(vT0(1) / vT0(2));
ra = a*(1 + e);

%% Problem 8
muS = 132712440018;
RE = 149.6e6;
RJ = 778.6e6;

aT = 0.5*(RE + RJ);
T = 2*pi*sqrt(a^3 / muS);
tof = 0.5*T;
tofDays = tof / 3600 / 24;

vDep = sqrt(2*muS / RE - muS/aT);
vAr = sqrt(2*muS / RJ - muS/aT);

vES = sqrt(muS / RE);
vInfE = vDep - vES;

vLEO = sqrt(398600 / (6378 + 180));

vPH = sqrt(2*(0.5*vInfE^2 + 398600/(6378 + 180)));
delV = vPH - vLEO;


vJS = sqrt(muS / RJ);

vInfJ = vAr - vJS;


muJ = 126686534;
vPHJ = sqrt(2*(0.5*vInfJ^2 + muJ/(286000)));

aJ = 286000 / (1 - 0.97);
vCJ = sqrt(2*muJ / 286000 - muJ / aJ);

delV2 = vPHJ - vCJ;

delVtot = delV + delV2;

