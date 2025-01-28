%% Clean
close all; clear; clc;

%% Constants
Rm = 19.2;                  % ohm
Lm = 1.9 / 1000;            % H
Kt = 40.1 / 1000;           % Nm/A
Jm = 12.5 / (1000 * 100^2); % kgm^2
Kb = 1/238 * 1/(2*pi) * 60; % V/(rad/s)
N = 10 * 120 / 36;

% NEED TO FIND THESE
Ks = 1;
Jl = 0.0001;
Jeq = Jl + N^2 * Jm;

% Transfer function thetaL Vp
num_thetaVp = [-1];
den_thetaVP = [Jeq*Lm / (Kt*N), Jeq*Rm / (Kt*N), Kb*N, 0];
