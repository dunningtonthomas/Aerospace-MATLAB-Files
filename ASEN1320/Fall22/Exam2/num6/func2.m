function [y] = func2(t,y,a,b)

a = 9.9;
b = 1.25;

tspan = [0 3];
y0 = 1;

y = a*sin(y*t) + b*y;
