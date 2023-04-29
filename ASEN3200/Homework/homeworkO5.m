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



