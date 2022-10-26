%% Clean up
close all; clear; clc;


%% Analysis
%Initial aircraft state
V = 19;
h = 600;
wind = [0;0;0];
aircraft_parameters = aircraftParamFunc();

[trim_variables, fval] = CalculateTrimVariables([V; h], aircraft_parameters);



