%% Clean up
clear; close all; clc;

%% Problem 5
%Plot the amplitude eand phase response of sallen key filter for given set
%of R and C values
%Output f0, Q, and plot the filter magnitude repsonse, the filter phase
%response, from DC to 60 kHz, use dB scale for magnitude and degrees, use
%log scale for the frequency
R = 335;
C1 = 1e-6;
C2 = 0.1e-6;

Q = 0.5 * sqrt(C1 / C2);
w0 = 1 / (R*sqrt(C1*C2));
f0 = 1 / (2*pi) * w0;

Q = 5;

magResponse = @(w)(20*log10((w0^2 ./ (sqrt((w0^2 - w.^2).^2 + w0^2 * w.^2 ./ Q^2))))); %dB
phaseResponse = @(w)((-1*atan(w*R*sqrt(C1*C2))) * 180/pi); %Degrees

%Create frequency vector
freqVec = linspace(0,60*1000);

%Output result
fprintf('f0 = %f\n', f0);
fprintf('Q = %f\n', Q);

%Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
% subplot(2,1,1);
semilogx(freqVec / (2*pi), magResponse(freqVec), 'linewidth', 2, 'color', 'b');
grid on
hold on
test = xline(1446, 'label', 'f = 1446 Hz', 'LabelVerticalAlignment', 'middle');

xlabel('Frequency (Hz)');
ylabel('Magnitude Response (dB)');
sgtitle('Sallen-Key Bode Plot Q = 5');

% subplot(2,1,2);
% semilogx(freqVec, phaseResponse(freqVec), 'linewidth', 2, 'color', 'r');
% grid on
% 
% xlabel('Frequency (Hz)');
% ylabel('Phase Response $$(^{\circ})$$');




