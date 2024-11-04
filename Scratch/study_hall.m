%% Clean
close all; clear; clc;

% 
x = [3, 6, 2, 19, 20, 46, 21, 13];
sin_vec = sin(x);
max_num = max(x);
min_num = min(x);


% 
X = linspace(0, 2*pi, 1000);
Y = cos(X);

figure();
plot(X, Y, 'linewidth', 2, 'color', 'r');
grid on;
xlabel('X values')
ylabel('Y values')
title('Cosine Function')