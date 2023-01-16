%% Clean Up
clear; close all; clc;



%% Import in data

%Elimnate the T0 thermocouple location, use extrapolation instead to find
%the T0 value
alum26 = readmatrix('Aluminum_26V_250mA');
alum28 = readmatrix('Aluminum_28V_269mA');
brass26 = readmatrix('Brass_26V_245mA');
brass29 = readmatrix('Brass_29V_273mA');
steel = readmatrix('Steel_21V_192mA');

%Getting rid of the T0 experimental values
alum28(:,2) = [];
brass26(:,2) = [];
brass29(:,2) = [];
steel(:,2) = [];

%Load in model 3
load('model3.mat');

%Load in model 2
load('model2.mat');

alum26_m2 = UXTA1II.e(1,:)';
alum28_m2 = UXTA2II.e(1,:)';
brass26_m2 = UXTB1II.e(1,:)';
brass29_m2 = UXTB2II.e(1,:)';
steel_m2 = UXTSII.e(1,:)';



%% Plot the last thermocouple and all 3 models on top
%Getting lines that are +- 2 degrees celsius for all models


alum26_m3 = [alphaAlum26Cell{7,1}];
alum28_m3 = [alphaAlum28Cell{2,1}];
brass26_m3 = [alphaBrass26Cell{1,1}];
brass29_m3 = [alphaBrass29Cell{1,1}];
steel_m3 = [alphaSteelCell{20,1}];


%% Plotting
%Alum26
figure();
set(0, 'defaulttextinterpreter', 'latex');
plotExp = plot(alum26(:,1), alum26(:,2), 'linewidth', 2, 'color', 'k');
hold on
plotErr = plot(alum26(:,1), alum26(:,2) + 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
plot(alum26(:,1), alum26(:,2) - 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');

plotModel3 = plot(1:2000, alum26_m3, 'linewidth', 2, 'color', 'r');
plotModel2 = plot(1:1800, alum26_m2, 'linewidth', 2, 'color', 'b');

title('Aluminium 26V Thermocouple 8 With Experimental and Models II and III');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotErr, plotModel2, plotModel3], 'Experimental', 'Error Region', 'Model II', 'Model III', 'location', 'SE');


%Alum28
figure();
set(0, 'defaulttextinterpreter', 'latex');
plotExp = plot(alum28(:,1), alum28(:,2), 'linewidth', 2, 'color', 'k');
hold on
plotErr = plot(alum28(:,1), alum28(:,2) + 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
plot(alum28(:,1), alum28(:,2) - 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');

plotModel3 = plot(1:3000, alum28_m3, 'linewidth', 2, 'color', 'r');
plotModel2 = plot(1:3000, alum28_m2, 'linewidth', 2, 'color', 'b');

title('Aluminium 28V Thermocouple 8 With Experimental and Models II and III');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotErr, plotModel2, plotModel3], 'Experimental', 'Error Region', 'Model II', 'Model III', 'location', 'SE');



%Brass26
figure();
set(0, 'defaulttextinterpreter', 'latex');
plotExp = plot(brass26(:,1), brass26(:,2), 'linewidth', 2, 'color', 'k');
hold on
plotErr = plot(brass26(:,1), brass26(:,2) + 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
plot(brass26(:,1), brass26(:,2) - 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');

plotModel3 = plot(1:6000, brass26_m3, 'linewidth', 2, 'color', 'r');
plotModel2 = plot(1:5000, brass26_m2, 'linewidth', 2, 'color', 'b');

title('Brass 26V Thermocouple 8 With Experimental and Models II and III');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotErr, plotModel2, plotModel3], 'Experimental', 'Error Region', 'Model II', 'Model III', 'location', 'SE');



%Brass29
figure();
set(0, 'defaulttextinterpreter', 'latex');
plotExp = plot(brass29(:,1), brass29(:,2), 'linewidth', 2, 'color', 'k');
hold on
plotErr = plot(brass29(:,1), brass29(:,2) + 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
plot(brass29(:,1), brass29(:,2) - 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');

plotModel3 = plot(1:6000, brass29_m3, 'linewidth', 2, 'color', 'r');
plotModel2 = plot(1:5000, brass29_m2, 'linewidth', 2, 'color', 'b');

title('Brass 29V Thermocouple 8 With Experimental and Models II and III');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotErr, plotModel2, plotModel3], 'Experimental', 'Error Region', 'Model II', 'Model III', 'location', 'SE');


%Steel
figure();
set(0, 'defaulttextinterpreter', 'latex');
plotExp = plot(steel(:,1), steel(:,2), 'linewidth', 2, 'color', 'k');
hold on
plotErr = plot(steel(:,1), steel(:,2) + 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
plot(steel(:,1), steel(:,2) - 2, 'linewidth', 2, 'color', 'k', 'linestyle', '--');

plotModel3 = plot(1:12600, steel_m3, 'linewidth', 2, 'color', 'r');
plotModel2 = plot(1:13000, steel_m2, 'linewidth', 2, 'color', 'b');

title('Steel 21V Thermocouple 8 With Experimental and Models II and III');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotErr, plotModel2, plotModel3], 'Experimental', 'Error Region', 'Model II', 'Model III', 'location', 'SE');












