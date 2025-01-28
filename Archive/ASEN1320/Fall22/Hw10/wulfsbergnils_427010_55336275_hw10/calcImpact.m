function [tg] = calcImpact(t,y,v,f,g)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
a = -0.5*g;                             %initializing abc
b = t*g + v;
c = -0.5*(t^2)*g - v*t + y;


[tg1,tg2] = f(a,b,c);                   %calling quadratic with abc

tg = tg2;                       %outputting tg
end