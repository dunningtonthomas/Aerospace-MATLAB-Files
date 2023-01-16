%% Clean up
clear; close all; clc;

%% Impulse response to eigenvector

eigVec = [-0.5 + 0.866i; -0.5 - 0.866i]; 

irfplot(eigVec);