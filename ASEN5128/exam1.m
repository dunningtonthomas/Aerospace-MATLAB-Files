close all; clear; clc;

%% Problem 3
a1 = 18.74;
a2 = -6.41;
kp = 0.89;
kd = -0.8;
ki = 0.01;

% Values of feed forward to loop through
kff_vals = linspace(-100, 0, 100);

% Vectors to store the poles of the closed loop tf
poles = zeros(length(kff_vals), 3);

for i = 1:length(kff_vals)
    kff = kff_vals(i);

    % Define numerator and denom of the tf
    numerator = [kp*kd + kp*kff, ki*kd + ki*kff];
    denominator = [1/a2, a1/a2 + kd, kp*kd + kp*kff, ki*kd + ki*kff];

    % Create the tf
    sys = tf(numerator, denominator);

    % Calculate the poles of the denominator
    poles(i,:) = pole(sys);

end

% Create color gradients
red_colors = [linspace(0.2,1,100)', zeros(100,1), zeros(100,1)];
blue_colors = [zeros(100,1), zeros(100,1), linspace(0.2,1,100)'];

% Apply the 'autumn' colormap
colors = cool(length(kff_vals));


figure();
for i = 1:length(poles(:,1))
    pole1 = plot(real(poles(i,1)), imag(poles(i,1)), 'x', 'MarkerSize', 4, 'Color', colors(i,:));
    hold on;
    pole2 = plot(real(poles(i,2)), imag(poles(i,2)), '^', 'MarkerSize', 4, 'Color', colors(i,:));
    pole3 = plot(real(poles(i,3)), imag(poles(i,3)), '.', 'MarkerSize', 20, 'Color', 'g');
end

xlabel('Real Axis')
ylabel('Imaginary Axis')
title('Root Locus')
legend([pole1, pole2, pole3], 'Pole 1', 'Pole 2', 'Pole 3');


% Part 3
% Define numerator and denom of the tf
kff = 0;
numerator = [kp*kd + kp*kff, ki*kd + ki*kff];
denominator = [1/a2, a1/a2 + kd, kp*kd + kp*kff, ki*kd + ki*kff];

% Create the tf
sys = tf(numerator, denominator);

% Calculate the poles of the denominator
pole_part3 = pole(sys);
zero_part3 = zero(sys);


% Define numerator and denom of the tf
kff = a1/a2;
numerator = [kp*kd + kp*kff, ki*kd + ki*kff];
denominator = [1/a2, a1/a2 + kd, kp*kd + kp*kff, ki*kd + ki*kff];

% Create the tf
sys = tf(numerator, denominator);

% Calculate the poles of the denominator
pole_part3_2 = pole(sys);
zero_part3_2 = zero(sys);




