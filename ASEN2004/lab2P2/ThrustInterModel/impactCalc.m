function [finalMat] = impactCalc(const,wind,thrustVec,timeThrust,randThrust)
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

%Getting initial parameters
x0 = 0;
y0 = 0;
z0 = 0.25;
vx0 = 0;
vy0 = 0;
vz0 = 0;

%Initial State Vector
initStateODE = [x0;y0;z0;vx0;vy0;vz0;m0];
tspan = [0 6];

%Creating the function handle, constVec is passed into the function, t and
%state are variable to the handle
ROCfunc = @(t,state) ROC(t,state,const,wind,thrustVec,timeThrust + randThrust);

%Creating ode options to have a more accurate calculation
options = odeset('RelTol', 1e-8, 'AbsTol',1e-10);

%Calling ode45
[timeVec, finalMat] = ode45(ROCfunc, tspan, initStateODE, options);

end

