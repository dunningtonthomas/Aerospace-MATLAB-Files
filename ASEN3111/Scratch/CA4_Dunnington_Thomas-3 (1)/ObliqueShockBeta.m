function [Betad] = ObliqueShockBeta(M,Thetad,Gamma,Type)
%ObliqueShockBeta Explicitly solves theta-beta-m relation for the oblique
%shock wave angle.
%   Explicitly solves the theta-beta-m relation for the oblique shock wave
%   angle, betad, given a wedge angle, thetad, Mach number, M, ratio of 
%   specific heats, gamma, and the Type of the oblique shock, either 'Weak' 
%   or 'Strong'.
%
%   Note the angles, Thetad and Betad, are input and output in degrees.
%
%   Additionally note that if theta is greater than theta max for a given 
%   Mach number and Gamma, then an attached shock does not exist for the
%   given inputs and instead a detached shock will form and this function 
%   will output either a negative or complex number; which are both 
%   non-physical.
%
%   Based on an analytical solution to the theta-beta-Mach relation given in
%   the following reference:  Rudd, L., and Lewis, M. J., "Comparison of
%   Shock Calculation Methods", AIAA Journal of Aircraft, Vol. 35, No. 4,
%   July-August, 1998, pp. 647-649.
%
%   By: J. Evans & J. Farnsworth
%   University of Colorado Boulder
%   April 03, 2022

% Convert Theta to Radians
Theta=deg2rad(Thetad);   

% Compute the Mach Wave Angle
mu=asin(1/M); 

% Compute the equation scaling coeffiients
c=tan(mu)^2;
a=((Gamma-1)/2+(Gamma+1)*c/2)*tan(Theta);
b=((Gamma+1)/2+(Gamma+3)*c/2)*tan(Theta);
d=sqrt(4*(1-3*a*b)^3/((27*a^2*c+9*a*b-2)^2)-1);

% Switch between 'Strong' and 'Weak' Shock forms
switch Type
    case 'Weak'
        n = 0;
    
        Beta=atan((b+9*a*c)/(2*(1-3*a*b))-(d*(27*a^2*c+9*a*b-2))/(6*a*(1-3*a*b))*tan(n*pi/3+1/3*atan(1/d)));
    case 'Strong'
        n = 1;
        
        Beta=atan((b+9*a*c)/(2*(1-3*a*b))-(d*(27*a^2*c+9*a*b-2))/(6*a*(1-3*a*b))*tan(n*pi/3+1/3*atan(1/d)));
        
        if Beta < 0
            n = -1;
            
            Beta=atan((b+9*a*c)/(2*(1-3*a*b))-(d*(27*a^2*c+9*a*b-2))/(6*a*(1-3*a*b))*tan(n*pi/3+1/3*atan(1/d)));
        end
end

% Convert Beta to degrees
Betad = rad2deg(Beta);
