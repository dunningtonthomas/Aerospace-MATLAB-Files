

%% Close loop transfer functions
close all; clear; clc
kp = 5;
kd = 0.5;
ki = 0;

sys = tf([kp], [1 (kp+0.5)]);

step(sys);
S = stepinfo(sys, 'SettlingTimeThreshold', 0.05);

ut = -kp*(x - 1);

% figure();
% plot(t, ut, 'linewidth', 2);
% grid on
% xlabel('Time (s)');
% ylabel('u(t) (rad/s)');
% title('Control Over Time');

%% Next Question
clear; close all; clc

kp = 5;
kd = 0.5;
ki = 3;

sys = tf([kp, ki], [1, (kp+0.5), ki]);

[x,t] = step(sys);
S = stepinfo(sys, 'SettlingTimeThreshold', 0.05);

ut = zeros(1,length(t));
delT = t(2) - t(1);
for j = 1:length(t)
    ut(j) = -kp*(x(j) - 1) - ki*trapz(x(1:j) - t(1:j), t(1:j), 1);
end


figure();
plot(t, ut, 'linewidth', 2);
grid on
xlabel('Time (s)');
ylabel('u(t) (rad/s)');
title('Control Over Time');
