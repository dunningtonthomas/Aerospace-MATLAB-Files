clear;
clc;
close all;

%% ODE function
% function should have the format (t,z)
% the initial value needs to be column vector

t = 0:0.1:10;
init = [0];


[x,y] = ode45(@odeFun1,t,init);
% func1 = @odeFun1
% [x,y] = ode45(@func1,t,init);  % using a function handle variable
plot(x,y)