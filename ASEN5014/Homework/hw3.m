%% Clean up
close all; clear; clc;

%% Problem 1
B = [1, 1; 2, 3];
R = inv(B' * B) * B';