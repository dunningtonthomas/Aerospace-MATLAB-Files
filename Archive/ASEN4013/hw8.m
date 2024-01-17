%% Clean up
close all; clear; clc;


%% Problem 1
R = 0.375;
g = 1.26;
Pe = 1;
Pc = 100;
Tc = 4000;
g0 = 9.81;
At = 0.1;

cp = R / (1 - 1/g);

Te = (Pe/Pc)^((g-1)/g) * Tc;

Ve = sqrt(2*cp*1000*(Tc-Te));


Isp = Ve / g0;


G = sqrt(g / (((g+1) / 2)^((g+1)/(g-1))));

mdot = Pc * 101325 * At * G/sqrt(R*1000*Tc);

Fi = mdot*Ve;


n = 1 / log(6) * log(0.71/0.2);
a = 0.2 / 500^n;

r1 = a * 1000^n;
r2 = a * 2000^n;
