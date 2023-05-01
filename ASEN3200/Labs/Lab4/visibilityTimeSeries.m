function visibilityTimeSeries(spacecrafts, vertices, facets, targets)
%VISIBILITYTIMESERIES Summary of this function goes here
%This function plots the time series of the visibilty of the target facets
%and in color how many satellites observe the target facet at that time
%step
%INPUTS:
%   spacecrafts = vector of spacecraft objects as defined by Carson in
%   initSatellite
%   
%   Instantiate spacecrafts as follows:
%   spacecrafts(1).satNum = sat_1;
%   spacecrafts(2).satNum = sat_2;
%   spacecrafts(3).satNum = sat_3;
%   
%   Where sat_i is a satellite object as defined by carson 

%Create vector of rotation of the vertices due to bennu's rotation
t0 = 0;
tf = 60*60*24*7; %1 week timespan
period = 4.297461 * 3600; %Time period of Bennu
angRate = 2*pi / period;
thetaVec = t0*angRate:60*angRate:tf*angRate;

%Number of spacecraft
N = length(spacecrafts);

%Get time 
time = spacecrafts(1).satNum.t;


%Looping through every position of the constellation
warning('off');
figure();
for i = 10:10:length(time)

    %Rotate Bennu vertices
    rotMat = [cos(thetaVec(i)), -sin(thetaVec(i)), 0; sin(thetaVec(i)), cos(thetaVec(i)), 0; 0, 0, 1];
    for j = 1:length(vertices(:,1))
        vRotated(j,:) = (rotMat * vertices(j,:)')'; 
    end
    
    %Loop through each spacecraft
    observable = zeros(length(targets),N); %Each column is observability for that spacecraft
    observable_all = zeros(length(targets), 1);
    observable_total = zeros(length(targets), 1);
    for j = 1:N
        %Get sat position
        satXout = spacecrafts(j).satNum.Xout;
        currPos = satXout(i,:);
        [observable(:,j), ~, ~] = checkView2(currPos, targets, facets, vRotated, N);
        observable_all = observable_all | observable(:,j);
        observable_total = observable_total + observable(:,j);
    end


   
    if(sum(observable_all) > 0) %Plot if there is at least one visible
        %Get indicies where it is visible
        indices = find(observable_all')';

        %Get only the visible times
        observable_total = observable_total(indices);

        %Plot visibility points as a scatter plot
        scatter(time(i) *ones(length(indices),1), indices, [], observable_total, 'filled', 'SizeData', 15);
        hold on;
        a = colorbar;
    end
end

%Add labels
xlabel('Time (s)');
ylabel('Target Facet Index');
title('Target Facet Visibility For 1 Week');
a.Label.String = 'Number of Satellites Visible';


end

