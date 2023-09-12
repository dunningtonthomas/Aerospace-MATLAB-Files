%% Clean Up
clear; close all; clc;

%% Prelab Questions

%dec2bin converts the decimal numbers to binary
testSignal = 0:0.25:3.25;

[bins1, volts1] = Voltage2Bin(0, 3.3, 4, testSignal);
[bins2, volts2] = Voltage2Bin(0, 3.3, 8, testSignal);
[bins3, volts3] = Voltage2Bin(0, 3.3, 12, testSignal);

%12 bit 3.3 Vpp 1.65 V offset
minV = 0
maxV = 1.65 + 1.65
range = maxV - minV

LSB = range / 2^12; %Least significant bit
    
%Create an array of the bin values
binVals = minV:LSB:maxV;
binNums = 1:1:length(binVals);

%Create the input sine function
inputVFunc = @(x) 1.65*sin(x) + 1.65;

%Arbitrary array numbers
arrayInput = linspace(0,2*pi, 100);
arrayNums = 1:1:length(arrayInput);
inputV = inputVFunc(arrayInput);


%Calling the function
[binsF, voltsF] = Voltage2Bin(minV, maxV, 12, inputV);


%% Plotting
figure();
plot(testSignal, bins1, 'marker', '.', 'markersize', 20);

xlabel('Signal Voltage');
ylabel('Bin Number');
title('Bin Number vs Voltage 4 Bits');

figure();
plot(testSignal, bins2, 'marker', '.', 'markersize', 20);

xlabel('Signal Voltage');
ylabel('Bin Number');
title('Bin Number vs Voltage 8 Bits');

figure();
plot(testSignal, bins3, 'marker', '.', 'markersize', 20);

xlabel('Signal Voltage');
ylabel('Bin Number');
title('Bin Number vs Voltage 12 Bits');


% figure();
% plot(arrayNums, binsF, 'marker', '.', 'markersize', 20);
% 
% xlabel('Array Number');
% ylabel('Bin Number');
% title('Array Number vs Bin Number for 3.3Vpp 1.65 DC Offset 1 Period');

%% Functions

function [binNums, binVoltage] = Voltage2Bin(min_voltage, max_voltage, numBits, signal)
    %This function determines the bin number in decimal given a
    %voltage signal
    LSB = (max_voltage - min_voltage) / 2^numBits; %Least significant bit
    
    %Create an array of the bin values
    binVals = min_voltage:LSB:max_voltage;
    
    %Determine what bins signal is in
    binNums = zeros(length(signal),1);
    binVoltage = zeros(length(signal),1);
    
    for i = 1:length(signal)
       currVal = signal(i);
       
       %Find the closest bin value
       diffSig = currVal - binVals; 
       validBins = binVals(diffSig >= 0); %Greater than 0 for bins below the value of the signal
       [~,ind] = min(currVal - validBins); %The index where the difference is the smallest
       binNums(i) = ind; %Getting the bin number
       binVoltage(i) = binVals(ind); %Sorting the signal into the binned voltage
    end
    
end


