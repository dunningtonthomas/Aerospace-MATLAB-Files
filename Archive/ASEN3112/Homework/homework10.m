%% Clean Up
clear; close all; clc;

%% Problem 2
mat1 = [1/sqrt(3), 1/sqrt(3); -2/sqrt(6), 1/sqrt(6)];
mat2 = [7, -1; -1, 13];
mat3 = mat1';

x = mat1*mat2*mat3;

