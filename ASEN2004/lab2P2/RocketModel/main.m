%% Header
%Author: Thomas Dunnington
%Student ID Number: 109802853
%Date Created: 11/06/2021
%Date Modified: 3/30/2022

%% Main Code
%Clean up
close all; clear; clc;

%Reading in data
IspMat = readmatrix("Specific_Impulses.csv");
Isp = mean(IspMat);

%Provided constants and initial values
rhoWater = 1000;                            %kg/m^3
VolWaterInit = 0.001;                       %m^3

g = 9.81;
m0 = 0.125 + 1;
mf = 0.125;
Cd = 0.2;
DBottle = 0.105;
rhoAirAmb = 0.961;
startAngle = 45;
mu = 0.4;

constVec = [g;m0;mf;Cd;DBottle;rhoAirAmb;startAngle;mu];


wind = (7 / 2.237) * [cosd(195);sind(195);0]; %Zero wind baseline, 7 mph SSW from 30 NE

%Initial Parameters for LA rocket
finalMat = impactCalc(constVec, wind, Isp);

% %Extracting integrated values from the ode45 output
xPosition = finalMat(:,1);
yPosition = finalMat(:,2);
zPosition = finalMat(:,3);

baseLineImpact = [xPosition(end), yPosition(end)];
writematrix(baseLineImpact, 'baseImpact.csv');

%% Monte Carlo Simulation
%Variables to vary
stdAngle = 1;
stdWater = 0.5 / 1000;
stdCd = 0.05;
stdRhoAirAmb = 0.05;
stdMu = 0.05;
stdIsp = 0.1;

%Performing 500 simulations
monteCell = cell(1,500);
impactMat = zeros(500, 2);

for j = 1:500
    %Calculating random variation for the uncertain values
    randAngle = (2 * rand(1) - 1) * stdAngle;
    randWater = (2 * rand(1) - 1) * stdWater;
    randCd = (2 * rand(1) - 1) * stdCd;
    randRhoAirAmb = (2 * rand(1) - 1) * stdRhoAirAmb;
    randMu = (2 * rand(1) - 1) * stdMu;
    randIsp = (2 * rand(1) - 1) * stdIsp;
    randWindx = (4 * rand(1)) - 2; %rand between -3 and 3
    randWindy = (4 * rand(1)) - 2;
    
    %Constant Values
    m0 = 0.125 + 1 + randWater;
    mf = 0.125;
    Cd = 0.2 + randCd;
    rhoAirAmb = 0.961 + randRhoAirAmb;
    startAngle = 45 + randAngle;
    mu = 0.4 + randMu;

    constVec = [g;m0;mf;Cd;DBottle;rhoAirAmb;startAngle;mu];
    
    %Wind and Isp
    windMonte = wind + [randWindx; randWindy; 0];
    IspMonte = Isp + randIsp;    
    
    %Performing integration
    finalMat = impactCalc(constVec, windMonte, IspMonte);
    monteCell{j} = finalMat;
    
    %Getting the impact location
    impactMat(j,:) = finalMat(end, 1:2);    
end

% Impact Extrapolation
writematrix(impactMat, 'impacts.csv');

%% Plotting
figure(1)
set(0, 'defaultTextInterpreter', 'latex');
set(gca, 'FontSize', 12);
h = plot3(xPosition, yPosition, zPosition, 'r');
set(h,'defaultaxesfontname','cambria math');
h.LineWidth = 2;
grid on
hold on

%% Monte Plot
for j = 1:500
   mat = monteCell{j};
   xPos = mat(:,1);
   yPos = mat(:,2);
   zPos = mat(:,3);
   plot3(xPos, yPos, zPos);
end
xlim([0 100]);
ylim([-10 10]);
zlim([0 35]);
title('Trajectory');
xlabel('x Position ($m$)');
ylabel('y Position ($m$)');
zlabel('z position ($m$)');

