%% Clean up
clear; close all; clc;

%% Problem 3
a = 2.949e7 / 1000; %km
mu = 3.986e14 / 1000^3;
T = 14;
e = 0.661;
n = 2*pi / T;
t = 10;
func = @(E)(E - e*sin(E) - n*(t));
tol = 1e-2;

E1 = rootSolve(func, 0, 2*pi, tol);

r = a*(1 - e*cos(E1));
v = sqrt(2*mu/r - mu/a);

%Find theta
theta = 2* atan(sqrt((1+e)/(1-e)) * tan(E1/2));
theta = theta + 2*pi;

%Find h
h = sqrt(mu*a*(1-e^2));

%Vr
vr = mu / h * e * sin(theta);


%% Problem 4
ra = 16000;
rp = 7500;
e = (ra - rp) / (ra + rp);
a = ra / (1 + e);
mu = 398600;
T = 2*pi*sqrt(a^3/mu);
n = 2*pi / T;
theta = 80 * pi / 180;
E1 = 2* atan(sqrt((1-e)/(1+e))*tan(theta/2));

ttp = 1 / n * (E1 - e*sin(E1));
ttp2 = ttp + 40*60;

func = @(E)(E - e*sin(E) - n*(ttp2));
tol = 1e-2;

E2 = rootSolve(func, 0, 2*pi, tol);

theta2 = 2*atan(sqrt((1+e)/(1-e)) * tan(E2/2));


%% Problem 5
T = 3.663 * 3600;
p = 5113;
mu = 42701;

rTarg = 4000 + 3581;
a = (mu*(T/(2*pi))^2)^(1/3);
e = sqrt(1 - p/a);
theta = acos(1/e * (p/rTarg -1 ));
thetaDeg = theta * 180 / pi;
theta2Deg = (180 - thetaDeg) + 180;
theta2 = theta2Deg * pi / 180;

E1 = 2* atan(sqrt((1-e)/(1+e))*tan((pi)/2));
E2 = 2* atan(sqrt((1-e)/(1+e))*tan(theta2/2)) + 2*pi;
% E2 = 3.346;


n = 2*pi / T;

t2 = 1 / n * (E2 - e*sin(E2));
delT = (t2 - (T/2)) / 60;



