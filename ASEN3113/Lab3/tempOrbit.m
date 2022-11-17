%% Clean Up
clear; close all; clc;


%% Parameters
%Constants
sigma = 5.67 * 10^-8;

%Radiator params
area = 0.2863;
alphaSolar = 0.2;
alphaIR = 0.85;
epsilon = 0.85;
fluxEq = 1361;
fluxSum = 1361 - 0.033*1361; %3.3 variation in flux
fluxWin = 1361 + 0.033*1361; %3.3 variation in flux

%Angle of earth's tilt
tilt = 23.5*pi/180;

%Length of time in the shadow
timeInShadow = 1.146 * 60 * 60; %seconds in the shadow

%% Energy Balance Equations
time = 1:24*3600;
theta = linspace(0, 2*pi, length(time));

%%%%SUMMER SOLSTICE
%%Operation
TempSS_Op = ((1/(area*epsilon*sigma))*(20 + alphaSolar*fluxSum*area*cos(tilt)*sin(theta) + 63*area*alphaIR)).^(1/4);

%%Survival
TempSS_S = ((1/(area*epsilon*sigma))*(alphaSolar*fluxSum*area*cos(tilt)*sin(theta) + 63*area*alphaIR)).^(1/4);

%%%%WINTER SOLSTICE
%%Operation
TempWS_Op = ((1/(area*epsilon*sigma))*(20 + alphaSolar*fluxSum*area*cos(tilt)*sin(theta) + 88*area*alphaIR)).^(1/4);

%%Survival
TempWS_S = ((1/(area*epsilon*sigma))*(alphaSolar*fluxSum*area*cos(tilt)*sin(theta) + 88*area*alphaIR)).^(1/4);


%%%%EQUINOX
%%Operation
TempE_Op = ((1/(area*epsilon*sigma))*(20 + alphaSolar*fluxSum*area*sin(theta) + 75.5*area*alphaIR)).^(1/4);
%Eclipse


%%Survival
TempE_S = ((1/(area*epsilon*sigma))*(alphaSolar*fluxSum*area*sin(theta) + 75.5*area*alphaIR)).^(1/4);
%Eclipse


%% Plotting
%%%%SUMMER SOLSTICE
%Summer Solstice Operational
figure();
plot(time, TempSS_Op, 'linewidth', 2, 'color', 'r');

yline(20 + 273, 'linewidth', 2);
yline(30 + 273, 'linewidth', 2);

%Summer Solstice Survival
figure();
plot(time, TempSS_S, 'linewidth', 2, 'color', 'r');

yline(-40 + 273, 'linewidth', 2);


%%%%WINTER SOLSTICE
%Operational
figure();
plot(time, TempWS_Op, 'linewidth', 2, 'color', 'r');

yline(20 + 273, 'linewidth', 2);
yline(30 + 273, 'linewidth', 2);

%Survival

figure();
plot(time, TempWS_S, 'linewidth', 2, 'color', 'r');

yline(-40 + 273, 'linewidth', 2);


%%%%EQUINOX
%Operational
figure();
plot(time, TempE_Op, 'linewidth', 2, 'color', 'r');

yline(20 + 273, 'linewidth', 2);
yline(30 + 273, 'linewidth', 2);

%Survival

figure();
plot(time, TempE_S, 'linewidth', 2, 'color', 'r');

yline(-40 + 273, 'linewidth', 2);



