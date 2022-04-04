%% Header
%Author: Thomas Dunnington
%Student ID Number: 109802853
%Date Created: 11/06/2021
%Date Modified: 3/30/2022

%% Main Code
%Clean up
close all; clear; clc;

%% Reading in data
thrustMat = readmatrix('trial5');
thrustMat = thrustMat(4:end, :);

                

%% Creating thrust function

freq = 1.652*1000; % fixed
tStep = 1/freq;
massProp = 1; % 1 kg
g0 = 9.81; % m^2/s

summedT = thrustMat(:,3);
timeVec = [0:1:length(summedT)-1]*tStep;

    % first avg 4 pts for all, gets rid of some noise for cutoffs
    for i = 1:(length(summedT)/4 - 1)
        T1 = summedT(2*i);
        T2 = summedT(2*i + 1);
        T3 = summedT(2*i + 2);
        T4 = summedT(2*i + 3);
        Time1 = timeVec(2*i);
        Time2 = timeVec(2*i + 1);
        Time3 = timeVec(2*i + 2);
        Time4 = timeVec(2*i + 3);
        avgT(i) = mean([T1 T2 T3 T4]);
        avgTime(i) = mean([Time1 Time2 Time3 Time4]);
    end
    
    % now get cutoffs by checking for when the differene between avgs is > 0.5
    % from either side
    checker = false;
    i = 1;
    while checker == false
        if (abs(avgT(i) - avgT(i+1)) > 2.5) % larger diffference neededd as climb spikes and lots of noise in a few data trials
            firstCut_i = i;
            firstCut = avgTime(i);
            checker = true;
        end
        i = i + 1;
    end
    % flip it to get first change from otherside
    flippedT = flip(avgT);
    checker = false;
    i = 1;
    while checker == false
        if abs(flippedT(i) - flippedT(i+1)) > .5
            lastCutIndex = i;
            checker = true;
        end
        i = i + 1;
    end
    flippedTime = flip(avgTime);
    lastCut = flippedTime(lastCutIndex);
    
    cutOff = [firstCut lastCut];
    indexCut = timeVec > cutOff(1) & timeVec < cutOff(2);
    
    timeVec = timeVec(indexCut);
    summedT = summedT(indexCut)*4.44822; % Convert the lbf to N

%% Analysis

%Provided constants and initial values
rhoWater = 1000;                            %kg/m^3
VolWaterInit = 0.001;                       %m^3

g = 9.81;
m0 = 0.15 + (VolWaterInit * rhoWater);
mf = 0.15;
Cd = 0.5;
DBottle = 0.105;
rhoAirAmb = 0.961;
startAngle = 45;
mu = 0.3;

constVec = [g;m0;mf;Cd;DBottle;rhoAirAmb;startAngle;mu];


thrustTime = (timeVec - timeVec(1))'; %Delta t
thrustVec = summedT;
wind = [(4 * rand(1)) - 2; (4 * rand(1)) - 2; 0];  %rand between -2 and 2

%Getting initial parameters
x0 = 0;
y0 = 0;
z0 = 0.25;
vx0 = 0;
vy0 = 0;
vz0 = 0;

%Initial State Vector
initStateODE = [x0;y0;z0;vx0;vy0;vz0;m0];
tspan = [0 10];

%Creating the function handle, constVec is passed into the function, t and
%state are variable to the handle
ROCfunc = @(t,state) ROC(t,state,constVec,wind,thrustVec,thrustTime);

%Creating ode options to have a more accurate calculation
options = odeset('RelTol', 1e-8, 'AbsTol',1e-10);

%Calling ode45
[finalTime, finalMat] = ode45(ROCfunc, tspan, initStateODE, options);

% %Extracting integrated values from the ode45 output
xPosition = finalMat(:,1);
yPosition = finalMat(:,2);
zPosition = finalMat(:,3);
xVelocity = finalMat(:,4);
yVelocity = finalMat(:,5);
zVelocity = finalMat(:,6);

figure
plot3(xPosition, yPosition, zPosition);
grid on
xlim([0 125]);
ylim([-10 10]);
zlim([0 60]);
title('Trajectory');
xlabel('x Position ($m$)');
ylabel('y Position ($m$)');
zlabel('z position ($m$)');

%% Monte Carlo Simulation
%Variables to vary

stdAngle = 1;
stdWater = 0.5 / 1000;
stdCd = 0.05;
stdRhoAirAmb = 0.05;
stdMu = 0.05;
stdWind = 2;

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
    randWindx = (4 * rand(1)) - 2; %rand between -3 and 3
    randWindy = (4 * rand(1)) - 2;
    
    %Constant Values
    m0 = 0.15 + (VolWaterInit * rhoWater) + randWater;
    mf = 0.15;
    Cd = 0.5 + randCd;
    rhoAirAmb = 0.961 + randRhoAirAmb;
    startAngle = 45 + randAngle;
    mu = 0.3 + randMu;

    constVec = [g;m0;mf;Cd;DBottle;rhoAirAmb;startAngle;mu];
    
    %Wind and Isp
    windMonte = [randWindx; randWindy; 0];
    
    
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
for j = 1:500
   mat = monteCell{j};
   xPos = mat(:,1);
   yPos = mat(:,2);
   zPos = mat(:,3);
   plot3(xPos, yPos, zPos);
end
xlim([0 80]);
ylim([-10 10]);
zlim([0 20]);
title('Trajectory');
xlabel('x Position ($m$)');
ylabel('y Position ($m$)');
zlabel('z position ($m$)');


