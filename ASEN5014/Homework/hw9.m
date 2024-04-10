%% Clean
close all; clear; clc;


%% Problem 1
A1 = [0,1,0; 0,0,1; 0,0,0];
B1 = [0;0;1];
C1 = controllMat(A1,B1);

A2 = [3,3,6;1,1,2;2,2,4];
B2 = [0;0;1];
C2 = controllMat(A2,B2);

A3 = [1,0,0;0,1,0;0,0,3];
B3 = [2;2;-1];
C3 = controllMat(A3,B3);

A4 = [3,-3,7; 1, 4, 2; 0, 5, 4];
B4 = [0, 1; 0, 0; 1, 0];
C4 = controllMat(A4,B4);


%% Problem 3
A = [1, -2; 0, -8];
B1 = [1; 4.5];
B2 = [9; 2];

C1 = controllMat(A,B1);
C2 = controllMat(A,B2);


%% Problem 4
A = [-2, -3.5, -2; 1, 0, 0; 0, 1, 0];
B = [4;0;0];
C = [0, 1, 1];
D = 0;

poles = [-0.5, -1 + 3*1j, -1 - 3*1j];
K = place(A,B,poles);

[testV, testE] = eig(A - B*K);




%% Problem 5
A = [12, -14, 10, -26, 8; 0, 10, 4, -8, -4; 0, -8, 22, -2, 8; 0, 0, 0, 24, 0; 0, -16, 8, -22, 22];
B = [4;2;2;0;1];
C = [3,3,-3,6,0; 6,4,4,-8,-10];
D = [0;0];

Cmat = controllMat(A,B);
[eigVec, eigVal] = eig(A);
T = eigVec;
Lambda = inv(T)*A*T;
Btild = inv(T)*B;

Ctild = controllMat(Lambda, Btild);
Cprime = C*T;


%% Functions
function out = controllMat(A,B)
    [n,~] = size(B);    
    out = B;
    for i = 1:n-1
        out = [out A^i*B];
    end
end