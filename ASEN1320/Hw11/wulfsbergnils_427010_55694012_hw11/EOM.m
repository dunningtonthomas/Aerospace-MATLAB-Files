function [f] = EOM(t,stateVector, InitParameters)

Cd = InitParameters(1);
r = InitParameters(2);
m = InitParameters(3);
p = InitParameters(4);
g = InitParameters(5);
vx = stateVector(1);
vy = stateVector(2);
A = pi*(r^2);
theta = atan(vy/vx);
D = 0.5*p*Cd*A.*(vx.^2 + vy.^2);

dvxdt = (-D*cos(theta))/m;
dvydt = ((-D*sin(theta))/m)-g;
dxdt = vx;
dydt = vy;

f = [dvxdt; dvydt; dxdt; dydt];
end

