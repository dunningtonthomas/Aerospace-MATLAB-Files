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
%Define length 1 over c and length 2 over c using law of sines
L1oC = sind(epsilon2) / sind(180 - epsilon1 - epsilon2);
L2oC = sind(epsilon1) / sind(180 - epsilon1 - epsilon2);

%Lower surface g value, derived the integral result by hand
gl_Squared = L1oC*cosd(epsilon1)*((tand(epsilon1))^2 - (tand(epsilon2))^2) + L2oC*cosd(epsilon2)*(tand(epsilon2))^2;

%Upper surface is the same as upper
gu_Squared = L1oC*cosd(epsilon1)*((tand(epsilon1))^2 - (tand(epsilon2))^2) + L2oC*cosd(epsilon2)*(tand(epsilon2))^2;

%Apply linearized equation for coefficient of drag
c_dw = 2 / sqrt(M^2 - 1) * (2*alpha^2 + gl_Squared + gu_Squared);

%Alyx test
gl = tand(epsilon1); 
gu = tand(epsilon2);

c_dw = (2/(sqrt(M^2 -1))) * (2*alpha^2 + gl^2 + gu^2);

end

