close all, clear all, clc;

vx = input('vx = ');
vy = input('vy = ');
x = input('x = ');
y = input('y = ');
stateVector = [vx; vy; x; y];

load('Parameter.mat');
InitParameters = [Cd, r, m, rho, g];

%tspan = input('tspan = ', 's');
tspan = [0 10];

EOMFunc = @(t,stateVector)EOM(t,stateVector, InitParameters);
[timeVector, stateMatrix] = ode45(EOMFunc, tspan, stateVector);

A = pi*(r^2);
Drag = 0.5*rho*Cd*A.*(stateMatrix(:,1).^2 + stateMatrix(:,2).^2);

ColorPlotFun = @(T)colorLine3D(T, stateMatrix(:,3), stateMatrix(:,4));
subplot(2,2,1)
title('Time (S)')
ylabel('y (meters)')
xlabel('x (meters)')
subPlot1 = ColorPlotFun(timeVector);
subplot(2,2,2)
title('X velocity (m/s)')
ylabel('y (meters)')
xlabel('x (meters)')
subPlot2 = ColorPlotFun(stateMatrix(:,1));
subplot(2,2,3)
title('Y velocity (m/s)')
ylabel('y (meters)')
xlabel('x (meters)')
subPlot3 = ColorPlotFun(stateMatrix(:,2));
subplot(2,2,4)
title('Drag (N)')
ylabel('y (meters)')
xlabel('x (meters)')
subPlot4 = ColorPlotFun(Drag);

