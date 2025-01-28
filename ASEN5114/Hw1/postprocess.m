%% Post Process
close all;
t = out.t;
u = out.u;
y = out.y;


%% Plotting
figure();
plot(t, u, 'linewidth', 2, 'color', 'b');
hold on
plot(t, y, 'linewidth', 2, 'color', 'r');

xlabel('Time (s)')
ylabel('Amplitude (V)');
title('Power Amp and Sensor Voltage')
legend('Power Amp (Vp)', 'Sensor (Vs)')


