function [PtoPtStar, TtoTtStar, ToTStar, PoPStar] = RayleighStar(M, g)
%RAYLEIGHMACH This function calculates the star ratios given a mach number
%and gamma

%Total Pressure ratio
PtoPtStar = (g+1)/(1+g*M^2) * ((2 / (g+1)) * (1 + (g-1)/2 * M^2))^(g / (g-1));

%Total temperature
TtoTtStar = (2*(g+1)*M^2)/(1+g*M^2)^2 * (1 + (g-1)/2 * M^2);

%Temperature
ToTStar = (g+1)^2 * M^2 / (1 + g*M^2)^2;

%Pressure
PoPStar = (g + 1)/(1 + g*M^2);


end

