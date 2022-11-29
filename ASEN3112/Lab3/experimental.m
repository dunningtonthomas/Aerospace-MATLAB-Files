%% Clean Up
clear; close all; clc;


%% Import Data
data_2min_all = readmatrix('test_2min_all_3');
data_5min_all = readmatrix('test_5min_all_1');
data_2min_nose = readmatrix('test_2min_nose_3');
data_2min_tail = readmatrix('test_2min_tail_3');
data_2min_wing = readmatrix('test_2min_wing_3');



%% Analysis
%Determine the frequency
%Perform a fourier transform
% plotFFT(data_2min_all, '2 Min All');
% plotFFT(data_5min_all, '5 Min All');
% plotFFT(data_2min_nose, '2 Min Nose');
% plotFFT(data_2min_tail, '2 Min Tail');
% plotFFT(data_2min_wing, '2 Min Wing');


%% Determining the mode shape

%%%%2 min ALL
[timeFinal, frequencies] = calcFrequency(data_2min_all(:,1), data_2min_all(:,2));


%By inspection the sweep starts at frequency 10.8 at 22.1 seconds and ends
%at a frequency of 50 at 120 seconds
logVec = data_2min_all(:,1) > 22.1 & data_2min_all(:,1) < 120;

%Linearly spaced frequency vector for the linear region
hzVec = linspace(10.5, 50, sum(logVec));

%Plotting against frequency
timeTail = data_2min_all(:,1);
ch0Accel = data_2min_all(:,2);
ch1Accel = data_2min_all(:,3);
ch2Accel = data_2min_all(:,4);
ch3Accel = data_2min_all(:,5);
vibDisp = data_2min_all(:,end);

%Need to normalize the ch1Accel by using the shaker acceleration
timeData = timeTail(logVec);
ch0Data = ch0Accel(logVec);
ch1Data = ch1Accel(logVec);
ch2Data = ch2Accel(logVec);
ch3Data = ch3Accel(logVec);
vibData = vibDisp(logVec);

%Getting a running total of the amplitude so we can normalize the response
for i = 1:length(ch1Data)
    currTime = timeData(i);
    
    %Find the amplitude of the shaker frequency in a large enough time
    %interval, use 100 indices plus or minus
    if(i < length(ch1Data) - 100)
        amplitude(i) = max(abs(ch0Data(i:(i+100))));
    else
        amplitude(i) = max(abs(ch0Data((i-100):i)));
    end
end

%Subplot with all of the accelerometers
figure();
subplot(4,1,1)
plot(hzVec, ch1Data ./ amplitude');

xlim([10 49]);
sgtitle('2 Min All Response');
title('Channel 1 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,2)
plot(hzVec, ch2Data ./ amplitude');

xlim([10 49]);
title('Channel 2 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,3)
plot(hzVec, ch3Data ./ amplitude');

xlim([10 49]);
title('Channel 3 Amplitude');
ylabel('Amplitude');


subplot(4,1,4)
plot(hzVec, vibData);

xlim([10 49]);
title('Vibrometer Amplitude');
ylabel('Amplitude');
xlabel('Excitation Frequency (Hz)');


%%%%5 min ALL
[timeFinal, frequencies] = calcFrequency(data_5min_all(:,1), data_5min_all(:,2));

% figure();
% plot(timeFinal, frequencies);
% 
% title('Frequency Over Time Determined by Relative Max');
% xlabel('Time (s)');
% ylabel('Frequency (Hz)');
% 
% xline(54, 'r', 'label', 'Sweep Start');
% xline(300, 'r', 'label', 'Sweep End');


%By inspection the sweep starts at frequency 10.8 at 22.1 seconds and ends
%at a frequency of 50 at 120 seconds
logVec = data_5min_all(:,1) > 54 & data_5min_all(:,1) < 300;

%Linearly spaced frequency vector for the linear region
hzVec = linspace(10.5, 50, sum(logVec));

%Plotting against frequency
timeTail = data_5min_all(:,1);
ch0Accel = data_5min_all(:,2);
ch1Accel = data_5min_all(:,3);
ch2Accel = data_5min_all(:,4);
ch3Accel = data_5min_all(:,5);
vibDisp = data_5min_all(:,end);

%Need to normalize the ch1Accel by using the shaker acceleration
timeData = timeTail(logVec);
ch0Data = ch0Accel(logVec);
ch1Data = ch1Accel(logVec);
ch2Data = ch2Accel(logVec);
ch3Data = ch3Accel(logVec);
vibData = vibDisp(logVec);

%Getting a running total of the amplitude so we can normalize the response
for i = 1:length(ch1Data)
    currTime = timeData(i);
    
    %Find the amplitude of the shaker frequency in a large enough time
    %interval, use 100 indices plus or minus
    if(i < length(ch1Data) - 100)
        amplitude5(i) = max(abs(ch0Data(i:(i+100))));
    else
        amplitude5(i) = max(abs(ch0Data((i-100):i)));
    end
end

%Subplot with all of the accelerometers
figure();
subplot(4,1,1)
plot(hzVec, ch1Data ./ amplitude5');

xlim([10 49]);
sgtitle('5 Min All Response');
title('Channel 1 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,2)
plot(hzVec, ch2Data ./ amplitude5');

xlim([10 49]);
title('Channel 2 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,3)
plot(hzVec, ch3Data ./ amplitude5');

xlim([10 49]);
title('Channel 3 Amplitude');
ylabel('Amplitude');


subplot(4,1,4)
plot(hzVec, vibData);

xlim([10 49]);
title('Vibrometer Amplitude');
ylabel('Amplitude');
xlabel('Excitation Frequency (Hz)');



%%%%NOSE
[timeFinal, frequencies] = calcFrequency(data_2min_nose(:,1), data_2min_nose(:,2));


%By inspection the sweep starts at frequency 10.8 at 22.1 seconds and ends
%at a frequency of 50 at 120 seconds
logVec = data_2min_nose(:,1) > 22.1 & data_2min_nose(:,1) < 120;

%Linearly spaced frequency vector for the linear region
hzVec = linspace(10.5, 50, sum(logVec));

%Plotting against frequency
timeTail = data_2min_nose(:,1);
ch0Accel = data_2min_nose(:,2);
ch1Accel = data_2min_nose(:,3);
ch2Accel = data_2min_nose(:,4);
ch3Accel = data_2min_nose(:,5);
vibDisp = data_2min_nose(:,end);

%Need to normalize the ch1Accel by using the shaker acceleration
timeData = timeTail(logVec);
ch0Data = ch0Accel(logVec);
ch1Data = ch1Accel(logVec);
ch2Data = ch2Accel(logVec);
ch3Data = ch3Accel(logVec);
vibData = vibDisp(logVec);

%Getting a running total of the amplitude so we can normalize the response
for i = 1:length(ch1Data)
    currTime = timeData(i);
    
    %Find the amplitude of the shaker frequency in a large enough time
    %interval, use 100 indices plus or minus
    if(i < length(ch1Data) - 100)
        amplitude(i) = max(abs(ch0Data(i:(i+100))));
    else
        amplitude(i) = max(abs(ch0Data((i-100):i)));
    end
end

%Subplot with all of the accelerometers
figure();
subplot(4,1,1)
plot(hzVec, ch1Data ./ amplitude');

xlim([10 49]);
sgtitle('Nose Response');
title('Channel 1 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,2)
plot(hzVec, ch2Data ./ amplitude');

xlim([10 49]);
title('Channel 2 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,3)
plot(hzVec, ch3Data ./ amplitude');

xlim([10 49]);
title('Channel 3 Amplitude');
ylabel('Amplitude');


subplot(4,1,4)
plot(hzVec, vibData);

xlim([10 49]);
title('Vibrometer Amplitude');
ylabel('Amplitude');
xlabel('Excitation Frequency (Hz)');


%%%%TAIL
[timeFinal, frequencies] = calcFrequency(data_2min_tail(:,1), data_2min_tail(:,2));

%Determine By Inspection where the sweep starts
% figure();
% plot(timeFinal, frequencies);
% 
% title('Frequency Over Time Determined by Relative Max');
% xlabel('Time (s)');
% ylabel('Frequency (Hz)');
% 
% xline(22, 'r', 'label', 'Sweep Start');
% xline(120, 'r', 'label', 'Sweep End');

%By inspection the sweep starts at frequency 10.8 at 22.1 seconds and ends
%at a frequency of 50 at 120 seconds
logVec = data_2min_tail(:,1) > 22.1 & data_2min_tail(:,1) < 120;

%Linearly spaced frequency vector for the linear region
hzVec = linspace(10.5, 50, sum(logVec));

%Plotting against frequency
timeTail = data_2min_tail(:,1);
ch0Accel = data_2min_tail(:,2);
ch1Accel = data_2min_tail(:,3);
ch2Accel = data_2min_tail(:,4);
ch3Accel = data_2min_tail(:,5);
vibDisp = data_2min_tail(:,end);

%Need to normalize the ch1Accel by using the shaker acceleration
timeData = timeTail(logVec);
ch0Data = ch0Accel(logVec);
ch1Data = ch1Accel(logVec);
ch2Data = ch2Accel(logVec);
ch3Data = ch3Accel(logVec);
vibData = vibDisp(logVec);

%Getting a running total of the amplitude so we can normalize the response
for i = 1:length(ch1Data)
    currTime = timeData(i);
    
    %Find the amplitude of the shaker frequency in a large enough time
    %interval, use 100 indices plus or minus
    if(i < length(ch1Data) - 100)
        amplitude(i) = max(abs(ch0Data(i:(i+100))));
    else
        amplitude(i) = max(abs(ch0Data((i-100):i)));
    end
end

%Subplot with all of the accelerometers
figure();
subplot(4,1,1)
plot(hzVec, ch1Data ./ amplitude');

xlim([10 49]);
sgtitle('Tail Response');
title('Channel 1 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,2)
plot(hzVec, ch2Data ./ amplitude');

xlim([10 49]);
title('Channel 2 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,3)
plot(hzVec, ch3Data ./ amplitude');

xlim([10 49]);
title('Channel 3 Amplitude');
ylabel('Amplitude');


subplot(4,1,4)
plot(hzVec, vibData);

xlim([10 49]);
title('Vibrometer Amplitude');
ylabel('Amplitude');
xlabel('Excitation Frequency (Hz)');




%%%%WING
[timeFinal, frequencies] = calcFrequency(data_2min_wing(:,1), data_2min_wing(:,2));


%By inspection the sweep starts at frequency 10.8 at 22.1 seconds and ends
%at a frequency of 50 at 120 seconds
logVec = data_2min_wing(:,1) > 22.1 & data_2min_wing(:,1) < 120;

%Linearly spaced frequency vector for the linear region
hzVec = linspace(10.5, 50, sum(logVec));

%Plotting against frequency
timeTail = data_2min_wing(:,1);
ch0Accel = data_2min_wing(:,2);
ch1Accel = data_2min_wing(:,3);
ch2Accel = data_2min_wing(:,4);
ch3Accel = data_2min_wing(:,5);
vibDisp = data_2min_wing(:,end);

%Need to normalize the ch1Accel by using the shaker acceleration
timeData = timeTail(logVec);
ch0Data = ch0Accel(logVec);
ch1Data = ch1Accel(logVec);
ch2Data = ch2Accel(logVec);
ch3Data = ch3Accel(logVec);
vibData = vibDisp(logVec);

%Getting a running total of the amplitude so we can normalize the response
for i = 1:length(ch1Data)
    currTime = timeData(i);
    
    %Find the amplitude of the shaker frequency in a large enough time
    %interval, use 100 indices plus or minus
    if(i < length(ch1Data) - 100)
        amplitude(i) = max(abs(ch0Data(i:(i+100))));
    else
        amplitude(i) = max(abs(ch0Data((i-100):i)));
    end
end

%Subplot with all of the accelerometers
figure();
subplot(4,1,1)
plot(hzVec, ch1Data ./ amplitude');

xlim([10 49]);
sgtitle('Wing Response');
title('Channel 1 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,2)
plot(hzVec, ch2Data ./ amplitude');

xlim([10 49]);
title('Channel 2 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,3)
plot(hzVec, ch3Data ./ amplitude');

xlim([10 49]);
title('Channel 3 Amplitude');
ylabel('Amplitude');


subplot(4,1,4)
plot(hzVec, vibData);

xlim([10 49]);
title('Vibrometer Amplitude');
ylabel('Amplitude');
xlabel('Excitation Frequency (Hz)');

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
    timeInter = time(timeLog);
    
    %Determine the frequencies
    for i = 2:totalOscillations %Looping through and determining all of the frequencies
        changeTime = timeInter(i) - timeInter(i-1); %Change in time for the oscillation
        frequencies(i-1) = 1 / changeTime;
    end
    
    timeFinal = timeInter(1:end-1);
end


function [fft1, fft2, fft3] = plotFFT(data, titleString)
%Input: The raw data file, title of the plot
%Output: the FFT data for each sensor and a plot with each sensor

%Data
time = data(:,1);
accell0 = data(:,2);

%Normalize data by dividing by the shaker displacement
accell1 = data(:,3);
accell2 = data(:,4);
accell3 = data(:,5);
vib = data(:,end);


%Determine the frequency
%Perform a fourier transform
numData = length(data(:,1)); %Number of data points
sampFreq = length(time) / time(end); %Samples per second


%Performing the fast fourier transform to get into the frequency domain
freqVec = (0:numData-1) * sampFreq / numData;
fft0 = (1/numData) * fft(accell0);
fft1 = (1/numData) * fft(accell1);
fft2 = (1/numData) * fft(accell2);
fft3 = (1/numData) * fft(accell3);
fft4 = (1/numData) * fft(vib);


%Normalize with the shaker accleration
% fft1 = fft1 ./ freqVec';
% fft2 = fft2 ./ freqVec';
% fft3 = fft3 ./ freqVec';
% fft4 = fft4 ./ freqVec';


figure();
subplot(4,1,1)
plot(freqVec, abs(fft1), 'linewidth', 2);

xlim([0 50]);
sgtitle(titleString);
title('Channel 1 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');


subplot(4,1,2)
plot(freqVec, abs(fft2), 'linewidth', 2);

xlim([0 50]);
title('Channel 2 Amplitude');
ylabel('Amplitude');
% xlabel('Frequency (Hz)');

subplot(4,1,3)
plot(freqVec, abs(fft3), 'linewidth', 2);

xlim([0 50]);
title('Channel 3 Amplitude');
ylabel('Amplitude');


subplot(4,1,4)
plot(freqVec, abs(fft4), 'linewidth', 2);

xlim([0 50]);
title('Vibrometer Amplitude');
ylabel('Amplitude');
xlabel('Frequency (Hz)');


end


function actualResponse(data)


end



