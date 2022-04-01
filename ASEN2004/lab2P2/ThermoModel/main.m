%% Header
%Author: Thomas Dunnington
%Student ID Number: 109802853
%Date Created: 11/06/2021
%Date Modified: 3/30/2022

%% Main Code
%Clean up
close all; clear; clc;

%Provided constants and initial values
g = 9.81;                                   %m/s^2
Cdischarge = 0.8;                           %unitless
rhoAirAmb = 0.961;                          %kg/m^3
VolBottle = 0.002;                          %m^3
PressAmb = 12.1 * (6894.76);                %Pa
rhoWater = 1000;                            %kg/m^3
DThroat = 0.021;                            %m
DBottle = 0.105;                            %m
R = 287;                                    %J/kgK
mBottle = 0.15;                             %kg
Cd = 0.5;                                   %unitless
PressAirInit = 50 * (6894.76) + PressAmb;   %Pa
VolWaterInit = 0.001;                       %m^3
TAirInit = 300;                             %K
initAngle = 45;                             %degrees

g = 9.81;
m0 = 0.15 + (VolWaterInit * rhoWater);
mf = 0.15;
Cd = 0.5;
DBottle = 0.105;
rhoAirAmb = 0.961;
startAngle = 45;
mu = 0.2;

constVec = [g;m0;mf;Cd;DBottle;rhoAirAmb;startAngle;mu];


%Reading in data
IspMat = readmatrix("Specific_Impulses.csv");
Isp = mean(IspMat);

%Calculating change in velocity
delV = Isp * g * log(m0 / mf);

%Creating initial parameters
x0 = 0;
y0 = 0;
z0 = 0.25;
vx0 = delV * cosd(startAngle);
vy0 = 0;
vz0 = delV * sind(startAngle);

%Initial State Vector
initState = [x0;y0;z0;vx0;vy0;vz0];
tspan = [0 5];

%Model for Wind
wind = [0;1;0];

%Creating the function handle, constVec is passed into the function, t and
%state are variable to the handle
ROCfunc = @(t,state) ROC(t,state,constVec,wind);

%Creating ode options to have a more accurate calculation
options = odeset('RelTol', 1e-8, 'AbsTol',1e-10);

%Calling ode45
[timeVec, finalMat] = ode45(ROCfunc, tspan, initState, options);

%Extracting integrated values from the ode45 output
xPosition = finalMat(:,1);
yPosition = finalMat(:,2);
zPosition = finalMat(:,3);
xVelocity = finalMat(:,4);
yVelocity = finalMat(:,5);
zVelocity = finalMat(:,6);

%Impact Calculation

%% Plotting
figure(1)
set(0, 'defaultTextInterpreter', 'latex');
set(gca, 'FontSize', 12);
h = plot3(xPosition, yPosition, zPosition, 'r');
set(h,'defaultaxesfontname','cambria math');
h.LineWidth = 2;
grid on
xlim([0 80]);
ylim([-10 10]);
zlim([0 20]);
title('Trajectory');
xlabel('x Position ($m$)');
ylabel('y Position ($m$)');
zlabel('z position ($m$)');


