%% Clean
close all; clear; clc;


%% Problem 1
B = [1,2,3;2,1,0;9,2,-1];
G = B'*B;
x = det(G);