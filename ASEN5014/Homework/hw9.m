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



%% Functions
function out = controllMat(A,B)
    [n,~] = size(B);    
    out = B;
    for i = 1:n-1
        out = [out A^i*B];
    end
end