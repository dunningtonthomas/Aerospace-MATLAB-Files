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


%% Problem 4
r1 = [-105400; 157900; -152];
r2 = [-146100; 108100; -226.5];
r3 = [-165200; 42540; -267.3];
mu = 2.654e5;

r1M = norm(r1);
r2M = norm(r2);
r3M = norm(r3);

C12 = cross(r1, r2);

C23 = cross(r2, r3);

C31 = cross(r3, r1);


%Check for orthogonality
C31_1 = dot(C31 / norm(C31), r1 / r1M);


%N vec calculation
N = r1M*(C23) + r2M*(C31) + r3M*(C12);

D = C12 + C23 + C31;

S = r1.*(r2M - r3M) + r2.*(r3M - r1M) + r3.*(r1M - r2M);

%Velocity at r2
v2 = sqrt(mu ./ (norm(N)*norm(D))) .* (1/r2M * cross(D, r2) + S);

E = 0.5* norm(v2)^2 - mu / r2M;

a = -mu / (2*E);

h = cross(r2, v2);

eVec = cross(v2, h) / mu - r2 / r2M;
e = norm(eVec);

i = acosd(h(3) / norm(h));

T = 2*pi*sqrt(a^3 / mu);

%True anomoly
theta2 = 360 - acosd(dot(eVec, r2) / (e*r2M));
eDotV = dot(eVec, v2);

%Find argument of periapsis
n = cross([0; 0; 1], h);
omega = acos(dot(n, eVec) / (norm(n)*norm(eVec)));

thetaN = 360 - theta2;

E2  = 2*pi + 2*atan(sqrt((1 - e) / (1 + e)) * tand(theta2 / 2));

n = 2*pi / T;

t2 = 1 / n * (E2 - e*sin(E2));

delT = T - t2;
hours = delT / 3600;

