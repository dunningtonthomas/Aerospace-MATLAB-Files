%clearing the command window
close all; clear all;clc;

%declaring all my variables and vectors to use for later.
tspan = [0,10]; %time interval
initTheta = 45; %initial theta in degrees
V0 = 50; %initial velocity
Vx0 = V0 * cosd(initTheta); %initial velocity in the x direction
Vy0 = V0 * sind(initTheta); %initial velocity in the y direction
x0 = 0; %initial x position
y0 = 100; %initial y position
StateVector = [Vx0; Vy0; x0; y0]; %declaring the state vector

%loading in the parameter.mat file to read in the data
InitParameters = load('Parameter.mat');

%storing the induvidual values into variables
Cd = InitParameters.Cd;
g = InitParameters.g;
m = InitParameters.m;
r = InitParameters.r;
p = InitParameters.rho;
A = pi * (r^2);

%creating the EOMFun handel for the EOM function. t and stateVector are two
%changing variables while InitParameters doesnt; therefore we need to
%create an argument list before the function name.
EOMFun = @(t, stateVector)EOM(t, stateVector, InitParameters);

%calling the ode function 
[TimeVector, stateMatrix] = ode45(EOMFun,tspan,StateVector,InitParameters);

%storing the stateMatrix data columns into vectors
vxVector = stateMatrix(:,1); %storing first column into vxVector
vyVector = stateMatrix(:,2); %storing 2nd column into vyVector
xVector = stateMatrix(:,3); %storing 3rd column into xVector
yVector = stateMatrix (:,4); %storing 4th column into yVector

%creating the Drag formula
Drag = (1/2) * p * Cd * A * ((vxVector.^2) + (vyVector.^2));

%creating function handel for colorLine3D. C changes while xVector and
%yVector remain the same.
ColorPlotFun = @(c)colorLine3D(c,xVector, yVector);

%makes sure that multiple plots/graphs can be on the same figure
hold on;

%creating the first plot
subplot(2,2,1); %creating a 2 by 2 matrix in the position of 1st graph
subPlot1 = ColorPlotFun(TimeVector); %calling the ColorPlotFun with time vector as the input
title("Time (s)"); %title
xlabel("x (meters)"); %x name
ylabel("y (meters)");% y name


%creating the second plot
subplot (2,2,2);%creating a 2 by 2 matrix in the position of 2nd graph
subPlot2 = ColorPlotFun(vxVector); %calling the ColorPlotFun with the x velocity vector as the input
title("X Velocity (m/s)"); %title
xlabel("x (meters)");% x name
ylabel("y (meters)");% y name


%creating the third plot
subplot(2,2,3); %creating a 2 by 2 matrix in the position of 3rd graph
subPlot3 = ColorPlotFun(vyVector); %calling the ColorPlotFun with the y velocity vector as the input
title ("Y Velocity (m/s)"); %title
xlabel ("x (meters)"); %x label
ylabel ("y (meters)");% y label


%creating the 4th plot
subplot(2,2,4); %creating a 2 by 2 matrix in the position of 4th graph
subPlot4 = ColorPlotFun(Drag);  %calling the ColorPlotFun with the drag as the input
title  ("Drag (N)"); % title
xlabel ("x (meters)");% x label
ylabel ("y (meters)"); %y label

