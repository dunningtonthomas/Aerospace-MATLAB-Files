% ASEN 3113 Lab 2

clc; 
clear all;
close all;

%% Thomas's Code
%% Define Anonymous Functions
H = @(Q, k, A) Q/(k*A);
lambda = @(n) (((2*n)-1)*pi)/(2*L);
b = @(n) -((8*L*H)/(((2*n)-1)^2*(pi^2)))*(-1)^(n+1);

%% Define Constants
L = 5.875*0.0254; % m
alpha = 4.79e-5;

%% Import Data
%Elimnate the T0 thermocouple location, use extrapolation instead to find
%the T0 value
alum26 = readmatrix('Aluminum_26V_250mA');
alum28 = readmatrix('Aluminum_28V_269mA');
brass26 = readmatrix('Brass_26V_245mA');
brass29 = readmatrix('Brass_29V_273mA');
steel = readmatrix('Steel_21V_192mA');

%Getting rid of the T0 experimental values
alum28(:,2) = [];
brass26(:,2) = [];
brass29(:,2) = [];
steel(:,2) = [];



%% Analysis
%Creating a vector of the linear distance corresponding to the
%thermocouples

x1 = 1 + 3/8; %First thermocouple in inches
%Distances that correspond to the temperatures
linDist = [x1, x1 + 0.5, x1 + 1, x1 + 1.5, x1 + 2, x1 + 2.5, x1 + 3, x1 + 3.5];
linDist = linDist * 0.0254; %In meters


%ALUMINIUM 26
%Getting the final steady state values which are located in the last row
alum26_steadyTemps = alum26(end,2:end); %Thermocouple temperatures at steady state

%Performing a linear regression
coeffAlum26 = polyfit(linDist, alum26_steadyTemps, 1);

%Getting the slope
H_alum26 = coeffAlum26(1);
T0_alum26 = coeffAlum26(2);


%ALUMINIUM 28
%Getting the final steady state values which are located in the last row
alum28_steadyTemps = alum28(end,2:end); %Thermocouple temperatures at steady state

%Performing a linear regression
coeffAlum28 = polyfit(linDist, alum28_steadyTemps, 1);

%Getting the slope
H_alum28 = coeffAlum28(1);
T0_alum28 = coeffAlum28(2);


%BRASS 26
%Getting the final steady state values which are located in the last row
brass26_steadyTemps = brass26(end,2:end); %Thermocouple temperatures at steady state

%Performing a linear regression
coeffBrass26 = polyfit(linDist, brass26_steadyTemps, 1);

%Getting the slope
H_brass26 = coeffBrass26(1);
T0_brass26 = coeffBrass26(2);


%BRASS 29
%Getting the final steady state values which are located in the last row
brass29_steadyTemps = brass29(end,2:end); %Thermocouple temperatures at steady state

%Performing a linear regression
coeffBrass29 = polyfit(linDist, brass29_steadyTemps, 1);

%Getting the slope
H_brass29 = coeffBrass29(1);
T0_brass29 = coeffBrass29(2);


%STEEL
%Getting the final steady state values which are located in the last row
steel_steadyTemps = steel(end,2:end); %Thermocouple temperatures at steady state

%Performing a linear regression
coeffSteel = polyfit(linDist, steel_steadyTemps, 1);

%Getting the slope
H_steel = coeffSteel(1);
T0_steel = coeffSteel(2);


%% Analytical Model

k_Alum = 130;
k_Brass = 115;
k_Steel = 16.2;

V_Alum_1 = 26; %V
I_Alum_1 = 0.25; %A
V_Alum_2 = 28;
I_Alum_2 = 0.269;
V_Brass_1 = 26;
I_Brass_1 = 0.245;
V_Brass_2 = 29;
I_Brass_2 = 0.273;
V_Steel = 21;
I_Steel = 0.192;

%Rate of Heat into rod
Q_dot_Alum_1 = V_Alum_1*I_Alum_1;
Q_dot_Alum_2 = V_Alum_2*I_Alum_2;
Q_dot_Brass_1 = V_Brass_1*I_Brass_1;
Q_dot_Brass_2 = V_Brass_2*I_Brass_2;
Q_dot_Steel = V_Steel*I_Steel;

%Analytical H slope
r = (0.5*2.54)/100; %m
A = pi*r^2;
H_an_Alum_1 = (Q_dot_Alum_1/(k_Alum*A));
H_an_Alum_2 = Q_dot_Alum_2/(k_Alum*A);
H_an_Brass_1 = Q_dot_Brass_1/(k_Brass*A);
H_an_Brass_2 = Q_dot_Brass_2/(k_Brass*A);
H_an_Steel = Q_dot_Steel/(k_Steel*A);


%% Plotting
%% Plotting the steady state distribution
%ALUMINIUM 26
%Getting the linear fit
xPlotAlum26 = linspace(0, 0.14);
yPlotAlum26 = polyval(coeffAlum26, xPlotAlum26);

%Getting the analytical fit
yPlotAlum26AN = polyval([H_an_Alum_1, coeffAlum26(2)], xPlotAlum26);

figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(linDist, alum26_steadyTemps, 'filled');
hold on
plot(xPlotAlum26, yPlotAlum26, 'linewidth', 2);
plot(xPlotAlum26, yPlotAlum26AN, 'linewidth', 2);

xlabel('X Distance $$(m)$$');
ylabel('Temperature $$(^\circ C)$$');
title('Steady State Temperature Distribution Aluminium 26V');
legend('Experimental Data', 'Linear Fit', 'Analytical Slope', 'location', 'NW');


%ALUMINIUM 28
%Getting the linear fit
xPlotAlum28 = linspace(0, 0.14);
yPlotAlum28 = polyval(coeffAlum28, xPlotAlum28);

%Getting the analytical fit
yPlotAlum28AN = polyval([H_an_Alum_2, coeffAlum28(2)], xPlotAlum28);

figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(linDist, alum28_steadyTemps, 'filled');
hold on
plot(xPlotAlum28, yPlotAlum28, 'linewidth', 2);
plot(xPlotAlum28, yPlotAlum28AN, 'linewidth', 2);

xlabel('X Distance $$(m)$$');
ylabel('Temperature $$(^\circ C)$$');
title('Steady State Temperature Distribution Aluminium 28V');
legend('Experimental Data', 'Linear Fit', 'Analytical Slope', 'location', 'NW');


%BRASS 26
%Getting the linear fit
xPlotBrass26 = linspace(0, 0.14);
yPlotBrass26 = polyval(coeffBrass26, xPlotBrass26);

%Getting the analytical fit
yPlotBrass26AN = polyval([H_an_Brass_1, coeffBrass26(2)], xPlotBrass26);

figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(linDist, brass26_steadyTemps, 'filled');
hold on
plot(xPlotBrass26, yPlotBrass26, 'linewidth', 2);
plot(xPlotBrass26, yPlotBrass26AN, 'linewidth', 2);

xlabel('X Distance $$(m)$$');
ylabel('Temperature $$(^\circ C)$$');
title('Steady State Temperature Distribution Brass 26V');
legend('Experimental Data', 'Linear Fit', 'Analytical Slope', 'location', 'NW');


%BRASS 29
%Getting the linear fit
xPlotBrass29 = linspace(0, 0.14);
yPlotBrass29 = polyval(coeffBrass29, xPlotBrass29);

%Getting the analytical fit
yPlotBrass29AN = polyval([H_an_Brass_2, coeffBrass29(2)], xPlotBrass29);


figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(linDist, brass29_steadyTemps, 'filled');
hold on
plot(xPlotBrass29, yPlotBrass29, 'linewidth', 2);
plot(xPlotBrass29, yPlotBrass29AN, 'linewidth', 2);

xlabel('X Distance $$(m)$$');
ylabel('Temperature $$(^\circ C)$$');
title('Steady State Temperature Distribution Brass 29V');
legend('Experimental Data', 'Linear Fit', 'Analytical Slope', 'location', 'NW');




%STEEL
%Getting the linear fit
xPlotSteel = linspace(0, 0.14);
yPlotSteel = polyval(coeffSteel, xPlotSteel);

%Getting the analytical fit
yPlotSteelAN = polyval([H_an_Steel, coeffSteel(2)], xPlotSteel);

figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(linDist, steel_steadyTemps, 'filled');
hold on
plot(xPlotSteel, yPlotSteel, 'linewidth', 2);
plot(xPlotSteel, yPlotSteelAN, 'linewidth', 2);

xlabel('X Distance $$(m)$$');
ylabel('Temperature $$(^\circ C)$$');
title('Steady State Temperature Distribution Steel 21V');
legend('Experimental Data', 'Linear Fit', 'Analytical Slope', 'location', 'NW');


%% Gavins Code
%% Model IA
d = [0, 1.375, 1.875, 2.375, 2.875, 3.375, 3.875, 4.375, 4.875]; % in
d = d*0.0254; % Convert to SI

% Anonymous Functions
u = @(T0, H, x) T0 + H*x;
fourier = @(n, x, t) b(n)*sin(lambda(n)*x)*exp(-t*alpha*lambda(n)^2);

N = 10;
time = 2000;
uxt = zeros(1, time);

% Aluminum 1 ---------------------------------------------
alpha_alum = 130 / (960 * 2810);
% Analytical Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_alum26, H_an_Alum_1, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_an_Alum_1, alpha_alum); % Calculate U
    end
    uxt_an(i+1, :) = uxt;
end
UXTA1.a = uxt_an;

% Experimental Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_alum26, H_alum26, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_alum26, alpha_alum); % Calculate U
    end
    uxt_exp(i+1, :) = uxt;
end
UXTA1.e = uxt_exp;

% Aluminum 2 ----------------------------------------------
% Analytical Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_alum28, H_an_Alum_2, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_an_Alum_2, alpha_alum); % Calculate U
    end
    uxt_an(i+1, :) = uxt;
end
UXTA2.a = uxt_an;

% Experimental Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_alum28, H_alum28, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_alum28, alpha_alum); % Calculate U
    end
    uxt_exp(i+1, :) = uxt;
end
UXTA2.e = uxt_exp;

% Brass 1 -------------------------------------------------
alpha_brass = 115 / (380 * 8500);
% Analytical Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_brass26, H_an_Brass_1, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_an_Brass_1, alpha_brass); % Calculate U
    end
    uxt_an(i+1, :) = uxt;
end
UXTB1.a = uxt_an;

% Experimental Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_brass26, H_brass26, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_brass26, alpha_brass); % Calculate U
    end
    uxt_exp(i+1, :) = uxt;
end
UXTB1.e = uxt_exp;

% Brass 2 -------------------------------------------------
% Analytical Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_brass29, H_an_Brass_2, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_an_Brass_2, alpha_brass); % Calculate U
    end
    uxt_an(i+1, :) = uxt;
end
UXTB2.a = uxt_an;

% Experimental Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_brass29, H_brass29, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_brass29, alpha_brass); % Calculate U
    end
    uxt_exp(i+1, :) = uxt;
end
UXTB2.e = uxt_exp;

% Steel -------------------------------------------------
alpha_steel = 16.2 / (500 * 8000);
% Analytical Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_steel, H_an_Steel, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_an_Steel, alpha_steel); % Calculate U
    end
    uxt_an(i+1, :) = uxt;
end
UXTS.a = uxt_an;

% Experimental Data
for i = 0:8
    % Loops thermocouple location
    for t = 1:time
        % Loops time
        uxt(1, t) = u(T0_steel, H_steel, d(1, i+1)) + FourierCoefficients(N, d(1, i+1), t, H_steel, alpha_steel); % Calculate U
    end
    uxt_exp(i+1, :) = uxt;
end
UXTS.e = uxt_exp;

% ===================================================================================================================================

% Plotting
% Aluminum 1 ----------------------------------------------------
figure()
tiledlayout(1, 2);
% Tile 1 - Analytical Data
nexttile
hold on
for i = 1:9
    plot(UXTA1.a(i, :));
end
title('Model IA - Aluminum, 26V & 250mA - Analytical');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Tile 2 - Experimental Data
nexttile
hold on
for i = 1:9
    plot(UXTA1.e(i, :));
end
title('Model IA - Aluminum, 26V & 250mA - Experimental');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Aluminum 2 --------------------------------------------------
figure()
tiledlayout(1, 2);
% Tile 1 - Analytical Data
nexttile
hold on
for i = 1:9
    plot(UXTA2.a(i, :));
end
title('Model IA - Aluminum, 28V & 269mA - Analytical');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Tile 2 - Experimental Data
nexttile
hold on
for i = 1:9
    plot(UXTA2.e(i, :));
end
title('Model IA - Aluminum, 28V & 269mA - Experimental');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Brass 1 --------------------------------------------------
figure()
tiledlayout(1, 2);
% Tile 1 - Analytical Data
nexttile
hold on
for i = 1:9
    plot(UXTB1.a(i, :));
end
title('Model IA - Brass, 26V & 245mA - Analytical');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Tile 2 - Experimental Data
nexttile
hold on
for i = 1:9
    plot(UXTB1.e(i, :));
end
title('Model IA - Brass, 26V & 245mA - Experimental');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Brass 2 --------------------------------------------------
figure()
tiledlayout(1, 2);
% Tile 1 - Analytical Data
nexttile
hold on
for i = 1:9
    plot(UXTB2.a(i, :));
end
title('Model IA - Brass, 29V & 273mA - Analytical');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Tile 2 - Experimental Data
nexttile
hold on
for i = 1:9
    plot(UXTB2.e(i, :));
end
title('Model IA - Brass, 29V & 273mA - Experimental');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Steel --------------------------------------------------
figure()
tiledlayout(1, 2);
% Tile 1 - Analytical Data
nexttile
hold on
for i = 1:9
    plot(UXTS.a(i, :));
end
title('Model IA - Steel, 21V & 192mA - Analytical');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

% Tile 2 - Experimental Data
nexttile
hold on
for i = 1:9
    plot(UXTS.e(i, :));
end
title('Model IA - Steel, 21V & 192mA - Experimental');
xlabel('Time');
ylabel('u(x,t)');
legend('Thermocouple 0', 'Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Thermocouple 5', 'Thermocouple 6', 'Thermocouple 7', 'Thermocouple 8');
hold off

%% Model IB

%% Model II

%% Model III
%Account for variation in the diffusivity values

save('model1B.mat', 'UXTA1', 'UXTA2', 'UXTB1', 'UXTB2', 'UXTS');

%% Functions

function sum = FourierCoefficients(N, x, t, H, alpha)
    L = 5.875*0.0254; % m
    lambda = @(n) (((2*n)-1)*pi)/(2*L);
    b = @(n) -((8*L*H)/(((2*n)-1)^2*(pi^2)))*(-1)^(n+1);
    fourier = @(n, x, t) b(n)*sin(lambda(n)*x)*exp(-t*alpha*lambda(n)^2);
    sum = 0;
    for j = 1:N
        current = fourier(j, x, t);
        sum = sum + current;
    end
end

