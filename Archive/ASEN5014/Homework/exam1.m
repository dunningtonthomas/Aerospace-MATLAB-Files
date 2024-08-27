%% Clean
close all; clear; clc;


%% Problem 1
A = [0,1,0,0;-2,0,1,0;-3,0,0,1;-4,0,0,0];
B = [0;0;5;6];
C = [1,0,0,0];
D = 0;

sys = ss(A,B,C,D);

tftest = tf(sys);
