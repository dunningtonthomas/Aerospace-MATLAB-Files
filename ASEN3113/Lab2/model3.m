%% Clean up
clear; close all; clc;

%% Import in data

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


%% Setup 
%Create variation in the thermal diffusivity
alpha_alum = 130 / (960 * 2810);
alpha_brass = 115 / (380 * 8500);
alpha_steel = 16.2 / (500 * 8000);

%Create variation of thermal diffusivities to best match the experimental
%results
%Vary with 25% difference +- the original calculated value
alphaVar_alum = linspace(0.5*alpha_alum, 1*alpha_alum, 25);
alphaVar_brass = linspace(0.4*alpha_brass, alpha_brass, 25);
alphaVar_steel = linspace(0.5*alpha_steel, 1.25*alpha_steel, 25);


%Creating Anon funcs
d = [1.375, 1.875, 2.375, 2.875, 3.375, 3.875, 4.375, 4.875]; % in
d = d*0.0254; % Convert to SI
u = @(T0, H, x) T0 + H*x;

%Initial params
N = 10;
time = 2000;
uxt = zeros(1, time);

%Cell array to store the temperatures, each row is a different diffusivity
alphaAlum26Cell = cell(length(alphaVar_alum), 8);

%Getting the initial values
[T0_alum26, H_alum26, ~] = generateConstants(alum26, 0);
[T0_alum28, H_alum28, ~] = generateConstants(alum28, 0);
[T0_brass26, H_brass26, ~] = generateConstants(brass26, 0);
[T0_brass29, H_brass29, ~] = generateConstants(brass29, 0);
[T0_steel, H_steel, ~] = generateConstants(steel, 0);


% -------------------> ALUM 26
%Calculating the analytical solution for model1B, varying the alpha term
for j = 1:length(alphaVar_alum)
for i = 1:8
        % Loops thermocouple location
     for t = 1:time
          % Loops time
          uxt(1, t) = u(T0_alum26, H_alum26, d(1, i)) + FourierCoefficients(N, d(1, i), t, H_alum26, alphaVar_alum(j)); % Calculate U
     end
        uxt_an(i, :) = uxt;
        alphaAlum26Cell{j,i} = uxt;
end
end


% -------------------> ALUM 28
%Calculating the analytical solution for model1B, varying the alpha term
time28 = 3000;
for j = 1:length(alphaVar_alum)
for i = 1:8
        % Loops thermocouple location
     for t = 1:time28
          % Loops time
          uxt(1, t) = u(T0_alum28, H_alum28, d(1, i)) + FourierCoefficients(N, d(1, i), t, H_alum28, alphaVar_alum(j)); % Calculate U
     end
        alphaAlum28Cell{j,i} = uxt;
end
end



% -------------------> BRASS 26
timeBrass = 6000;
%Calculating the analytical solution for model1B, varying the alpha term
for j = 1:length(alphaVar_brass)
for i = 1:8
        % Loops thermocouple location
     for t = 1:timeBrass
          % Loops time
          uxt(1, t) = u(T0_brass26, H_brass26, d(1, i)) + FourierCoefficients(N, d(1, i), t, H_brass26, alphaVar_brass(j)); % Calculate U
     end
        alphaBrass26Cell{j,i} = uxt;
end
end


% -------------------> BRASS 29
timeBrass = 6000;
%Calculating the analytical solution for model1B, varying the alpha term
for j = 1:length(alphaVar_brass)
for i = 1:8
        % Loops thermocouple location
     for t = 1:timeBrass
          % Loops time
          uxt(1, t) = u(T0_brass29, H_brass29, d(1, i)) + FourierCoefficients(N, d(1, i), t, H_brass29, alphaVar_brass(j)); % Calculate U
     end
        alphaBrass29Cell{j,i} = uxt;
end
end



% -------------------> STEEL
timeSteel = 12600;
%Calculating the analytical solution for model1B, varying the alpha term
for j = 1:length(alphaVar_steel)
for i = 1:8
        % Loops thermocouple location
     for t = 1:timeSteel
          % Loops time
          uxt(1, t) = u(T0_steel, H_steel, d(1, i)) + FourierCoefficients(N, d(1, i), t, H_steel, alphaVar_steel(j)); % Calculate U
     end
        alphaSteelCell{j,i} = uxt;
end
end



%% Comparing the analytical results with various alphas to the experimental
%Truncating the data so it runs for the same amount of time as the
%experimental
expTime_alum26 = alum26(:,1);
expTime_alum28 = alum28(:,1);
expTime_brass26 = brass26(:,1);
expTime_brass29 = brass29(:,1);
expTime_steel = steel(:,1);

%Visually determined that figure 7 matched the best, this is the 7th index
%for the alpha value
alpha_alum26Final = alphaVar_alum(7);

%Visually determined that figure 2 matched the best, this is the 2nd index
alpha_alum28Final = alphaVar_alum(2);

%Figure 1 matches best for brass26
alpha_brass26Final = alphaVar_brass(1);

%Also figure 1 for brass29
alpha_brass29Final = alphaVar_brass(1);

%Figure 20 matches best for steel
alpha_steelFinal = alphaVar_steel(20);

%% Plotting


%% Aluminium 26 figures with various alphas

set(0,'defaulttextinterpreter', 'latex');

% for i = 1:length(alphaVar_alum)
%     figure();
%     %Plotting the experimental
%     for j = 2:length(alum26(1,:))
%         plot(expTime_alum26, alum26(:,j), 'k');
%         hold on    
%     end
%     
%     %Plotting the analytical data on top
%     for j = 1:8
%         plot(1:2000, [alphaAlum26Cell{i, j}], 'b');  
%     end
% end

figure();
%Plotting the experimental
    for j = 2:length(alum26(1,:))
        plotExp = plot(expTime_alum26, alum26(:,j), 'k', 'linewidth', 1.5, 'linestyle', '-');
        hold on    
    end

%Plotting the analytical data
for j = 1:8
    plotAnal = plot(1:2000, [alphaAlum26Cell{7,j}], 'b', 'linewidth', 2);
end


title('Aluminium 26V With Optimized Thermal Diffusivity');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotAnal], 'Experimental', 'Analytical', 'location', 'NW');

%% Alum 28 with various alphas 

% for i = 1:length(alphaVar_alum)
%     figure();
%     %Plotting the experimental
%     for j = 2:length(alum28(1,:))
%         plot(expTime_alum28, alum28(:,j), 'k');
%         hold on    
%     end
%     
%     %Plotting the analytical data on top
%     for j = 1:8
%         plot(1:2000, [alphaAlum28Cell{i, j}], 'b');  
%     end
% end
% 
% xlabel('Time ($$s$$)');
% ylabel('Temperature ($$^\circ C$$)');

figure();
%Plotting the experimental
    for j = 2:length(alum28(1,:))
        plotExp = plot(expTime_alum28, alum28(:,j), 'k', 'linewidth', 1.5, 'linestyle', '-');
        hold on    
    end

%Plotting the analytical data
for j = 1:8
    plotAnal = plot(1:3000, [alphaAlum28Cell{2,j}], 'b', 'linewidth', 2);
end

title('Aluminium 28V With Optimized Thermal Diffusivity');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotAnal], 'Experimental', 'Analytical', 'location', 'NW');


%% Brass 26 with various alphas 

% for i = 1:length(alphaVar_brass)
%     figure();
%     %Plotting the experimental
%     for j = 2:length(brass26(1,:))
%         plot(expTime_brass26, brass26(:,j), 'k');
%         hold on    
%     end
%     
%     %Plotting the analytical data on top
%     for j = 1:8
%         plot(1:6000, [alphaBrass26Cell{i, j}], 'b');  
%     end
% end
% 
% xlabel('Time ($$s$$)');
% ylabel('Temperature ($$^\circ C$$)');

figure();
%Plotting the experimental
    for j = 2:length(brass26(1,:))
        plotExp = plot(expTime_brass26, brass26(:,j), 'k', 'linewidth', 1.5, 'linestyle', '-');
        hold on    
    end

%Plotting the analytical data
for j = 1:8
    plotAnal = plot(1:6000, [alphaBrass26Cell{1,j}], 'b', 'linewidth', 2);
end

title('Brass 26V With Optimized Thermal Diffusivity');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotAnal], 'Experimental', 'Analytical', 'location', 'NW');

%% Brass 29 with various alphas 

% for i = 1:length(alphaVar_brass)
%     figure();
%     %Plotting the experimental
%     for j = 2:length(brass29(1,:))
%         plot(expTime_brass29, brass29(:,j), 'k');
%         hold on    
%     end
%     
%     %Plotting the analytical data on top
%     for j = 1:8
%         plot(1:6000, [alphaBrass29Cell{i, j}], 'b');  
%     end
% end
% 
% xlabel('Time ($$s$$)');
% ylabel('Temperature ($$^\circ C$$)');

figure();
%Plotting the experimental
    for j = 2:length(brass29(1,:))
        plotExp = plot(expTime_brass29, brass29(:,j), 'k', 'linewidth', 1.5, 'linestyle', '-');
        hold on    
    end

%Plotting the analytical data
for j = 1:8
    plotAnal = plot(1:6000, [alphaBrass29Cell{1,j}], 'b', 'linewidth', 2);
end

title('Brass 29V With Optimized Thermal Diffusivity');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotAnal], 'Experimental', 'Analytical', 'location', 'NW');


%% Steel with various alphas 

% for i = 1:length(alphaVar_steel)
%     figure();
%     %Plotting the experimental
%     for j = 2:length(steel(1,:))
%         plot(expTime_steel, steel(:,j), 'k', 'linewidth', 2, 'linestyle', '--');
%         hold on    
%     end
%     
%     %Plotting the analytical data on top
%     for j = 1:8
%         plot(1:12600, [alphaSteelCell{i, j}], 'b', 'linewidth', 2);  
%     end
% end
% 
% xlabel('Time ($$s$$)');
% ylabel('Temperature ($$^\circ C$$)');
   

figure();
%Plotting the experimental
    for j = 2:length(steel(1,:))
        plotExp = plot(expTime_steel, steel(:,j), 'k', 'linewidth', 1.5, 'linestyle', '-');
        hold on    
    end

%Plotting the analytical data
for j = 1:8
    plotAnal = plot(1:12600, [alphaSteelCell{20,j}], 'b', 'linewidth', 2);
end

title('Steel 21V With Optimized Thermal Diffusivity');
xlabel('Time ($$s$$)');
ylabel('Temperature ($$^\circ C$$)');
legend([plotExp, plotAnal], 'Experimental', 'Analytical', 'location', 'NW');

%% Functions
%Function to calculated the fourier term of the expression
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


%Functions for calculating the experimental T0 and H values for model1B
function [T0,H,M] = generateConstants(data,plotBool)
    linDist = (1+3/8:.5:1+3/8+7*.5) * .0254;
    dataSS = data(end,2:end);
    p = polyfit(linDist, dataSS, 1);
    T0 = p(2);
    H = p(1);
    [~,M] = findInitialTemp(data,plotBool);
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





