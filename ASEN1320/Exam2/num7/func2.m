function [dy] = func2(t, y, a, b)
% Function for ode45 

% Calculate dy
dy = a * sin(y * t) + b*y;

end