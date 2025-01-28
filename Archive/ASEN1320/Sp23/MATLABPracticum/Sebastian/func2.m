function [dydt] = func2(t,y,a,b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dydt= a*(exp(-t).*sin(t)-y)+(b.*cos(t));
end

