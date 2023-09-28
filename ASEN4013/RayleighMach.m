function [mach2] = RayleighMach(Tt2oTt1, M1, g)
%RAYLEIGHMACH This function takes in a total temperature ratio of before
%and after the heat addition and calculates the mach number after the heat
%addition given the first mach number

phi1 = M1^2 * (1 + (g-1)/2 * M1^2) / (1 + g*M1^2)^2;
phiFunc = @(M2)(M2^2 * (1 + (g-1)/2 * M2^2) / (1 + g*M2^2)^2) / phi1 - Tt2oTt1;

%Root solve for the mach after the heat addition
mach2 = fzero(phiFunc, M1 + 0.3*M1);

end

