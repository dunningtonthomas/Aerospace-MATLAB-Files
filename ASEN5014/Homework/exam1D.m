%% Clean
close all; clear; clc;


%% Problem 2
A = [1,0,1;2,7,2;-1,2,-3;1,2,3;5,5,-1];
G = A'*A;

leftNull = null(A');


