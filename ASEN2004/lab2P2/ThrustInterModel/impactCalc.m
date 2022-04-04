function [finalMat] = impactCalc(const,wind,thrustFunc)
%IMPACTCALC This function will call ode45 using the ROC function
%handle and output the integrated values for the x y and z position and the
%vx vy and vz velocities

%Getting constant values
g = const(1);
m0 = const(2);
mf = const(3);
Cd = const(4);
DBottle = const(5);
rhoAirAmb = const(6);
startAngle = const(7);
mu = const(8);

%Calculating change in velocity
delV = Isp * g * log(m0 / mf);

%Getting initial parameters
x0 = 0;
y0 = 0;
z0 = 0.25;
vx0 = delV * cosd(startAngle);
vy0 = 0;
vz0 = delV * sind(startAngle);

%Initial State Vector
initStateODE = [x0;y0;z0;vx0;vy0;vz0];
tspan = [0 10];

%Creating the function handle, constVec is passed into the function, t and
%state are variable to the handle
ROCfunc = @(t,state) ROC(t,state,const,wind);

%Creating ode options to have a more accurate calculation
options = odeset('RelTol', 1e-8, 'AbsTol',1e-10);

%Calling ode45
[timeVec, finalMat] = ode45(ROCfunc, tspan, initStateODE, options);

end

