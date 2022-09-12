%% Clean Up
clear; close all; clc;


%% Import Data

%Reading in the pressure data
data_d8 = readmatrix('test1_d8');
time_d8 = data_d8(:,1);
pressure_d8 = data_d8(:,2);
topTopTemp_d8 = data_d8(:,3);
topBottomTemp_d8 = data_d8(:,4);
bottomTopTemp_d8 = data_d8(:,5);
bottomBottomTemp_d8 = data_d8(:,6);
current_d8 = data_d8(:,7);
switch_d8 = data_d8(:,8);

data_d10 = readmatrix('test2_d10');
time_d10 = data_d10(:,1);
pressure_d10 = data_d10(:,2);
topTopTemp_d10 = data_d10(:,3);
topBottomTemp_d10 = data_d10(:,4);
bottomTopTemp_d10 = data_d10(:,5);
bottomBottomTemp_d10 = data_d10(:,6);
current_d10 = data_d10(:,7);
switch_d10 = data_d10(:,8);

data_d12 = readmatrix('test3_d12');
time_d12 = data_d12(:,1);
pressure_d12 = data_d12(:,2);
topTopTemp_d12 = data_d12(:,3);
topBottomTemp_d12 = data_d12(:,4);
bottomTopTemp_d12 = data_d12(:,5);
bottomBottomTemp_d12 = data_d12(:,6);
current_d12 = data_d12(:,7);
switch_d12 = data_d12(:,8);


%Reading in the volume data from solidworks
solidData_d8 = xlsread('40.5SmallBottomDisplacement.xlsx');
solidTime_d8 = solidData_d8(:,2);
displacement_d8 = solidData_d8(:,3);


%% Analysis

%Average RPM
rpm_d8 = avgRpm(switch_d8, time_d8);
rpm_d10 = avgRpm(switch_d10, time_d10);
rpm_d12 = avgRpm(switch_d12, time_d12);

%Calculating the average temperature difference, using the bottom of the
%top plate and the top of the bottom plate
tempDiff_d8 = mean(bottomTopTemp_d8 - topBottomTemp_d8);
tempDiff_d10 = mean(bottomTopTemp_d10 - topBottomTemp_d10);
tempDiff_d12 = mean(bottomTopTemp_d12 - topBottomTemp_d12);


%Volume from solid works calculation
%Diameter and area of the face of the power piston
diameter = 15.5; %mm
area = (diameter / 2)^2 * pi;

%Volume of the displacer piston chamber
displacerPistonVol = 342006 - 169312; %mm^3



%Volume change of the power piston
%MOST NEGATIVE corresponds to the power piston at the bottom
test = displacement_d8;
displacement_d8 = displacement_d8 + -1*min(displacement_d8); %mm

%Volume over time is the power piston volume change plus the displacer
%piston volume
volChange = (displacement_d8 * area) + displacerPistonVol;

%Converting to meters cubed
volChange = volChange / (1000^3);

%Converting pressure to pascal
pressure_d8 = pressure_d8 * 6894.76; %Pascals




%% Converting the lab data to fit the sampling rate of the solidworks data

indexVec = zeros(length(time_d8),1); %Vector to store indices corresponding to the time in solidTime
for i = 1:length(solidTime_d8)
    
end





%% Functions

function [avgRpm_dx] = avgRpm(switch_dx, time_dx)
    %This function takes in the optical switch data and the time data and
    %calculates the average RPM
    
    %Getting it so there is only the first one in the optical switch array
    switchFinal_dx = zeros(length(switch_dx),1);

    for i = 2:(length(switch_dx))
        if(switch_dx(i) == 1 && switch_dx(i-1) ~= 1) %Condition for the first 1 
           switchFinal_dx(i) = 1; 
        end
    end

    %Calculating the average rpm
    logVec = switchFinal_dx == 1;
    timeSwitch_dx = time_dx(logVec);

    timeDiff_dx = diff(timeSwitch_dx);

    %Convert to minutes
    timeDiff_dx = timeDiff_dx * 60;

    %RPM Average
    avgRpm_dx = mean(timeDiff_dx);
end
