function alpha_L0 = zeroLiftALpha(m,p)
%zeroLiftALpha
%Summary: This function uses Thin Airfoil theory to calculate the zero lift
%angle of attack
%   Author: Thomas Dunnington
%   Collaborators: Nolan Stevenson, Carson Kohlbrenner, Chase Rupprecht,
%   Owen Craig
%   Date: 4/5/2023
%
%INPUTS: 
%   m = maximum camber
%   p = location of maximum camber
%OUTPUTS: 
%   alpha_L0 = zero lift angle of attack in degrees

%Declare where the piecewise function shifts
thetaChange = acos(1 - 2*p);

%Create theta vector
thetaVec = linspace(0, pi, 1000); %1000 points
thetaLess = thetaVec(thetaVec < thetaChange);
thetaGreat = thetaVec(thetaVec >= thetaChange);

%Create dyc/dx vectors
dycdxLess = (2*m/p^2)*(p - 0.5*(1 - cos(thetaLess))).*(cos(thetaLess)-1);
dycdxGreat = (2*m/(1-p)^2) * (p - 0.5*(1 - cos(thetaGreat))).*(cos(thetaGreat)-1);


%Integrate
alpha_L0 = -1/pi * (trapz(thetaLess, dycdxLess) + trapz(thetaGreat, dycdxGreat));
alpha_L0 = alpha_L0 * 180 / pi;

end

