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








