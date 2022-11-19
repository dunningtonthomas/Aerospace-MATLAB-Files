function [dydt] = func2(t,y)

%Defined variables within function, see note in prob2
a = 9.9;
b = 1.25;

%Wrote equation as provided
dydt = a * sin(y*t) + b*y;
end