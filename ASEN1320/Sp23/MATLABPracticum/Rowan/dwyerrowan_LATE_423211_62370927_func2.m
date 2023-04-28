function outputdy = func2(t, y, a, b)
outputdy= a.*(exp(-t).*sin(t)-y)+b.*cos(t);