%% Clean
close all; clear; clc;

%% Constants
Rm = 19.2;                  % ohm
Lm = 1.9 / 1000;            % H
Kt = 40.1 / 1000;           % Nm/A
Jm = 12.5 / (1000 * 100^2); % kgm^2
Kb = 1/238 * 1/(2*pi) * 60; % V/(rad/s)
N = 10 * 120 / 36;

% Load moment of inertia
% Brass
b1 = 1.9;
b2 = 1.5;
b3 = 3.8;
b_rho = 8.73;
b_mass = 2 * b1*b2*b3 * b_rho / 1000;   % kg
r_brass = 26.5 / 100;                   % m
I_brass = b_mass * r_brass^2;           % kg m^2

% Aluminium
a1 = 1.1;
a2 = 0.6;
a3 = 27.5;
a_rho = 2.7;
a_mass = a1*a2*a3 * a_rho / 1000;       % kg
r_aluminium = a3 / 2 / 100;             % m
I_aluminium = a_mass * r_aluminium^2;   % kgm^2

% Aluminium square
a_mass_2 = 16 * 0.6 * a_rho / 1000;
I_aluminium_2 = 1/12 * a_mass_2 * ((4/100)^2 + (4/100)^2);

Jl = I_brass + I_aluminium + I_aluminium_2;
Jeq = Jl + N^2 * Jm;

% Potentionmeter scale factor
dataKs = [-pi/2, 1.25; 0, 2.488; pi/2, 3.76];
coeff = polyfit(dataKs(:,1), dataKs(:,2), 1);
xPlot = linspace(-pi, pi, 100);
yPlot = polyval(coeff, xPlot);
Ks = coeff(1);

%% Transfer function thetaL Vp
num_thetaVp = [-1];
den_thetaVP = [Jeq*Lm / (Kt*N), Jeq*Rm / (Kt*N), Kb*N, 0];

%% Transfer function theta R and theta L
Gp = -10;
Gd = -0.1;

% Call the simulink model
output = sim('thetaRef_thetaL.slx');
t = output.t;
thetaR = output.thetaR;
thetaL = output.thetaL;
Vp = output.Vp;



%% Plotting
% figure();
% plot(xPlot, yPlot, 'linewidth', 2);
% hold on;
% scatter(dataKs(:,1), dataKs(:,2), 'filled')
% grid on
% xlabel('Angle (rad)')
% ylabel('Voltage (V)')
% title('Potentiometer Voltage vs Angle')
% legend('Linear Regression', 'Data Points')

figure();
plot(t, thetaR, 'b-', 'LineWidth', 2); % Blue solid line, thicker
hold on;
plot(t, thetaL, 'r', 'LineWidth', 2); % Red dashed line, thicker

xlabel('Time (s)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Amplitude (rad)', 'FontSize', 12, 'FontWeight', 'bold');
title('Sinusoid Response 2 Hz', 'FontSize', 14, 'FontWeight', 'bold');

legend('\theta_R', '\theta_L', 'Location', 'best', 'FontSize', 10);
grid on; % Enable grid for better readability
xlim([min(t), max(t)]); % Adjust x-axis limits based on data
ylim auto; % Auto-scale y-axis
set(gca, 'FontSize', 12, 'LineWidth', 1.5); % Improve axis appearance


