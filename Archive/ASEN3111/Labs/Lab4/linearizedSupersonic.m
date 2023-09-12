function [c_l,c_dw] = linearizedSupersonic(M, alpha, epsilon1, epsilon2)
%AUTHOR: Thomas Dunnington
%COLLABORATORS: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase Rupprecht
%DATE: 4/26/2023
%LINEARIZEDSUPERSONIC 
%SUMMARY: This function uses linearized supersonic theory to calculate the
%coefficient of lift and wave drag for a diamond airfoil with given angles
%INPUTS:
%   M = freestream mach number
%   alpha = angle of attack
%   epsilon1 = leading edge angle of diamond airfoil
%   epsilon2 = trailing edge angle of diamond airfoil
%OUTPUTS:
%   c_l = coefficient of lift
%   c_dw = coefficient of drag (wave drag)


%Convert to radians
alpha = alpha * pi / 180;

%Calculate cl
c_l = 4*alpha / sqrt(M^2 - 1);

%Calculate cd
%More accurate approximation, can use epsilon1 and epsilon2 instead of tan
%since we assume small AoA
gl = tand(epsilon1); 
gu = tand(epsilon2);

c_dw = (2/(sqrt(M^2 -1))) * (2*alpha^2 + gl^2 + gu^2);
end

