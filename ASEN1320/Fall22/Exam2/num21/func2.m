function [dydx] = func2(t,y,a,b)

dydx = a * sin(y * t) + b * y;

end