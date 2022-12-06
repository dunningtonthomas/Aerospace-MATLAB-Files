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

%Lengths
L = 11 + 7/16; %in


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



%Analytical Solution
PcrSolid = 122.8;
PcrHollow = 230.2;

PsolidTheoretical = @(x)(PcrSolid*(1 + (pi^2 * x.^2)/(8*L^2)));
PhollowTheoretical = @(x)(PcrHollow*(1 + (pi^2 * x.^2)/(8*L^2)));

dispTheo = [0:1/16:1, 1:1/8:2];


%% Problem 3
%Vector of lengths
lengths = linspace(1.75,60,100);

%Plot Pcr for varying lengths
I = 0.125^3 * 1 / 12;
E = 10 * 10^6;
Pcr = @(L)((pi^2 * E*I)./L.^2);

%Plot the yielding load in compression
sigma = 35000;
yieldLoad = sigma * 0.125*1;



%% Plotting
%Hollow
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(dispHollow, loadHollow, '*');
hold on
plot([0,dispTheo], [0,PhollowTheoretical(dispTheo)], 'linewidth', 2, 'color', rgb('light blue'));
xline(plasticDispHollow, 'r', 'linewidth', 2);
xline(0.3711, 'color', rgb('orange'), 'linewidth', 2);

title('Applied Load vs Displacement Hollow');
xlabel('Displacement ($$in$$)');
ylabel('Applied Load ($$lbf$$)');
legend('Experimental Data', 'Theoretical', 'Experimental Plastic Deformation Initiation', 'Theoretical Plastic Deformation Initiation', 'location', 'best');

%Solid
figure();
plot(dispSolid, loadSolid, '*');
hold on
plot([0,dispTheo], [0,PsolidTheoretical(dispTheo)], 'linewidth', 2, 'color', rgb('light blue'));
xline(plasticDispSolid, 'r', 'linewidth', 2);
xline(0.7423, 'color', rgb('orange'), 'linewidth', 2);

title('Applied Load vs Displacement Solid');
xlabel('Displacement ($$in$$)');
ylabel('Applied Load ($$lbf$$)');
legend('Experimental Data', 'Theoretical', 'Experimental Plastic Deformation Initiation', 'Theoretical Plastic Deformation Initiation', 'location', 'best');


%Problem 3
figure();
plot(lengths, Pcr(lengths));
hold on
yline(yieldLoad, 'r')

title('Solid Cross Section');
