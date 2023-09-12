% This script loads data of an orbit and the object it is orbiting,
% it then plots the ground tracks for the duration of the orbit
%% Cleal Up
close all; clear; clc;

%% Load in Data
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
m = 10000 / (1.05*N);
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



%% Create Ground Tracks
% [longitude_1, lattitude_1] = groundTracks(rOut_1(1:2000,:), facets, vertices, targets, 'Sat 1');
% [longitude_2, lattitude_2] = groundTracks(rOut_2(1:2000,:), facets, vertices, targets, 'Sat 2');
% [longitude_3, lattitude_3] = groundTracks(rOut_3(1:2000,:), facets, vertices, targets, 'Sat 3');
% [longitude_4, lattitude_4] = groundTracks(rOut_4(1:2000,:), facets, vertices, targets, 'Sat 4');
% [longitude_5, lattitude_5] = groundTracks(rOut_5(1:2000,:), facets, vertices, targets, 'Sat 5');

% [longitude_1, lattitude_1] = groundTracks(rOut_1, facets, vertices, targets, 'Sat 1');
% [longitude_2, lattitude_2] = groundTracks(rOut_2, facets, vertices, targets, 'Sat 2');
% [longitude_3, lattitude_3] = groundTracks(rOut_3, facets, vertices, targets, 'Sat 3');
% [longitude_4, lattitude_4] = groundTracks(rOut_4, facets, vertices, targets, 'Sat 4');
% [longitude_5, lattitude_5] = groundTracks(rOut_5, facets, vertices, targets, 'Sat 5');

%% Ground Tracks Animation
%Call animation
movieVec1 = groundTrackAnimate(rOut_1, facets, vertices, targets, 'Sat 1');
movieVec2 = groundTrackAnimate(rOut_2, facets, vertices, targets, 'Sat 2');
movieVec3 = groundTrackAnimate(rOut_3, facets, vertices, targets, 'Sat 3');
movieVec4 = groundTrackAnimate(rOut_4, facets, vertices, targets, 'Sat 4');
movieVec5 = groundTrackAnimate(rOut_5, facets, vertices, targets, 'Sat 5');


%% Save Animations to a file
%Save animation to a file
vidWrite = VideoWriter('GroundTrackSat1', 'MPEG-4');
vidWrite.FrameRate = 60;

open(vidWrite);
writeVideo(vidWrite, movieVec1);
close(vidWrite);

%2
vidWrite = VideoWriter('GroundTrackSat2', 'MPEG-4');
vidWrite.FrameRate = 60;

open(vidWrite);
writeVideo(vidWrite, movieVec2);
close(vidWrite);

%3
vidWrite = VideoWriter('GroundTrackSat3', 'MPEG-4');
vidWrite.FrameRate = 60;

open(vidWrite);
writeVideo(vidWrite, movieVec3);
close(vidWrite);

%4
vidWrite = VideoWriter('GroundTrackSat4', 'MPEG-4');
vidWrite.FrameRate = 60;

open(vidWrite);
writeVideo(vidWrite, movieVec4);
close(vidWrite);

%5
vidWrite = VideoWriter('GroundTrackSat5', 'MPEG-4');
vidWrite.FrameRate = 60;

open(vidWrite);
writeVideo(vidWrite, movieVec5);
close(vidWrite);







