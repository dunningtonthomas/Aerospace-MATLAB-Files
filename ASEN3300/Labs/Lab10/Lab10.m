%% CLean Up
close all; clear; clc;

%% Import Data
load('FilterOutput.mat');

%% Plotting
freqz(FilterCoeff,1,1000,120e3)



