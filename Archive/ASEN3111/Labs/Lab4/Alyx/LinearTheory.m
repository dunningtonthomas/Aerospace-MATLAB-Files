%%% Linear theory function CA 4

% computes the linear lift and wave drag coeffs from the equations shown in
% the lab document and linear theory notes

function [c_l,c_dw] = LinearTheory(M, alpha, epsilon1, epsilon2)

% converting to radians
alpha = deg2rad(alpha);
epsilon1 = deg2rad(epsilon1);
epsilon2 = deg2rad(epsilon2);

c_l = (4*abs(alpha))/(sqrt(M^2 -1));

% these could be replaced for just epsilon
gl = tan(epsilon1); 
gu = tan(epsilon2);

c_dw = (2/(sqrt(M^2 -1))) * (2*alpha^2 + gl^2 + gu^2);

end