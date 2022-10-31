% ASEN 3113 Lab 2

clc; 
clear all;
close all;

%% Define Constants
L = 5.875*0.0254; % m

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
k = [130,115,16.2];
V = [26,28,26,29,21];
I = [.25,.269,.245,.273,.192];

plotM = false;
alum26str = generateConstants(alum26,V(1),I(1),k(1),plotM);
alum28str = generateConstants(alum28,V(2),I(2),k(1),plotM);
brass26str = generateConstants(brass26,V(3),I(3),k(2),plotM);
brass29str = generateConstants(brass29,V(4),I(4),k(2),plotM);
steelstr = generateConstants(steel,V(5),I(5),k(3),plotM);

%% Plotting Steady State
plotSteadyStateDist(alum26,alum26str,"Aluminum",V(1));
plotSteadyStateDist(alum28,alum28str,"Aluminum",V(2));
plotSteadyStateDist(brass26,brass26str,"Brass",V(3));
plotSteadyStateDist(brass29,brass29str,"Brass",V(4));
plotSteadyStateDist(steel,steelstr,"Steel",V(5));

%% Model IA/IB
u = @(T0, H, x) T0 + H*x;
N = 10;
time = 2000;
linDist = (1+3/8:.5:1+3/8+7*.5) * .0254;
alpha_alum = 130/(2810*960);
alpha_brass = 115/(8500*380);
alpha_steel = 16.2/(8000*500);

UXTA1 = ModelI(alpha_alum, alum26str.T0, alum26str.H_an, alum26str.H, N, linDist, 1800);
UXTA2 = ModelI(alpha_alum, alum28str.T0, alum28str.H_an, alum28str.H, N, linDist, 3000);
UXTB1 = ModelI(alpha_brass, brass26str.T0, brass26str.H_an, brass26str.H, N, linDist, 5000);
UXTB2 = ModelI(alpha_brass, brass29str.T0, brass29str.H_an, brass29str.H, N, linDist, 5000);
UXTS = ModelI(alpha_steel, steelstr.T0, steelstr.H_an, steelstr.H, N, linDist, 13000);

plotUXT(UXTA1, "Aluminum", "26", "250", alum26, "Model I");
plotUXT(UXTA2, "Aluminum", "28", "269", alum28, "Model I");
plotUXT(UXTB1, "Brass", "26", "245", brass26, "Model I");
plotUXT(UXTB2, "Brass", "29", "273", brass29, "Model I");
plotUXT(UXTS, "Steel", "21", "192", steel, "Model I");
%% Model II
%% Plotting Initial Temperatures
T0_II_alum26 = plotInitialDist(alum26,"Aluminum",V(1));
T0_II_alum28 = plotInitialDist(alum28,"Aluminum",V(2));
T0_II_brass26 = plotInitialDist(brass26,"Brass",V(3));
T0_II_brass29 = plotInitialDist(brass29,"Brass",V(4));
T0_II_steel = plotInitialDist(steel,"Steel",V(5));


UXTA1II = ModelII(alpha_alum, T0_II_alum26, alum26str.H_an, alum26str.H, alum26str.M, N, linDist, 1800);
UXTA2II = ModelII(alpha_alum, T0_II_alum28, alum28str.H_an, alum28str.H, alum28str.M, N, linDist, 3000);
UXTB1II = ModelII(alpha_brass, T0_II_brass26, brass26str.H_an, brass26str.H, brass26str.M, N, linDist, 5000);
UXTB2II = ModelII(alpha_brass, T0_II_brass29, brass29str.H_an, brass29str.H, brass29str.M, N, linDist, 5000);
UXTSII = ModelII(alpha_steel, T0_II_steel, steelstr.H_an, steelstr.H, steelstr.M, N, linDist, 13000);

plotUXT(UXTA1II, "Aluminum", "26", "250", alum26, "Model II");
plotUXT(UXTA2II, "Aluminum", "28", "269", alum28, "Model II");
plotUXT(UXTB1II, "Brass", "26", "245", brass26, "Model II");
plotUXT(UXTB2II, "Brass", "29", "273", brass29, "Model II");
plotUXT(UXTSII, "Steel", "21", "192", steel, "Model II");


%%
save('model2', 'UXTA1II', 'UXTA2II', 'UXTB1II', 'UXTB2II', 'UXTSII');
%% Model III

%% Functions
function plotSteadyStateDist(data,cell,name,volts)
    linDist = (1+3/8:.5:1+3/8+7*.5) * .0254;
    dataSS = data(end,2:end);
    
    figure();
    set(0, 'defaulttextinterpreter', 'latex');
    scatter(linDist, dataSS, 'filled');
    hold on
    plot(cell.x, cell.y, 'linewidth', 2);
    plot(cell.x, cell.yAn, 'linewidth', 2);
    grid on

    xlabel('X Distance $$(m)$$');
    ylabel('Temperature $$(^\circ C)$$');
    title(strcat("Steady State Temperature Distribution ",name," ",num2str(volts),"V"));
    legend('Experimental Data', 'Linear Fit', 'Analytical Slope', 'location', 'NW'); 
end

function T0_new = plotInitialDist(data,name,volts)
    linDist = (1+3/8:.5:1+3/8+7*.5) * .0254;
    coefficients = polyfit(linDist, data(1,2:9), 1);
    T0_new = coefficients(1, 2);
    xFit = linspace(0, max(linDist), 1000);
    yFit = polyval(coefficients, xFit);
    slope = coefficients(1, 1)
    figure();
    set(0, 'defaulttextinterpreter', 'latex');
    hold on
    temperatures = zeros(1, 8);
    for i = 1:8
        temperatures(1, i) = (coefficients(1,1)*linDist(1, i)) + coefficients(1, 2);
        plot(linDist(1, i), temperatures(1, i), 'b.', 'MarkerSize', 15);
    end
    grid on
    plot(xFit, yFit, 'r-', 'LineWidth', 2);
    xlabel('X Distance $$(m)$$');
    ylabel('Temperature $$(^\circ C)$$');
    title(strcat("Initial Temperature Distribution ",name," ",num2str(volts),"V"));
    legend('Experimental Data', 'Linear Fit','location', 'NW'); 
    hold off
end

function cell = generateConstants(data,V,I,k,plotBool)
    cell = {};
    
    linDist = (1+3/8:.5:1+3/8+7*.5) * .0254;
    dataSS = data(end,2:end);
    p = polyfit(linDist, dataSS, 1);
    
    Q_dot = V*I;
    r = (0.5*2.54)/100; %m
    A = pi*r^2;

    cell.T0 = p(2);
    cell.H = p(1);
    cell.H_an = (Q_dot/(k*A));
    [~,cell.M] = findInitialTemp(data,plotBool);
    
    cell.x = linspace(0, 0.14);
    cell.y = polyval(p, cell.x);
    cell.yAn = polyval([cell.H_an, p(2)], cell.x);
    cell.linDist = linDist;
end

function [T_0,M] = findInitialTemp(data,plotBool)
    if length(data(1,:)) == 10
        data = data(:,[1,3:end]);
    end
    
    locSS = convlength(1+3/8:.5:1+3/8+7*.5,'in','m');
    temp = data(1,2:end);
    
    p = polyfit(locSS,temp,1);
    M = p(1);
    
    tempSS = polyval(p,[0,locSS]);
    T_0 = tempSS(1);
    
    if plotBool
        figure
        plot(locSS,temp,'o');
        hold on
        plot([0,locSS],tempSS);
        grid on
        title('Temperature VS Location Least Squares Fit');
        xlabel('Linear Distance [m]');
        ylabel('Temperature [C\circ]');
        legend('Input Data','Linear Regression Line','Location','northwest');
    end
end

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



function sum = FourierCoefficientsII(N, x, t, H, alpha, M)
    L = 5.875*0.0254; % m
    lambda = @(n) (((2*n)-1)*pi)/(2*L);
    b = @(H,L,M,n) L.*1.0./pi.^2.*1.0./(n.*2.0-1.0).^2.*(H-M).*(cos(n.*pi).*2.0-pi.*sin(n.*pi)+n.*pi.*sin(n.*pi).*2.0).*4.0;
    
    fourier = @(n, x, t) b(H, L, M, n)*sin(lambda(n)*x)*exp(-t*alpha*lambda(n)^2);
    sum = 0;
    for j = 1:N
        current = fourier(j, x, t);
        sum = sum + current;
    end
end

function UXT = ModelI(alpha, T0, H_an, H, N, linDist, time)
    % Anonymous Functions
    u = @(T0, H, x) T0 + H*x;

    % Analytical Data
    uxt = zeros(1, time);
    for i = 1:8
        % Loops thermocouple location
        for t = 1:time
            % Loops time
            uxt(1, t) = u(T0, H_an, linDist(1, i)) + FourierCoefficients(N, linDist(1, i), t, H_an, alpha); % Calculate U
        end
        uxt_an(i, :) = uxt;
    end
    UXT.a = uxt_an;

    % Experimental Data
    for i = 1:8
        % Loops thermocouple location
        for t = 1:time
            % Loops time
            uxt(1, t) = u(T0, H, linDist(1, i)) + FourierCoefficients(N, linDist(1, i), t, H, alpha); % Calculate U
        end
        uxt_exp(i, :) = uxt;
    end
    UXT.e = uxt_exp;
end

function UXT = ModelII(alpha, T0, H_an, H, M, N, linDist, time)
    % Anonymous Functions
    u = @(T0, H, x) T0 + H*x;

    % Analytical Data
    uxt = zeros(1, time);
    for i = 1:8
        % Loops thermocouple location
        for t = 1:time
            % Loops time
            uxt(1, t) = u(T0, H_an, linDist(1, i)) + FourierCoefficientsII(N, linDist(1, i), t, H_an, alpha, M); % Calculate U
        end
        uxt_an(i, :) = uxt;
    end
    UXT.a = uxt_an;

    % Experimental Data
    for i = 1:8
        % Loops thermocouple location
        for t = 1:time
            % Loops time
            uxt(1, t) = u(T0, H, linDist(1, i)) + FourierCoefficientsII(N, linDist(1, i), t, H, alpha, M); % Calculate U
        end
        uxt_exp(i, :) = uxt;
    end
    UXT.e = uxt_exp;
end

function plotUXT(UXT, metalName, Voltage, Current, rawData, Model)
    % Plotting
    % Aluminum 1 ----------------------------------------------------
    % Graph 1 - Analytical Data
    figure()
    hold on
    set(0, 'defaulttextinterpreter', 'latex');
    for i = 1:8
        plot(UXT.a(i, :), 'b');
        plot(rawData(:, 1), rawData(:, i+1), 'k');
    end
    if Model == "Model I"
        title(strcat("Model IA - ", metalName, ", ", Voltage, "V and ", Current, "mA - Analytical"));
    else
        title(strcat("Model II - ", metalName, ", ", Voltage, "V and ", Current, "mA"));
    end
    xlabel('Time (s)');
    ylabel('u(x,t)');
    legend('Analytical', 'Experimental');
    hold off

    % Graph 2 - Experimental Data
    figure()
    hold on
    set(0, 'defaulttextinterpreter', 'latex');
    for i = 1:8
        plot(UXT.e(i, :), 'b');
        plot(rawData(:, 1), rawData(:, i+1), 'k');
    end
    if Model == "Model I"
        title(strcat("Model IB - ", metalName, ", ", Voltage, "V and ", Current, "mA - Experimental"));
    else
        title(strcat("Model II - ", metalName, ", ", Voltage, "V and ", Current, "mA"));
    end
    xlabel('Time (s)');
    ylabel('u(x,t)');
    legend('Analytical', 'Experimental');
    hold off
end