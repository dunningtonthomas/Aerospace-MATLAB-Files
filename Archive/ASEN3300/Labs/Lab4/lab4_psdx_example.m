%% Example of calculating FFT and PSD, from Matlab's Technical note

% For some background on the FFT in general, I suggest this page:
% https://en.wikipedia.org/wiki/Fast_Fourier_transform

%% Create the signal

% sets the random number generator in matlab to 'default'
rng default      

% set the sampling frequency to 2048 (Hz, or 2048 samples per second).
% Since this is an artificial signal, we can set it to whatever we want
% without changing the signal.
Fs = 2048;       

% create a time vector from 0 to almost 1 second, spaced by dt = 1/Fs (dt = 
% ~0.5 milliseconds)
t = 0:1/Fs:1-1/Fs;

% create the signal: a cosine, amplitude = 1 V, at 300 Hz, and some noise
% randn creates Gaussian-distributed noise (white noise) with sigma = 1 V. 
x = cos(2*pi*300*t) + randn(size(t));

% N is calculated for convenience; simply the length of the signal x.
N = length(x);


%% Calculate the FFT

% now, calculate the FFT of x:

xdft = fft(x);

% remember this output is complex; if you want to plot it directly take the
% abs() first. 

% the FFT above includes both positive frequency and negative frequency
% components. The first half of the output vector covers the positive
% frequencies, and the second half are negative frequencies. The very first
% value is the DC component (f = 0). 
% The FFT components are symmetric: the magnitudes are the same
% for positive and negative frequencies, but the phases are opposite. We
% don't need the negative frequencies, so we can throw them away. 

xdft = xdft(1:N/2+1);


%% Calculate the PSD

% This part is a bit tricky, and involves the definition of the power
% spectral density; details can be found here:
% https://en.wikipedia.org/wiki/Spectral_density#Power_spectral_density
% The "discrete" PSD is the square of the discrete fourier transform (DFT), 
% multiplied by dt^2/T, where T is the duration of the signal. Now 
% dt = 1/Fs, and Fs*T = N, so dt^2/T simplifies to 1/(Fs*N). 

psdx = (1/(Fs*N)) * abs(xdft).^2;

% We threw away the negative frequencies, but they do, in fact, contain
% some of the "energy" of the signal; so we need to multiply by two.

psdx(2:end-1) = 2*psdx(2:end-1);


%% Frequency vector

% finally, we create a frequency vector. The frequencies in the FFT (and
% PSD) are spaced by Fs/N. The frequency vector for the positive 
% frequencies goes from DC (f = 0) to Fs/2. You could also create this 
% vector as follows:
% freq = linspace(0,Fs/2,length(psdx));

freq = 0:Fs/length(x):Fs/2;


%% Plotting

% since this psdx already squared the fft (xdft), it is in power units; to
% plot in dB, take 10*log10:
plot(freq,10*log10(psdx))

grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')

% You will notice that the peak in the PSD at 300 Hz is around -3 dB 
% (slightly off due to the added noise). The PSD plots the spectrum of the 
% signal in RMS; hence the equivalent linear magnitude of this peak is 0.5.
% Since the sinusoidal signal has an amplitude of 1 V, its Vrms = 0.707, 
% and Vrms^2 = 0.5.

ylabel('Power/Frequency dB(Vrms^2/Hz)')

