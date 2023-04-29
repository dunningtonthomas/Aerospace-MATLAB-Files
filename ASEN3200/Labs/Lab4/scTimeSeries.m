%Time series of the number of spacecraft in view of the targets at any
% given time during the one week time period
%Create a scatter plot similar to part 1 with time on x, target facet index
%on y axis, colorbar indicates the number of spacecraft that can see the
%facet
%% Clean Up
close all; clear; clc;

%% Load Data/Parameters
%Bennu data
fileName = "BennuFull.obj";
[facets, vertices] = read_obj(fileName);

%Satellite position data
load('satellites.mat');

%Get rOut of each sat
rOut_1 = sat1.pos;
rOut_2 = sat2.pos;
rOut_3 = sat3.pos;

%Create vector of rotation of the vertices due to bennu's rotation
t0 = 0;
tf = 60*60*24*7; %1 week timespan
period = 4.297461 * 3600; %Time period of Bennu
angRate = 2*pi / period;
thetaVec = t0*angRate:60*angRate:tf*angRate;


%% Scatter Plot
%Load Data
load('Target_list.mat');

%Number of spacecraft
N = 3;

%Declare spacecrafts
spacecrafts(1:3,1) = struct();
sat_1.Xout = rOut_1;
sat_1.t = Tout_1;
sat_2.Xout = rOut_2;
sat_3.Xout = rOut_3;
spacecrafts(1).satNum = sat_1;
spacecrafts(2).satNum = sat_2;
spacecrafts(3).satNum = sat_3;

%Function call
visibilityTimeSeries(spacecrafts, vertices, facets, targets);









