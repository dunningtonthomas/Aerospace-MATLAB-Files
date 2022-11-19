function [dydt] = func2(t,y,a,b) %creates a function func2 which outputs dydt and takes in t,y,a, and b

    dydt = a*sin(y*t)+b*y; %writes an equation for dydt which calls t,y,a, and b

end %ends the function

