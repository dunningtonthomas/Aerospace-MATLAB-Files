%% ASEN 3111 - Computational Assignment 1 - Main
%Problem 1: Compute the sectional lift and drag coefficients and determine
%the number of panels to achieve less than 1 percent error
%
%Problem 2: Computer the lift and drag per span with an airfoil given a Cp
%model for the upper and lower surface of the airfoil, the determine the
%required number of integration points required to be below 1 percent error
%
%This code is the driver to solve the above problems and implements the
%trapezoid and simpsons rule to integrate
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson
% Date: 2/7/2023

%% Clean Up
close all; clear; clc;

%% Problem 1 -- Analytical and Numerical Calculation
fprintf("-----------Problem 1-----------\n");

%Printing analytically determined values for the coefficients
cl = 2*pi;
cd = 0;
fprintf("Analytical sectional lift and drag coefficients:\n\t cl: 2\x03c0 \n\t cd: 0\n");

%%%%Numerical integration with the trapezoidal composite method
%Anonymous function for the coefficient of pressure with the given
%circulation
Cl_int = @(th)(2*(sin(th).^3 + sin(th).^2));
Cd_int = @(th)(2*(cos(th).*(sin(th).^2 + sin(th))));

%Computing the coefficient 50 times from 1 to 50 discretizations of the
%cylinder
N = 1:10; %The number of panels

%Storing the value of the integrations
Cl_int_trapz = zeros(length(N),1);
Cd_int_trapz = zeros(length(N),1);

%Storing the relative error
trapzRelError = zeros(length(N),1);

%Looping through different N values
for i = N
    Cl_int_trapz(i) = trapzFunc(Cl_int, [0 2*pi], i);
    Cd_int_trapz(i) = trapzFunc(Cd_int, [0 2*pi], i);
    
    %Calculating the relative error
    trapzRelError(i) = ((Cl_int_trapz(i) - double(cl)) / double(cl)) * 100;
end

%%%%Numerical Integration with the simpson's composite method
test = simpFunc(Cl_int, [0 2*pi], 10);

%Storing the value of the integrations
Cl_int_simp = zeros(length(N),1);
Cd_int_simp = zeros(length(N),1);

%Storing the relative error
simpRelError = zeros(length(N),1);

%Looping through different N values
for i = N
    Cl_int_simp(i) = simpFunc(Cl_int, [0 2*pi], i);
    Cd_int_simp(i) = simpFunc(Cd_int, [0 2*pi], i);
    
    %Calculating the relative error
    simpRelError(i) = ((Cl_int_simp(i) - double(cl)) / double(cl)) * 100;
end

%% Problem 1 -- Plotting
%%%%Trapz
figure();
set(0, 'defaulttextinterpreter', 'latex');
%Cl versus N discretizations
plot(N, double(cl)*ones(length(N),1), 'color', 'g', 'linewidth', 2)
grid on
hold on
plot(N, Cl_int_trapz, 'linewidth', 2, 'linestyle', 'none', 'marker', '.', 'markersize', 15, 'color', 'k');

xlabel('Number of Panels to Discretize');
ylabel('Sectional Lift Coefficient $$cl$$');
title('Problem 1: Sectional Lift Coefficient versus Number of Panels Trapezoid');
legend('Analytical Integration', 'Numerical Integration', 'location', 'se');

figure();
%Cd versus N discretizations
plot(N, double(cd)*ones(length(N),1), 'color', 'g', 'linewidth', 2)
grid on
hold on
plot(N, Cd_int_trapz, 'linewidth', 2, 'linestyle', 'none', 'marker', '.', 'markersize', 15, 'color', 'k');

xlabel('Number of Panels to Discretize');
ylabel('Sectional Drag Coefficient $$cd$$');
title('Problem 1: Sectional Drag Coefficient versus Number of Panels Trapezoid');
legend('Analytical Integration', 'Numerical Integration', 'location', 'se');


%%%%Simpz
figure();
set(0, 'defaulttextinterpreter', 'latex');
%Cl versus N discretizations
plot(N, double(cl)*ones(length(N),1), 'color', 'g', 'linewidth', 2)
grid on
hold on
plot(N, Cl_int_simp, 'linewidth', 2, 'linestyle', 'none', 'marker', '.', 'markersize', 15, 'color', 'k');

xlabel('Number of Panels to Discretize');
ylabel('Sectional Lift Coefficient $$cl$$');
title('Problem 1: Sectional Lift Coefficient versus Number of Panels Simpsons');
legend('Analytical Integration', 'Numerical Integration', 'location', 'ne');

figure();
%Cd versus N discretizations
plot(N, double(cd)*ones(length(N),1), 'color', 'g', 'linewidth', 2)
grid on
hold on
plot(N, Cd_int_simp, 'linewidth', 2, 'linestyle', 'none', 'marker', '.', 'markersize', 15, 'color', 'k');

xlabel('Number of Panels to Discretize');
ylabel('Sectional Drag Coefficient $$cd$$');
title('Problem 1: Sectional Drag Coefficient versus Number of Panels Simpsons');
legend('Analytical Integration', 'Numerical Integration', 'location', 'ne');


%Looping through and finding the first index where the error is less than 1
%percent

%Trapz
j = 1;
while(abs(trapzRelError(j)) > 1)
    %Updating iterator
    j = j + 1;
end
%Required panels for less than 1 percent relative error
trapzN = j;

%Simp
j = 1;
while(abs(simpRelError(j)) > 1)
    %Updating iterator
    j = j + 1;
end
%Required panels for less than 1 percent relative error
simpN = j;

%Printing to the command window
fprintf('Number of panels required for less than 1 percent error with Trapezoid: %i \n', trapzN); 
fprintf('Number of panels required for less than 1 percent error with Simpsons: %i \n\n', simpN); 

%% Problem 2 -- Lift and Drag Calculation
fprintf("-----------Problem 2-----------\n");

%Loading Data
load('Cp.mat');

%Defining constants
chord = 3; %m
aoa = 10 * pi /180; %rads
Vinf = 50; %m/s
rho = 1.225; %kg/m^3
Pinf = 101.3 * 10^3; %pa
Qinf = 0.5*rho*Vinf^2; %Dynamic Pressure

%Getting Cp from the structs
xVals = linspace(0, 3, 10000); %100 values across the chord
upperCp = fnval(Cp_upper, xVals ./ 3);
lowerCp = fnval(Cp_lower, xVals ./ 3);

%Calculating the pressures from the coefficient of pressures
pUpper = (upperCp * Qinf);
pLower = (lowerCp * Qinf);

%Defining the thickness of the airfoil
y_tupper = @(x) ((.12*3)/.2)*(.2969.*sqrt(x./3)-.1260.*(x./3)-(.3516.*(x./3).^2)+(.2843.*(x./3).^3)-(.1036.*(x./3).^4));
y_tlower = @(x) -1*((0.12*3/0.2)*(0.2969*sqrt(x./3) - 0.1260*(x./3) - 0.3516*(x./3).^2 + 0.2843*(x./3).^3 - 0.1036*(x./3).^4));

%Integrating to get the upper Normal force
%Defining the x values from 0 to 3
PuSum = pUpper(2:end) + pUpper(1:end-1);
Nupper = -1*sum(PuSum/2 .* diff(xVals));

%Integrating to get the lower Normal force
PlSum = pLower(2:end) + pLower(1:end-1);
Nlower = sum(PlSum/2 .* diff(xVals)); %Flip the sign

%Find the net normal force force
Nnet = Nupper + Nlower;

%Integrating to find the axial force
yValsUpper = y_tupper(xVals); %Y values
yValsLower = y_tlower(xVals); %Y values
deltaY = yValsUpper(2:end) - yValsUpper(1:end-1);

%Axial Force Calculation
Aupper = sum(PuSum / 2 .* diff(yValsUpper));
Alower = -1*sum(PlSum / 2 .* diff(yValsLower));

%Net
Anet = Aupper + Alower;

%Calculate lift and drag
Lift = Nnet * cos(aoa) - Anet * sin(aoa);
Drag = Nnet * sin(aoa) + Anet * cos(aoa);

%Printing to the command window
fprintf('Lift: %f N/m\n', Lift); 
fprintf('Drag: %f N/m\n', Drag); 


%% PROBLEM 2 --- Error Calculation
%Initializing the lift and drag vectors as well as the error
liftVec = zeros(length(xVals),1);
dragVec = zeros(length(xVals),1);
liftError = zeros(length(xVals),1);
dragError = zeros(length(xVals),1);

%Exact solutions based on our maximum number of points
liftExact = Lift;
dragExact = Drag;

%Looping through different numbers of points up to 10000
for i = 1:length(xVals)
    %Getting Cp from the structs
    xVals = linspace(0, 3, i); %i values across the chord
    upperCp = fnval(Cp_upper, xVals ./ 3);
    lowerCp = fnval(Cp_lower, xVals ./ 3);
    
    %Calculating the pressures from the coefficient of pressures
    pUpper = (upperCp * Qinf);
    pLower = (lowerCp * Qinf);

    %Integrating to get the upper Normal force
    %Defining the x values from 0 to 3
    PuSum = pUpper(2:end) + pUpper(1:end-1);
    Nupper = -1*sum(PuSum/2 .* diff(xVals));
    
    %Integrating to get the lower Normal force
    PlSum = pLower(2:end) + pLower(1:end-1);
    Nlower = sum(PlSum/2 .* diff(xVals)); %Flip the sign 
    
    %Find the net normal force force
    Nnet = Nupper + Nlower; 
    
    %Integrating to find the axial force
    yValsUpper = y_tupper(xVals); %Y values
    yValsLower = y_tlower(xVals); %Y values
    
    %Axial Fores
    Aupper = sum(PuSum / 2 .* diff(yValsUpper));
    Alower = -1*sum(PlSum / 2 .* diff(yValsLower));
    
    %Net Axial
    Anet = Aupper + Alower;
    
    %Calculate lift and drag
    liftVec(i) = Nnet * cos(aoa) - Anet * sin(aoa);
    dragVec(i) = Nnet * sin(aoa) + Anet * cos(aoa);

    %Calculate the Error
    liftError(i) = abs((liftVec(i) - liftExact) / liftExact) * 100;
    dragError(i) = abs((dragVec(i) - dragExact) / dragExact) * 100;
end

%Determining where the error is less than 1%
%Creating logical vectors of less than 1%
liftLog = liftError < 1;
dragLog = dragError < 1;

%Getting the indices where the error is less than 1 percent
liftIndices = find(liftLog);
dragIndices = find(dragLog);

%From the plot we can see the drag doesn't converge until around 3000 so we
%neglect the first two
finalNumPointsLift = (liftIndices(1) * 2) - 2; %Multiply by 2 to get top and bottom, subtract 2 because the LE and TE points are double counted
finalNumPointsDrag = (dragIndices(3) * 2) - 2;

%% Problem 2 ---- Plotting
%Plotting the error log scale
figure();
plot(2:2:20000, dragError(1:end), 'linewidth', 2); %Drag error
set(gca, 'Yscale', 'log')
hold on
plot(2:2:20000, liftError(1:end), 'linewidth', 2); %Lift error
yline(1, 'linewidth',2,'color', [0.4660 0.6740 0.1880])
plot(finalNumPointsLift, 1, 'marker', '.', 'markersize', 20, 'color', 'r');
plot(finalNumPointsDrag, 1, 'marker', '.', 'markersize', 20, 'color', 'b');

xlabel('Number of Equispaced Points');
ylabel('Relative Error $$(\%)$$');
title('Problem 2: Relative Error');
legend('Drag Error', 'Lift Error', '1 $$\%$$ Error', 'Interpreter','latex')

%Ouputing to the terminal
fprintf("Number of equispaced integration points required for less than 1 percent relative error for Lift: %i \n", finalNumPointsLift);
fprintf("Number of equispaced integration points required for less than 1 percent relative error for Drag: %i \n", finalNumPointsDrag);

%%%%END PROGRAM


