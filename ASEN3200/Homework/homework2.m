%% Clean Up
clear; close all; clc;

%% Problem 1



inertMatrix = 10*f(1,1,1) + 10*f(-1,-1,-1) + 8*f(4,-4,4) + 8*f(-2,2,-2) + 12*f(3,-3,-3) + 12*f(-3,3,3);



function outMat = f(r1, r2, r3)
    outMat = [r2^2 + r3^2, -r1*r2, -r1*r3; -r1*r2, r1^2 + r3^2, -r2*r3; -r1*r3, -r2*r3, r1^2 + r2^2];
    
end