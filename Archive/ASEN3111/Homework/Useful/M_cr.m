function [M_cr ]=PGlimit(cp0,M_inf_g)
%m_inf is a vector of mach numbers
cpPG=cp0./sqrt(1-M_inf.^2); %from Prandtl Glauert
g=1.4;
cpcr=2./(g.*M_inf.^2).*(((1+((g-1)/2).*m_inf.^2)./(1+(g-1)/2)).^...
    (g/(g-1))-1); % from critcial pressure equation
cpdiff = @(M_inf) cpPG-cpcr;
M_cr = fsolve(cpdiff,M_inf_g);