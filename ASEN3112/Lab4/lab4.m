%% Clean Up
clear; close all; clc;

%% Pre Test Calculations
E1 = 10*10^6;
I1 = 1;
L1 = 12 + 0.4; %inches

Pcr = pi^2 * E1 * I1 / L1^2;


%% Import Data
load('datahollowsection.mat');
timeHollow = data(:,1);
voltageHollow = data(:,2);
dispHollow = data(:,3);
load('datasolidsection.mat');
timeSolid = data(:,1);
voltageSolid = data(:,2);
dispSolid = data(:,3);

%Data cleaning 
%Get rid of the multiple data points per displacement, take the max



%% Analysis
%Convert the voltage to lb
%2.37 mV/lb for the voltage output
voltConv = (1 / 2.37) * 1000; %lb per V

loadSolid = voltConv * voltageSolid;
loadHollow = voltConv * voltageHollow;


%Calculate the buckling load, this is the maximum at 0 displacement
zeroDisp = dispSolid == 0;
buckleSolid = max(loadSolid(zeroDisp));

zeroDisp = dispHollow == 0;
buckleHollow = max(loadHollow(zeroDisp));

%Plastic Deformation
plasticDispSolid = 0.9375;
plasticDispHollow = 0.3125;


%% Plotting
%Hollow
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(dispHollow, loadHollow, '*');
hold on
xline(plasticDispHollow, 'r', 'linewidth', 2);

title('Applied Load vs Displacement Hollow');
xlabel('Displacement ($$in$$)');
ylabel('Applied Load ($$lbf$$)');
legend('Experimental Data', 'Plastic Deformation Initiation');

%Solid
figure();
plot(dispSolid, loadSolid, '*');
hold on
xline(plasticDispSolid, 'r', 'linewidth', 2);

title('Applied Load vs Displacement Solid');
xlabel('Displacement ($$in$$)');
ylabel('Applied Load ($$lbf$$)');
legend('Experimental Data', 'Plastic Deformation Initiation');




