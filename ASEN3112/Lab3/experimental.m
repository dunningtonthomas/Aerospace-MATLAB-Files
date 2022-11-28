%% Clean Up
clear; close all; clc;


%% Import Data
data_2min_all = readmatrix('test_2min_all_3');
data_5min_all = readmatrix('test_5min_all_1');
data_2min_nose = readmatrix('test_2min_nose_3');
data_2min_tail = readmatrix('test_2min_tail_3');


%% Analysis
%Determine the frequency
%Perform a fourier transform
plotFFT(data_2min_all, '2 Min All');
plotFFT(data_5min_all, '5 Min All');
plotFFT(data_2min_nose, '2 Min Nose');
plotFFT(data_2min_tail, '2 Min Tail');



%% Functions

%NOT USING THIS FUNCTION CURRENTLY
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


function [fft1, fft2, fft3] = plotFFT(data, titleString)
%Input: The raw data file, title of the plot
%Output: the FFT data for each sensor and a plot with each sensor

%Data
time = data(:,1);
accell1 = data(:,3);
accell2 = data(:,4);
accell3 = data(:,5);


%Determine the frequency
%Perform a fourier transform
numData = length(data(:,1)); %Number of data points
sampFreq = length(time) / time(end); %Samples per second


%Performing the fast fourier transform to get into the frequency domain
freqVec = (0:numData-1) * sampFreq / numData;
fft1 = (1/numData) * fft(accell1);
fft2 = (1/numData) * fft(accell2);
fft3 = (1/numData) * fft(accell3);


figure();
subplot(3,1,1)
plot(freqVec, abs(fft1), 'linewidth', 2);

xlim([0 50]);
sgtitle(titleString);
title('Channel 1 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(3,1,2)
plot(freqVec, abs(fft2), 'linewidth', 2);

xlim([0 50]);
title('Channel 2 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');

subplot(3,1,3)
plot(freqVec, abs(fft3), 'linewidth', 2);

xlim([0 50]);
title('Channel 3 Amplitude');
ylabel('Amplitude');
xlabel('Frequency (Hz)');


end



