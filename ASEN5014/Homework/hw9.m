%% Clean
close all; clear; clc;


%% Problem 1
A1 = [0,1,0; 0,0,1; 0,0,0];
B1 = [0;0;1];
C1 = controllMat(A1,B1);





%% Functions
function out = controllMat(A,B)
    [n,~] = size(B);    
    out = B;
    for i = 1:n-1
        out = [out A^i*B];
    end
end