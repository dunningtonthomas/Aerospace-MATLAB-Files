%Lab 10 Material - signal generation

clear;close all

%Import
load('FilterOutput.mat');

%want to characterize spectrum to 60 kHz (nyquist freq) so fs = 120 kHz
Fs=120000;
Fn=Fs/2;  
%set the sampling period
t=0:1/Fs:2;
%generate your two signals for 1 second
s1=2.5*cos(2*pi*t*20e3);
s2=2.5*cos(2*pi*t*24.8e3);
%generate the product
x = s1 .* s2;
%generate some plots
fig = figure(1);
subplot(321),plot(t(1:150),s1(1:150));grid;axis tight;
title('20kHz Sin');xlabel('time');ylabel('amplitude')
subplot(322),plot(t(1:150),s2(1:150));grid;axis tight;
title('24.8kHz Sin');xlabel('time');ylabel('amplitude')
subplot(3,2,[3 4]),plot(t(1:150),x(1:150));grid;axis tight;
title('Product: 20kHz Sin * 24.8kHz Sin');xlabel('time');ylabel('amplitude')

%compute and display the freq response using the FFT and Matlab app note
% Use next higher power of 2 greater than or equal to 
% length(x) to calculate FFT. 
NFFT= 2^(nextpow2(length(x))); 
% Take fft, padding with zeros so that length(FFTX) is equal to NFFT 
FFTX = fft(x,NFFT); 
% Calculate the numberof unique points 
NumUniquePts = ceil((NFFT+1)/2); 
% FFT is symmetric, throw away second half 
FFTX = FFTX(1:NumUniquePts); 
% Take the magnitude of fft of x 
MX = abs(FFTX); 
% Scale the fft so that it is not a function of the length of x 
MX = MX/length(x); 
% Take the square of the magnitude of fft of x. 
MX = MX.^2; 
% Multiply by 2 because you threw out second half of FFTX above 
MX = MX*2; 
% DC Component should be unique. 
MX(1) = MX(1)/2; 
% Nyquist component should also be unique.
if ~rem(NFFT,2) 
   % Here NFFT is even; therefore,Nyquist point is included. 
   MX(end) = MX(end)/2; 
end 
% This is an evenly spaced frequency vector with NumUniquePts points. 
f = (0:NumUniquePts-1)*Fs/NFFT; 
% Generate the plot, title and labels. 
subplot(325),plot(f,MX);grid;axis tight;
title('Linear Power Spectrum of Product'); xlabel('Frequency (Hz)'); 
ylabel('Power'); 
subplot(326),plot(f,10*log10(MX));grid;axis tight;
title('dB Power Spectrum of Product'); xlabel('Frequency (Hz)'); 
ylabel('Power (dB)'); 

%Last problem
 y = filter(FilterCoeff, 1 ,x);

 %Plotting
figure();
plot(t(1:500), y(1:500), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Filter Output');
title('Filter Response');


%FFT
Y = fft(y);
L = length(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
P1 = 20*log10(P1);
f = Fs*(0:(L/2))/L;

figure();
plot(f,P1, 'linewidth', 2) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("Amplitude")





