%% 
close all; clear; clc;

%% Experiment
Ts = 1;
T = 10;
tVec = 0:Ts:T-Ts;

% Control input
omega = 2;
inputSignal = cos(omega * 2*pi / T * tVec);

% Calculate the FFT
signalFFT = fft(inputSignal);

% Frequency vector
frequencyVec = 0:2*pi/T:2*pi*(1/Ts - 1/T);

%% Plotting 
figure();
plot(tVec, inputSignal);

figure();
stem(frequencyVec, abs(signalFFT) ./ length(tVec)); 
% no longer scales with the length of the time vector when we normalize


