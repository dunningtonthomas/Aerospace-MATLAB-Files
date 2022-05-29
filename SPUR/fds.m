clear; close all; clc;

%% Main Script


randVar = linspace(1,100,1000);
randFunc = @(x)(5*x + sin(x));

randVar2 = randFunc(randVar);



%% Plotting 

figure();
plot(randVar, randVar2, 'linewidth', 2, 'color', 'r');
grid on;
hold on;