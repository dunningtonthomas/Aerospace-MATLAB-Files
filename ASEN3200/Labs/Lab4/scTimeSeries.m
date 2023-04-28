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


%Looping through every position of the constellation
figure();
for i = 30:30:length(rOut_1(:,1))

    %Rotate Bennu vertices
    rotMat = [cos(thetaVec(i)), -sin(thetaVec(i)), 0; sin(thetaVec(i)), cos(thetaVec(i)), 0; 0, 0, 1];
    for j = 1:length(vertices(:,1))
        vRotated(j,:) = (rotMat * vertices(j,:)')'; 
    end

    %Call check view for spacecraft one and two
    [observable_1, ~, ~] = checkView2(rOut_1(i,:), targets, facets, vRotated, N);
    [observable_2, ~, ~] = checkView2(rOut_2(i,:), targets, facets, vRotated, N);
    [observable_3, ~, ~] = checkView2(rOut_3(i,:), targets, facets, vRotated, N);

    %Total observability
    observable_all = observable_1 | observable_2 | observable_3; %used for scatter point
    observable_total = observable_1 + observable_2 + observable_3; %used for scatter color

    if(sum(observable_all) > 0) %Plot if there is at least one visible
        %Get indicies where it is visible
        indices = find(observable_all')';
        observable_total = observable_total(indices);
    
        scatter(Tout_1(i) *ones(length(indices),1), indices, [], observable_total, 'filled', 'SizeData', 15);
        hold on;
        a = colorbar;
    end
end

%Add labels
xlabel('Time (s)');
ylabel('Target Facet Index');
title('Target Facet Visibility For 1 Week');
a.Label.String = 'Number of Satellites Visible';



