%declaring function named EOM with inputs t, stateVector, and InitParameters and with output F
function f = EOM(~,stateVector,InitParameters) %EOM(t,stateVector,InitParameters)

%declaring the x velocity and y velocity; x velocity is the first column of
%the stateVector while y velocity is the 2nd column of the stateVector
Vx = stateVector(1);
Vy = stateVector(2);


%storing the induvidual initial parameter values into variables
Cd = InitParameters.Cd;
r = InitParameters.r;
m = InitParameters.m;
p = InitParameters.rho;
g = InitParameters.g;

%creating the equation for A, theta, and grag
A = pi*(r^2);
theta = atan2(Vy, Vx);
Drag = (1/2) * p * Cd * A * ((Vx^2) + (Vy^2));

%creating the equations for dvxdt, dvydt, dxdt, and dydt
dvxdt = (-Drag * cos(theta)) / m;
dvydt = (((-Drag * sin(theta)) / m) - g);
dxdt = Vx;
dydt = Vy;


%creating a vector called f to put all 4 values above into a column vector
f = [dvxdt; dvydt; dxdt; dydt];
end