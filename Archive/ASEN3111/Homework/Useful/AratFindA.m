function [Arat] = AratFindA(gamma,m)
% function that solves for Area ratio directly from a given M and gamma

Arat=sqrt((1/m.^2)*((2/(gamma + 1))*...
    (1 + (gamma-1)*m.^2/2))^((gamma+1)/(gamma-1))) ;