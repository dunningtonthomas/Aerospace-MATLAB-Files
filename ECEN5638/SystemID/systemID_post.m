%% Post Processing

%% Parse Data
t = out.t;
u = out.u;
y = out.y;

%% FFT
% Compute the FFT
uFFT = fft(u)/length(t);
yFFT = fft(y)/length(t);

% Frequency vector
frequencyVec = 0:2*pi/T:2*pi*(1/Ts - 1/T);

% Truncate everything to be below the nyquist frequency
belowNyquist = frequencyVec <= N*2*pi/T;
uFFT = uFFT(belowNyquist);
yFFT = yFFT(belowNyquist);
frequencyVec = frequencyVec(belowNyquist);

% Define the transfer function
H = yFFT ./ uFFT;

% 

%% Plotting
figure();
plot(t, u, 'linewidth', 2, 'color', 'b')
grid on;
grid minor;
hold on;
plot(t, y, 'linewidth', 2, 'color', 'r')
xlabel('Time (s)')
ylabel('Signal (V)')
title('Signals')
legend('Input', 'Output')

% FFT Plot
figure();
stem(frequencyVec, abs(uFFT), 'filled')
hold on;
stem(frequencyVec, abs(yFFT), 'filled')
xlabel('Frequency (rad/s)')
ylabel('Amplitude');
title('FFT')

% Bode Plot
figure();
semilogx(frequencyVec, db(abs(H)))
grid on
xlabel('Frequency (rad/s)')
ylabel('Amplitude (dB)');
title('Bode Plot')


