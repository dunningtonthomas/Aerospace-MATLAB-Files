%% Clean up
%clear; close all; clc;

%% Analysis

%Calling the aeroCostForTrim function


trim_variables = [0.2; 0.1; 0];
trim_definition = [100; 500];


cost = AeroCostForTrim(trim_variables, trim_definition, aircraft_parameters);

