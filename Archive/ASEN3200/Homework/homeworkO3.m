%% Clean up
close all; clear; clc;

%% Problem 1
r = [2500; 16000; 4000];
v = [-3; -1; 5];
mu = 398600;

h = cross(r, v);
n = cross([0;0;1], h);
e = cross(v, h) / mu - r / norm(r);
eMag = norm(e);

E = 0.5*norm(v)^2 - mu/norm(r);
a = -mu / (2*E);

i = acosd(h(3) / norm(h));
OMEGA = acosd(n(1) / norm(n));
omega = acosd(dot(n,e) / (norm(n) * norm(e)));
theta = 360 - acosd(dot(e,r) / (norm(e)*norm(r)));


%% Problem 2
r = [-6000; -1000; -5000];
e = [0.4; 0.5; 0.6];

theta = 180 + acosd(dot(e,r) / (norm(e) * norm(r)));


%% Problem 3
mu = 398600;
rp = 6378 + 300;
e = 1.5;
a = rp / (1 - e);

E = -mu / (2*a);
v = sqrt(2*(E + mu/rp));

rotMat = @(O, i, w)([cos(-O), sin(-O), 0; -sin(-O), cos(-O), 0; 0, 0, 1] * [1, 0, 0; 0, cos(-i), sin(-i); 0, -sin(-i), cos(-i)] * [cos(-w), sin(-w), 0; -sin(-w), cos(-w), 0; 0, 0, 1]);

rxyz = rotMat(130 * pi/180, 35 * pi/180, 115 * pi/180) * [6678; 0; 0];

vxyz = rotMat(130 * pi/180, 35 * pi/180, 115 * pi/180) * [0; v; 0];



%% Problem 4
mu = 398600;
rp = 6378 + 200;
e = 1.2;
a = rp / (1 - e);

E = -mu / (2*a);
v = sqrt(2*(E + mu/rp));

rotMat = @(O, i, w)([cos(-O), sin(-O), 0; -sin(-O), cos(-O), 0; 0, 0, 1] * [1, 0, 0; 0, cos(-i), sin(-i); 0, -sin(-i), cos(-i)] * [cos(-w), sin(-w), 0; -sin(-w), cos(-w), 0; 0, 0, 1]);

rxyz = rotMat(75 * pi/180, 50 * pi/180, 80 * pi/180) * [rp; 0; 0];

vxyz = rotMat(75 * pi/180, 50 * pi/180, 80 * pi/180) * [0; v; 0];

%% Problem 5
r = [6559.9; 3660.8; -10282];
v = [1.5525; -0.1746; 0.5038];
mu = 32930;

h = cross(r, v);
n = cross([0;0;1], h);
e = cross(v, h) / mu - r / norm(r);
eMag = norm(e);

E = 0.5*norm(v)^2 - mu/norm(r);
a = -mu / (2*E);

i = acosd(h(3) / norm(h));
OMEGA = acosd(n(1) / norm(n));
omega = 360 - acosd(dot(n,e) / (norm(n) * norm(e)));
theta = acosd(dot(e,r) / (norm(e)*norm(r)));

rotMat = @(O, i, w)([cos(-O), sin(-O), 0; -sin(-O), cos(-O), 0; 0, 0, 1] * [1, 0, 0; 0, cos(-i), sin(-i); 0, -sin(-i), cos(-i)] * [cos(-w), sin(-w), 0; -sin(-w), cos(-w), 0; 0, 0, 1]);

vpqw = rotMat(-omega * pi/180, -i * pi/180, -OMEGA * pi/180) * v;

%LVLH
zComp = dot(v, -1*r) / norm(r);
vMag = norm(v);
xComp = sqrt(vMag^2 - zComp^2);

%Flight path angle
g = atand(eMag * sind(theta) / (1 + eMag*cosd(theta)));


%Time passed
T = 2*pi * sqrt(a^3 / mu);
n = 2*pi / T;
E0 = 2*atan(sqrt((1-eMag)/(1+eMag)) * tan(theta/2 * pi/180));
t0 = 1 / n * (E0 - eMag*sin(E0));

t1 = t0 + 3*60*60;

func = @(E)(E - eMag*sin(E) - n*(t1));
tol = 1e-2;

E1 = rootSolve(func, 0, 2*pi, tol);
theta1 = 2*atan(sqrt((1+eMag)/(1-eMag)) * tan(E1/2));

p = a*(1 - eMag^2);


rpqw1 = [p * cos(theta1) / (1 + eMag*cos(theta1)); p*sin(theta1) / (1 + eMag*cos(theta1)); 0];
vpqw1 = [-sqrt(mu / p) * sin(theta1); sqrt(mu / p) *(eMag + cos(theta1)); 0];



