function [xt,yt] = calcTrajectory(t0,tg,x,y,vx,vy,g)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
T = linspace(t0,tg,1000);                       %creating spaced vector

xt = x + vx.*(T-t0);                            %equation 1
yt = y + vy.*(T-t0) - 0.5.*g.*(T-t0).^2;        %equation 2
end