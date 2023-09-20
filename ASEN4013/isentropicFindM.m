function [Msub] = isentropicFindM(g,p0op)
% Solves Mach number from ratio of total pressure to local pressure (and
% gamma)
Msub=sqrt(((p0op)^((g-1)/g)-1)*2/(g-1));
end