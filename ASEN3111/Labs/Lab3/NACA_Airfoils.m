function [x,y] = NACA_Airfoils(m,p,t,c,N)
%NACA_AIRFOILS 
%Summary: This function takes in characteristics of a NACA airfoil and
%calculates N
%
%INPUTS: 
%   m = maximum camber
%   p = location of maximum camber
%   t = maximum thickness
%   c = chord length
%   N = number of employed panels
%OUTPUTS: 
%   x = vector of x locations of the boundary
%   y = vector of y locations of the boundary
%The x and y outputs start at the trailing edge of the airfoil and go
%counterclockwise

%Define x locations from 0 to c
%Divide by 2 since there are panels on top and bottom so we want half
%points on top and half on bottom
xLoc = linspace(0, c, N/2);

%Define the half thickness at a location x
yThickFunc = @(x)((t/0.2)*c*(0.2969*sqrt(x/c)-0.1260*(x/c)-0.3516*(x/c).^2+0.2843*(x/c).^3-0.1036*(x/c).^4));
yThick = yThickFunc(xLoc);


%Define mean camber line function
%Less than maximum camber
xLess = xLoc(xLoc < p*c); %X locations before max camber
xGreat = xLoc(xLoc >= p*c); %X lovations after max camber

%Line of the camber
ycLessFunc = @(x)((m*x/p^2).*(2*p - x/c));
ycGreatFunc = @(x)((m*(c-x)/(1-p)^2).*(1 + x/c - 2*p));

ycLess = ycLessFunc(xLess);
ycGreat = ycGreatFunc(xGreat);
ycTot = [ycLess, ycGreat];


%Define dyc/dx
dycLess = diff(ycLess) ./ diff(xLess);
dycGreat = diff(ycGreat) ./ diff(xGreat);

%Calculate zeta
zeta1 = atan(dycLess);
zeta2 = atan(dycGreat);
zeta = [0, zeta1, zeta2, 0]; %0 at the leading and trailing edge

%Check if the airfoil has no camber
if(m == 0)
    zeta = zeros(1,N/2); %Zeta is zero everywhere for no camber
end

%Upper and lower x,y locations
xu = xLoc - yThick .* sin(zeta);
xl = xLoc + yThick .* sin(zeta);

yu = ycTot + yThick .* cos(zeta);
yl = ycTot - yThick .* cos(zeta);

%Total x and y, start at trailing edge and go around clockwise ending at
%trailing edge
x = [flip(xu), xl(2:end)];
y = [flip(yu), yl(2:end)];

end

