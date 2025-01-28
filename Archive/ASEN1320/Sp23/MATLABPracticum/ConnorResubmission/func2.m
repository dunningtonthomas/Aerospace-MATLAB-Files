function dydt = func2(t, y, a, b)
%FUNC2 Summary of this function goes here
%   Detailed explanation goes here
dydt = a*(exp(t*-1)*sin(t) - y) + b* cos(t);

end

