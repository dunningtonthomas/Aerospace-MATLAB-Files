function [tg1,tg2] = quadratic(a,b,c)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
tg1 = (-b + sqrt(b.^2-4.*a.*c))/(2.*a);         %quadratic equation
tg2 = (-b - sqrt(b.^2-4.*a.*c))/(2.*a);



end