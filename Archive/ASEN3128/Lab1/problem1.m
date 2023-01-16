% Thomas Dunnington, Kate, Eric
% ASEN 3128
% main.m
% Created 8/24/2022
%% Clean up
close all; clear; clc

%% Main
initialState = [1;4;0];

func = @(t, x)odeFunc(t, x);

[time, Vec] = ode45(func, [0 0.16], initialState);


%% Plotting
figure();
subplot(3,1,1)
plot(time, Vec(:,1));
hold on

subplot(3,1,2)
plot(time, Vec(:,2));

subplot(3,1,3)
plot(time, Vec(:,3));


%% Functions

function [changeVec] = odeFunc(t, initialVec)
    changeVec = zeros(3,1);
    x = initialVec(1);
    y = initialVec(2);
    z = initialVec(3);
    
    changeVec(1) = x + 2*y + z;
    changeVec(2) = x - 5*z;
    changeVec(3) = x*y - y^2 + 3*z^3;      
end