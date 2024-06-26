%% Clean up
clear; close all; clc;


%% Import Data
%Temp in celsius
temperatures = [17.6, 21.61, 25.13, 29.22, 34.92, 38.10, 45.21, 47.01];
x1 = 1 + 3/8; %in
%Distances that correspond to the temperatures
linDist = [x1, x1 + 0.5, x1 + 1, x1 + 1.5, x1 + 2, x1 + 2.5, x1 + 3, x1 + 3.5];


%% Analysis
%Finding a linear regression
coeff = polyfit(linDist, temperatures, 1);
xFit = linspace(1, x1 + 4);
yFit = polyval(coeff, xFit); 

%Calculating the T0 which occurs when the x distance is 0
tempInitial = polyval(coeff, 0);



%Finding the mean of the residuals
resid = temperatures - polyval(coeff, linDist);
standardD = std(resid);


%% Problem 5

H = coeff(1) / 0.0254; %Converting to Celsius / m
T0 = coeff(2) + 273.15;
alpha = 4.82e-5;
L = 5.875 * 0.0254; %Length in meters
x = 4.875 * 0.0254; %Position of the last thermocouple



%Calculating the temperature over time using the fourier series
t = 1:1000;

u1 = zeros(11,1); %Temperature values

%Calculating without the sum
u1(1) = T0 + H*x;

%Setting t equal to 1 second
t = 1;
%Calculating the sum for n = 1 to 10
for i = 1:10
    sum = 0;
    for n = 1:i
        bn = (8*H*L*(-1)^n) / ((2*n-1)^2 * pi^2);
        lambdaN = ((2*n-1)*pi) / (2*L);
        sum = sum + bn*sin(lambdaN*x)*exp(-(lambdaN^2) * alpha * t);
    end
u1(i + 1) = T0 + H*x + sum;
end


%Temperature at t=1000
u2 = zeros(11,1); %Temperature values

%Calculating without the sum
u2(1) = T0 + H*x;

%Setting t equal to 1 second
t = 1000;
%Calculating the sum for n = 1 to 10
for i = 1:10
    sum = 0;
    for n = 1:i
        bn = (8*H*L*(-1)^n) / ((2*n-1)^2 * pi^2);
        lambdaN = ((2*n-1)*pi) / (2*L);
        sum = sum + bn*sin(lambdaN*x)*exp(-(lambdaN^2) * alpha * t);
    end
u2(i + 1) = T0 + H*x + sum;
end





%% Problem 5 part 2, find the Fourier number

%Use one term and calculate the time it takes to get to 98% of the steady
%state value and this is the time to use in the equation

%Calculate the fourier number for 1 through 1000 values
times = 1:1000;

F0 = alpha * times / L^2;

%Find when the time is 0.2 for fourier number
timeCrit = 0.2 / alpha * L^2;

%% Problem 6
%Use one Fourier term and plot the temperature over time for the last
%thermocouple

%One term fourier
t = 1:1000;
n = 1;
bn = (8*H*L*(-1)^n) / ((2*n-1)^2 * pi^2);
lambdaN = ((2*n-1)*pi) / (2*L);
sum = bn*sin(lambdaN*x)*exp(-(lambdaN^2) * alpha * t);

uOneTerm = T0 + H*x + sum;


%Now account for variations in the thermal diffusivity
uAlpha = zeros(length(t), 10); %Will test 10 different values of alpha
lowerLim = alpha * 0.35;
upperLim = alpha * 1.85;
alphaVar = linspace(lowerLim, upperLim, 10); %Varying alphas

for i = 1:length(alphaVar)
    n = 1;
    bn = (8*H*L*(-1)^n) / ((2*n-1)^2 * pi^2);
    lambdaN = ((2*n-1)*pi) / (2*L);
    sum = bn*sin(lambdaN*x)*exp(-(lambdaN^2) * alphaVar(i) * t);

    uAlpha(:,i) = T0 + H*x + sum;  
end



%% Plotting
figure();
set(0,'defaulttextinterpreter', 'latex');
scatter(linDist, temperatures, 'filled');
hold on
plot(xFit, yFit, 'linewidth', 2);

xlabel('Distance $$(in)$$');
ylabel('Temperature $$(^{\circ}C)$$');
title('Temperature Distribution');

legend('Experimental Data', 'Linear Fit', 'location', 'Nw');



%Plotting the temperatures versus the n values of the sum for t=1 second
figure();
plot(0:10, u1, 'linewidth', 2);
hold on
plot(0:10, u2, 'linewidth', 2);

legend('Time = 1 s', 'Time = 1000 s');
xlabel('Number of Fourier Terms (n)');
ylabel('Temperature (K)');



%Plotting the last thermocouple over time
figure();
plot(t, uOneTerm, 'linewidth', 2, 'color', 'r');

xlabel('Time (s)');
ylabel('Temperature $$(^{\circ}K)$$');
title('Temperature of the Last Thermocouple Over Time');


%Plotting different alpha values over time
%Create a color gradient of blue
colors = zeros(length(alphaVar),3);
colors(:,2) = linspace(1,0.5,length(alphaVar));
colors(:,3) = linspace(0.75,1,length(alphaVar));

figure();
for i = 1:length(alphaVar)
   h(i) = plot(t, uAlpha(:,i), 'color', colors(i,:), 'linewidth', 2);
   hold on
    
end

xlabel('Time $$(s)$$');
ylabel('Temperature $$(^{\circ}K)$$');
title('Variation in Thermal Diffusivity');

legend(h([1,10]), 'Lowest Thermal Diffusivity', 'Highest Thermal Diffusivity', 'location', 'SE');


%Plotting problem 5 fourier numbers
figure();
plot(times, F0, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Fourier Number');
yline(0.2, 'color', 'r', 'label', 'Valid for One Term: F_{0} \geq 0.2');

title('Fourier Number With Different Time Durations');




