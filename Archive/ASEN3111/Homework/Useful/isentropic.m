function [ p0op,t0ot,rho0orho ] =isentropic( M )

g=1.4;
p0op=(1+(g-1)/2*M^2)^(g/(g-1));
t0ot=1+(g-1)/2*M^2;
rho0orho=(1+(g-1)/2*M^2)^(1/(g-1));

end