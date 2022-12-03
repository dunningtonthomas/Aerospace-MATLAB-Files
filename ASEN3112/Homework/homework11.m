%% Clean Up
clear; close all; clc;

%% Problem 3

Pcr = @(d,L)(pi^2*200*10^9*((pi/4)*(d^.4 - (d - 10/1000).^4)) ./ L.^2);

Pyield = @(d)(300*10^6 * pi*(d.^2 - (d - 10/1000).^2));


