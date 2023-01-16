%declaring my function and setting dydt as my output and t,y,a, and b as my
%inputs
function [dydt] = funct2(t,y,a,b)

%wrting my dydt function
dydt = (a * sin(y * t)) + (b * y);
end