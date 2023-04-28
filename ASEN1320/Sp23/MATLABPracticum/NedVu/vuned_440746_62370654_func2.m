function [dy] = func2(t,y,a,b)
dy = a .* (exp(-t) .* sin(t) -y ) +b*cos(t);
end

