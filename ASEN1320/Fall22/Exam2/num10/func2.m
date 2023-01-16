function [dydt] = func2 (t, y, a, b)
a = 9.9; 
b =1.25; 
dydt = a*sin(y*t)+b*y;
end