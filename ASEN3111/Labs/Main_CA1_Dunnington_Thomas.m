%% ASEN 3111 - Computational Assignment 1 - Main
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

%Symbolic integration to determine the sectional lift and drag coefficients
    %%%%Double check that it is ok to have the symbolic implementation
syms theta;
Cp_syms = (1 - (4*(sin(theta)).^2 + 4*sin(theta) + 1));
cl = int(-0.5*Cp_syms*sin(theta), theta, 0, 2*pi);
cd = int(-0.5*Cp_syms*cos(theta), theta, 0, 2*pi);
fprintf("Analytical sectional lift and drag coefficients:\n\t cl: %f \n\t cd: %f\n", double(cl), double(cd));

%%%%Numerical integration with the trapezoidal composite method
%Anonymous function for the coefficient of pressure with the given
%circulation
Cl_int = @(th)(2*(sin(th).^3 + sin(th).^2));
Cd_int = @(th)(2*(cos(th).*(sin(th).^2 + sin(th))));

%Computing the coefficient 50 times from 1 to 50 discretizations of the
%cylinder
N = 1:50; %The number of panels

%Storing the value of the integrations
Cl_int_trapz = zeros(length(N),1);
Cd_int_trapz = zeros(length(N),1);

%Looping through different N values
for i = N
    Cl_int_trapz(i) = trapzFunc(Cl_int, [0 2*pi], i);
    Cd_int_trapz(i) = trapzFunc(Cd_int, [0 2*pi], i);
end


%%%%Numerical Integration with the simpson's composite method
test = simpFunc(Cl_int, [0 2*pi], 10);

%Looping through different N values
for i = N
    Cl_int_simp(i) = simpFunc(Cl_int, [0 2*pi], i);
    Cd_int_simp(i) = simpFunc(Cd_int, [0 2*pi], i);
end




%%%%Plotting
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
title('Sectional Lift Coefficient versus Number of Panels Trapezoid');
legend('Analytical Integration', 'Numerical Integration', 'location', 'se');

figure();
%Cd versus N discretizations
plot(N, double(cd)*ones(length(N),1), 'color', 'g', 'linewidth', 2)
grid on
hold on
plot(N, Cd_int_trapz, 'linewidth', 2, 'linestyle', 'none', 'marker', '.', 'markersize', 15, 'color', 'k');

xlabel('Number of Panels to Discretize');
ylabel('Sectional Drag Coefficient $$cd$$');
title('Sectional Drag Coefficient versus Number of Panels Trapezoid');
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
title('Sectional Lift Coefficient versus Number of Panels Simpsons');
legend('Analytical Integration', 'Numerical Integration', 'location', 'se');

figure();
%Cd versus N discretizations
plot(N, double(cd)*ones(length(N),1), 'color', 'g', 'linewidth', 2)
grid on
hold on
plot(N, Cd_int_simp, 'linewidth', 2, 'linestyle', 'none', 'marker', '.', 'markersize', 15, 'color', 'k');

xlabel('Number of Panels to Discretize');
ylabel('Sectional Drag Coefficient $$cd$$');
title('Sectional Drag Coefficient versus Number of Panels Simpsons');
legend('Analytical Integration', 'Numerical Integration', 'location', 'se');



%% Problem 2





