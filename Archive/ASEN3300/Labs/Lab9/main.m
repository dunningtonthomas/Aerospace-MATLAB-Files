%% Clean Up
close all; clear; clc;

%% Prelab

%Truth table
fprintf('Truth Table: \n');
fprintf('A \t O \t F \t S\n');
fprintf('%d \t %d \t %d \t %d\n', 0, 0, 0, sirenFunc(0,0,0));
fprintf('%d \t %d \t %d \t %d\n', 0, 0, 1, sirenFunc(0,0,1));
fprintf('%d \t %d \t %d \t %d\n', 0, 1, 0, sirenFunc(0,1,0));
fprintf('%d \t %d \t %d \t %d\n', 0, 1, 1, sirenFunc(0,1,1));
fprintf('%d \t %d \t %d \t %d\n', 1, 0, 0, sirenFunc(1,0,0));
fprintf('%d \t %d \t %d \t %d\n', 1, 0, 1, sirenFunc(1,0,1));
fprintf('%d \t %d \t %d \t %d\n', 1, 1, 0, sirenFunc(1,1,0));
fprintf('%d \t %d \t %d \t %d\n', 1, 1, 1, sirenFunc(1,1,1));



function S = sirenFunc(A, O, F)
%Outputs the boolean operations to activate the siren S
%F is fire, O is oxygen, A is if astronauts are present

S = F || (A && O);

end