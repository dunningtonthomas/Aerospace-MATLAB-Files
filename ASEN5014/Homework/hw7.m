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


%% Problem 2
A = [-2,1,0;0,-4,0;2,2,1];
B = [1,0;0,1;1,1];


[vec, vals] = eig(A);
T = vec;

Bp = inv(T)*B;

x0 = [1;5;0];
alpha0 = inv(T)*x0;

uVec = Bp * [2;3];





%% Problem 4
A = [0,1,0,0,0,0; 0,0,1,0,0,0;0,0,0,1,0,0;0,0,0,0,1,0;0,0,0,0,0,1;0,0,-27,-54,-36,-10];
B = [0;0;0;0;0;1];
C = [1;0;0;0;0;0]';
D = [0];

sys = ss(A,B,C,D);


[vecs, vals] = eig(A);
vecSimp = [real(vecs(:,1)) real(vecs(:,3)) real(vecs(:,6))];



L1 = null(A);
L2 = null(A + 3*eye(6));
L3 = null(A + eye(6));


A1_1 = (A)^2;
A1_1Aug = [A1_1 zeros(6,1)];

w1 = [0;1;0;0;0;0];

A2_1 = (A + 3*eye(6))^2;
null2 = null(A2_1);

A2_2 = (A + 3*eye(6))^3;
null3 = null(A2_2);


Atest = [null3 vecSimp(:,2)];






