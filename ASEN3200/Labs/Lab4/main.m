%% Clean Up
close all; clear; clc;

%% Import Data
fileName = "bennu.txt";

%Reading in data
[facets, vertices] = read_obj(fileName);

%% Analysis
%Plot the object

figure();
set(0, 'defaulttextinterpreter', 'latex');
patch('Faces', facets, 'Vertices', vertices, 'FaceColor', 'red', 'EdgeColor', 'black', 'linewidth', 0.1);
view(3);

xlabel('X Coordinate');
ylabel('Y Coordinate');
zlabel('Z Coordinate');
title('Bennu');


X0 = [0.4; 0.4; 0.4; -0.02; -0.02; 0];
t0 = 0;
tf = 100;
A = 5;
m = 5;
[Xout, OEout] = propagate_spacecraft(X0, t0, tf, A, m);




