function [dydt] = func2(t, y, a, b) %initializing function with 4 inputs and the differential output

dydt = a*sin(y*t) + b*y; %differential equation

end

