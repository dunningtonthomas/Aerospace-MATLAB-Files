%% Clean
close all; clear; clc;


%% Problem 1
A = [4,-2,0;1,2,0;0,0,6];

[vecs, vals] = eig(A);

A1 = A - 6*eye(3);
A1aug = [A1 zeros(3,1)];


A2 = A - (3+1i)*eye(3);
A2aug = [A2 zeros(3,1)];

A3 = A - (3-1i)*eye(3);


vtest = [1 + 1i; 1; 0];
res = A * vtest;