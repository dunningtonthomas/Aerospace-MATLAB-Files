+%% ASEN 3111 - Computational Assignment 1 - Main
% Provide a breif summary of the problem statement and code so that
% you or someone else can later understand what you attempted to do
% it doesn’t have to be that long.
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson
% Date: 1/17/2023

%Clean Up
close all; clear; clc;

%% Problem 1

%%%%Symbolic integration to determine the sectional lift and drag coefficients
syms theta;
Cp_syms = -4*((sin(theta)).^2 + sin(theta));
cl = int(-0.5*Cp_syms*sin(theta), theta, 0, 2*pi);
cd = int(-0.5*Cp_syms*cos(theta), theta, 0, 2*pi);
fprintf("Analytical sectional lift and drag coefficients:\n\t cl: %f \n\t cd: %f\n", double(cl), double(cd));


%%%%Numerical integration with the trapezoidal composite method

%Anonymous function for the integrand of the sectional coefficients
cl_theta = @(th)(2*((sin(th)).^3 + (sin(th)).^2));
cd_theta = @(th)(2*cos(th).*((sin(th)).^2 + (sin(th))));

%Applying the trapezoid composite method on the interval from 0 to 2 pi
cumSumCl = zeros(50,1);
cumSumCd = zeros(50,1);
for i = 1:length(cumSumCl) %Using 50 different discretizations
   interval = 2*pi / i; %Base of each trapezoid
   sumCl = 0;
   sumCd = 0;
   lowerX = 0;
   for j = 1:i-1  
       %The upper x value based on the lower and the interval
       upperX = lowerX + interval; 
       %Cl values
       upperYCl = cl_theta(upperX);
       lowerYCl = cl_theta(lowerX);
       %Cd values
       upperYCd = cd_theta(upperX);
       lowerYCd = cd_theta(lowerX);
       
       %Update the lowerX value in the trapezoid sum
       lowerX = lowerX + interval;
       
       %Calculate the area of the trapezoid
       areaCl = interval * (upperYCl + lowerYCl) / 2;
       areaCd = interval * (upperYCd + lowerYCd) / 2;
       
       %Final sum
       sumCl = sumCl + areaCl;
       sumCd = sumCd + areaCd;     
   end
    
   %Storing the final integral in the trapz variables
   cumSumCl(i) = sumCl;
   cumSumCd(i) = sumCd;
end

%Applying the trapezoid composite
cumSumCl_ = zeros(50,1);
cumSumCd_ = zeros(50,1);
for i = 1:50 %Using 100 different discretizations
    xRange = linspace(0, 2*pi, i+1);
    yCl = cl_theta(xRange);
    yCd = cd_theta(xRange);
    
    %Computing the trapezoid sum
    cumSumCl_(i) = trapz(xRange, yCl);
    cumSumCd_(i) = trapz(xRange, yCd); 
end

%%%%Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
%Cl versus N discretizations
plot(1:50, cumSumCl, 'linewidth', 2);
grid on

xlabel('Number of Panels to Discretize');
ylabel('Sectional Lift Coefficient $$cl$$');
title('Sectional Lift Coefficient versus Number of Panels');

figure();
%Cd versus N discretizations
plot(1:50, cumSumCd, 'linewidth', 2);
grid on

xlabel('Number of Panels to Discretize');
ylabel('Sectional Drag Coefficient $$cd$$');
title('Sectional Drag Coefficient versus Number of Panels');


%%%%Numerical integration with the simpsons composite method

