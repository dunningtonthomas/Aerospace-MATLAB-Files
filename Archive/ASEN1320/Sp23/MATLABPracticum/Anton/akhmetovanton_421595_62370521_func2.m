function [dydt] = func2(t,y,a,b)
dydt = a*(exp(-t)*sin(t)-y) + b*cos(t);
end

