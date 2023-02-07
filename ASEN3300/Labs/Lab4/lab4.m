%% Clean Up
close all; clear; clc;

%% Prelab 2

fs = 2048;
t = 0:1/fs:1-1/fs;
x = sin(2*pi*t*300);

N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(x):fs/2;

%plot(freq,pow2db(psdx))
plot(freq,10*log10(psdx))
grid on
title("Periodogram Using FFT")
xlabel("Frequency (Hz)")
ylabel('Power/Frequency dB(Vrms^2/Hz)')


%% Question 5
fs = 5000;
t = 0:1/fs:1-1/fs;
x = 0.5 + square(2*pi*t*500,50);

N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(x):fs/2;

%plot(freq,pow2db(psdx))

%Plotting the signal
figure();
plot(t(1:100), x(1:100));

%Plotting the frequency amplitude spectrum
figure();
plot(freq, 20*log10(abs(xdft)));


figure();
plot(freq,10*log10(psdx))
grid on
title("Periodogram Using FFT")
xlabel("Frequency (Hz)")
ylabel('Power/Frequency dB(Vrms^2/Hz)')

