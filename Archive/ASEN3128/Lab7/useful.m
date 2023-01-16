%% Clean Up
clear; close all; clc;

%% 
%Use equation 2.1,2 for the derivative derivation
%Need the rlocus command in MATLAB
rlocus(ss(Alat, Blat(:,2), [0 0 -1 0 0 0], 0));
drawnow;

%Use the ss command to create the state space for the input to rlocus
%in ss it is only for one control, delta r
%in ss C is not the identity matrix, we only want the r output so we
%specify that with [0 0 -1 0 0 0]
%
