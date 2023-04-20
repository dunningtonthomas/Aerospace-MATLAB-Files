%% Clean Up
close all; clear; clc;

%% Problem 1
OmegaDotDes = 2*pi / (365.242189 * 24 * 3600);
J2 = 1.08263e-3;
R = 6378;

rp = 300 + R;
ra = 600 + R;

a = 0.5*(rp + ra);
e = (ra - rp) / (ra + rp);
mu = 398600;

i = acosd(OmegaDotDes / (-3/2 * sqrt(mu)*J2*R^2 / (1-e^2)^2 / a^(7/2)));

%% Problem 2
i = 45 * pi / 180;
omegaDot = 6 * pi / 180;
OmegaDot = omegaDot * cos(i) / (5/2 * sin(i)^2 - 2);


