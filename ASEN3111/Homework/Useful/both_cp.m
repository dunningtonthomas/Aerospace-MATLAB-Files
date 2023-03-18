function [cpPG,cpcr ]=both_cp(m_inf,cp0)
%m_inf is a vector of mach numbers
cpPG=cp0./sqrt(1-m_inf.^2); %from Prandtl Glauert
g=1.4;
cpcr=2./(g.*m_inf.^2).*(((1+((g-1)/2).*m_inf.^2)./(1+(g-1)/2)).^...
    (g/(g-1))-1); % from critcial pressure equation