function [dydt] = func2(t, y0, a, b)

    dydt = a*sin(y0*t) + b*y0;

end