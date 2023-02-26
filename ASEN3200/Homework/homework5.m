%% Clean Up
close all; clear; clc;

%% Problem 1
tVals = linspace(0,3,100);
thet1 = @(t)(5*exp(-4*t) - 2*exp(-2*t));
thet2 = @(t)(exp(-2*t) - 1.25*exp(-4*t) + 0.25);
thet3 = @(t)(0.25*t + 0.1875 + 0.3125*exp(-4*t) - 0.5*exp(-2*t));

sys = tf([3 2], [1 6 8]);
s = tf('s');
G = 0.5/(s^2 + 0.25);

impulse(G*sys)


figure();
plot(tVals, thet1(tVals), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Amplitude');
title('Impulse Response');

figure();
plot(tVals, thet2(tVals), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Amplitude');
title('Step Response');

figure();
plot(tVals, thet3(tVals), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Amplitude');
title('Ramp Response');

%% Problem 2

sys2Func = @(kp)(tf([kp], [1, 8, kp]));

[~, ~, P1] = damp(sys2Func(7));
[~, ~, P2] = damp(sys2Func(15));
[~, ~, P3] = damp(sys2Func(16));
[~, ~, P4] = damp(sys2Func(17));
[~, ~, P5] = damp(sys2Func(64));

ST = 0.05;
figure();
step(sys2Func(7));
stepinfo(sys2Func(7),'SettlingTimeThreshold',ST)
title('Kp = 7');
figure();
step(sys2Func(15));
stepinfo(sys2Func(15),'SettlingTimeThreshold',ST)
title('Kp = 15');
figure();
step(sys2Func(16));
stepinfo(sys2Func(16),'SettlingTimeThreshold',ST)
title('Kp = 16');
figure();
step(sys2Func(17));
stepinfo(sys2Func(17),'SettlingTimeThreshold',ST)
title('Kp = 17');
figure();
step(sys2Func(64));
stepinfo(sys2Func(64),'SettlingTimeThreshold',ST)
title('Kp = 64');

figure();
plot(P1, [0;0], 'marker', '.', 'markersize', 20, 'linestyle', 'none');
hold on
plot(P2, [0;0], 'marker', '.', 'markersize', 20, 'linestyle', 'none');
plot(P3, [0;0], 'marker', '.', 'markersize', 20, 'linestyle', 'none');
plot(real(P4), imag(P4), 'marker', '.', 'markersize', 20, 'linestyle', 'none');
plot(real(P5), imag(P5), 'marker', '.', 'markersize', 20, 'linestyle', 'none');

legend('Kp = 7','Kp = 15','Kp = 16','Kp = 17','Kp = 64');
xlabel('Real');
ylabel('Imaginary');
title('Root Locus Plot');

%% Last problem
sysFinal = @(kd)(tf([kd 15], [1 (8+kd) 15]));

figure();
step(sysFinal(10));
title('Kp = 15, Kd = 10');

figure();
step(sysFinal(1));
title('Kp = 15, Kd = 1');

figure();
step(sysFinal(0.1));
title('Kp = 15, Kd = 0.1');



