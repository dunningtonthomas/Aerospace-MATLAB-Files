function [out] = func2(t, y, a, b)
    out = a.*(exp(-t).*sin(t)-y)+b.*cos(t);

end

