function [dydt]=func2(a,b,t,y)
dydt = a*sin(y*t)+b*y;
end