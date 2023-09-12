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
load('5sc_734712.mat');

%Load targets
warning('off');
load('Target_list.mat');

%Define parameters
N = 5;
m = 1000 / (1.05*N);
A = (5-(1/5)*(N - 1)) / 1000^2;
t0 = 0;
tf = 60*60*24*7; %1 week timespan

%Propogate spacecraft
[Xout_1, OEout_1, Tout_1] = propagate_spacecraft(X0(1,:)', t0, tf, A, m);
[Xout_2, OEout_2, Tout_2] = propagate_spacecraft(X0(2,:)', t0, tf, A, m);
[Xout_3, OEout_3, Tout_3] = propagate_spacecraft(X0(3,:)', t0, tf, A, m);
[Xout_4, OEout_4, Tout_4] = propagate_spacecraft(X0(4,:)', t0, tf, A, m);
[Xout_5, OEout_5, Tout_5] = propagate_spacecraft(X0(5,:)', t0, tf, A, m);

%Get rOut of each sat
rOut_1 = Xout_1(:,1:3);
rOut_2 = Xout_2(:,1:3);
rOut_3 = Xout_3(:,1:3);
rOut_4 = Xout_4(:,1:3);
rOut_5 = Xout_5(:,1:3);


%% Scatter Plot
%Declare spacecrafts
spacecrafts(1:5,1) = struct();
sat_1.Xout = rOut_1;
sat_1.t = Tout_1;
sat_2.Xout = rOut_2;
sat_3.Xout = rOut_3;
sat_4.Xout = rOut_4;
sat_5.Xout = rOut_5;
spacecrafts(1).satNum = sat_1;
spacecrafts(2).satNum = sat_2;
spacecrafts(3).satNum = sat_3;
spacecrafts(4).satNum = sat_4;
spacecrafts(5).satNum = sat_5;

%Function call
visibilityTimeSeries(spacecrafts, vertices, facets, targets);









