% This script loads data of an orbit and the object it is orbiting,
% it then plots the ground tracks for the duration of the orbit
%% Cleal Up
close all; clear; clc;

%% Load in Data
%Bennu data
fileName = "BennuFull.obj";
[facets, vertices] = read_obj(fileName);

%Satellite position data
load('satellites.mat');

%Get rOut of each sat
rOut_1 = sat1.pos;
rOut_2 = sat2.pos;
rOut_3 = sat3.pos;

%% Create Ground Tracks
warning('off');
load('Target_list.mat');
[longitude_1, lattitude_1] = groundTracks(rOut_1(1:2000,:), facets, vertices, targets, 'Sat 1');
[longitude_2, lattitude_2] = groundTracks(rOut_2(1:2000,:), facets, vertices, targets, 'Sat 2');
[longitude_3, lattitude_3] = groundTracks(rOut_3(1:2000,:), facets, vertices, targets, 'Sat 3');





