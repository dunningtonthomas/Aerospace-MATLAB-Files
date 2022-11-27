%% Clean Up
clear; close all; clc;


%% Import Data
data_2min_all = readmatrix('test_2min_all_3');
time2min_all = data_2min_all(:,1);

shakerAccel2min_all = data_2min_all(:,2);

accel1_2min_all = data_2min_all(:,3);
accel2_2min_all = data_2min_all(:,4);
accel3_2min_all = data_2min_all(:,5);

%We don't need to use these columns since they are integrated, use the
%acceleration
shakerDisp_2min_all = data_2min_all(:,6);
disp1_2min_all = data_2min_all(:,7);
disp2_2min_all = data_2min_all(:,8);
disp3_2min_all = data_2min_all(:,9);

laserDisp_2min_all = data_2min_all(:,10);


%% Analysis
%Determine the frequency
[timeFreq, freq_2min_all] = calcFrequency(time2min_all, shakerAccel2min_all);

%Get the displacements in the time interval for each frequency
%Data Cleaning: Start at index 780 for the start of increasing frequency
timeFreq = timeFreq(780:end);
freq_2min_all = freq_2min_all(780:end);



%% Plotting
%Want a plot of the response of the system as a function of excitation
%frequency
figure();



%% Functions
function [timeFinal, frequencies] = calcFrequency(time, accelVec)
    %This function calculates the frequencies using the time and
    %acceleration vector
    
    %Loop through and determine the relative maximum in
    %the acceleration vector
    logVec = zeros(length(accelVec),1);
    for i = 2:length(accelVec)-1
        if(accelVec(i) > accelVec(i-1) && accelVec(i) > accelVec(i+1)) %Condition for relative max
            logVec(i) = 1;        
        end  
    end
    
    %The number of total oscillations of the experiment
    totalOscillations = sum(logVec);
    
    %Relevant times for the maximum
    timeLog = logVec == 1;
    timeFinal = time(timeLog);
    
    %Determine the frequencies
    for i = 2:totalOscillations %Looping through and determining all of the frequencies
        changeTime = timeFinal(i) - timeFinal(i-1); %Change in time for the oscillation
        frequencies(i-1) = 1 / changeTime;
    end
    
end




