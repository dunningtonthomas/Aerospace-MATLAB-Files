%% ASEN 3111 - Computational Assignment 2 - Main
%
%
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson
% Date: 2/21/2023

%% Clean Up
close all; clear; clc;


%% PROBLEM 1: Streamlines, Equipotential lines, and Pressure Contour
c = 5; %meters
alpha = 15 * pi/180; %Radians
V_inf = 34; %m/s
p_inf = 101.3 * 10^3;
rho_inf = 1.225; %kg/m^3
N = 500; %The true value

%Plotting streamfunction, equipotential, and pressure contours
[streamfuncTrue,equipotentialTrue,CpTrue] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,1);


%% PROBLEM 2: Performing error study with number of N vortices
%3D arrays that store the meshgrid values with various values of N
streamfuncVals = zeros(100,100,N/5);
equipotentialVals = zeros(100,100,N/5);
CpVals = zeros(100,100,N/5);

%Error arrays to store the error at a given N
streamfuncError = zeros(1,N/5);
equipotentialError = zeros(1,N/5);
CpError = zeros(1,N/5);

%Vortices tested
numVortices = 5:5:N;

%Running up to 500 vortices, going up by 5
for i = 1:100
    %Returning the 100x100 matrices of streamfunction, equipotential, and
    %CP
    [streamfuncVals(:,:,i), equipotentialVals(:,:,i), CpVals(:,:,i)] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,5*i,0);

    %Calculate the error, (actual - expected) / expected, absolute value of
    %the difference to quantify error, take the average to get a single
    %error value for a given N
    CpError(i) = mean(abs((CpVals(:,:,i) - CpTrue) ./ CpTrue), 'all') * 100;
    streamfuncError(i) = mean(abs((streamfuncVals(:,:,i) - streamfuncTrue) ./ streamfuncTrue), 'all') * 100;
    equipotentialError(i) = mean(abs((equipotentialVals(:,:,i) - equipotentialTrue) ./ equipotentialTrue), 'all') * 100;
end

%Determining where the error is less than 1 percent
logStreamFunc = numVortices(streamfuncError < 1);
logEquipotential = numVortices(equipotentialError < 1);
logCp = numVortices(CpError < 1);

%Getting the first point where it is less than 1 percent
convergeStream = logStreamFunc(1);
convergeEquipotential = logEquipotential(1);
convergeCp = logCp(1);

%Printing to the command window the convergence value
fprintf('---------Error Analysis---------\n');
fprintf('The Number of vortices required for less than 1 percent error:\n');
fprintf('\t Streamfunction: %i\n', convergeStream);
fprintf('\t Equipotential: %i\n', convergeEquipotential);
fprintf('\t Coefficient of Pressure: %i\n', convergeCp);

%Plotting the error
figure();
plot(5:5:N, CpError, 'linewidth', 2);
hold on;
plot(5:5:N, streamfuncError, 'linewidth', 2);
plot(5:5:N, equipotentialError, 'linewidth', 2);

%Plotting the convergence of each plot to less than 1 percent error
xline([convergeStream convergeEquipotential convergeCp], '-', {'Streamfunction Convergence', 'Equipotential Convergence', 'Cp Convergence'});

xlabel('Number of N vortices');
ylabel('Mean Percent Error (\%)');
title('Mean Percent Error');
legend('Cp', 'Streamfunction', 'Equipotential', 'Less than 1 % Error', 'location', 'Nw');

%% Problem 3: Study on changes in airfoil characteristics
%Vary: 1) chord length  2) angle of attack  3) free stream velocity
%Have three different cases, smaller, original, greater for each of the
%above parameters

%Define Original Parameters
alpha = 15 * pi/180; %Radius
V_inf = 34; %m/s
p_inf = 101.3 * 10^3;
rho_inf = 1.225; %kg/m^3
N = 500; %The true value

%% Chord Length Variation
%Smaller chord
c = 2.5;
[streamfunc_chord1, equipotential_chord1, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,5*i,0);

%Original Case
c = 5;
[streamfunc_chord2, equipotential_chord2, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,5*i,0);

%Greater chord
c = 10;
[streamfunc_chord3, equipotential_chord3, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,5*i,0);

%Create Subplot showing the three different cases
%Stream function levels
levminStream = min(streamfunc_chord1, [], 'all');
levmaxStream = max(streamfunc_chord1, [], 'all');
levelsStream1 = linspace(levminStream,levmaxStream,20)';
    
%Equipotential levels
levminEq = min(equipotential_chord1, [], 'all');
levmaxEq = max(equipotential_chord1, [], 'all');
levelsEq1 = linspace(levminEq,levmaxEq,20)';

%Stream function levels
levminStream = min(streamfunc_chord2, [], 'all');
levmaxStream = max(streamfunc_chord2, [], 'all');
levelsStream2 = linspace(levminStream,levmaxStream,20)';
    
%Equipotential levels
levminEq = min(equipotential_chord2, [], 'all');
levmaxEq = max(equipotential_chord2, [], 'all');
levelsEq2 = linspace(levminEq,levmaxEq,20)';

%Stream function levels
levminStream = min(streamfunc_chord3, [], 'all');
levmaxStream = max(streamfunc_chord3, [], 'all');
levelsStream3 = linspace(levminStream,levmaxStream,20)';
    
%Equipotential levels
levminEq = min(equipotential_chord3, [], 'all');
levmaxEq = max(equipotential_chord3, [], 'all');
levelsEq3 = linspace(levminEq,levmaxEq,20)';


%Subplot 3 by 2 with stream and equipotential, rows are different chords
xmin = -0.5*c; %2 times the chord
xmax = 1.5*c;
ymin = -5;
ymax = 5;

%Grid points
nx=100;
ny=100; 

%Create meshgid
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));

%Plotting the variations with chord
figure('units','normalized', 'outerposition', [0 0 1 1]);
sgtitle('Variation in Chord Length')
set(0, 'defaulttextinterpreter', 'latex')
subplot(3,2,1)
contourf(x,y,streamfunc_chord1,levelsStream1,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 2.5], [0 0], 'linewidth', 2, 'color', 'r');
    
title('Chord = 2.5 m');
c = colorbar;
c.Label.String = 'Streamfunction Value';


subplot(3,2,3)
contourf(x,y,streamfunc_chord2,levelsStream2,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('Chord = 5 m');
ylabel('Y Position (m)');
c = colorbar;
c.Label.String = 'Streamfunction Value';


subplot(3,2,5)
contourf(x,y,streamfunc_chord3,levelsStream3,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 10], [0 0], 'linewidth', 2, 'color', 'r');

title('Chord = 10 m');
xlabel('X Position (m)');
c = colorbar;
c.Label.String = 'Streamfunction Value';



subplot(3,2,2)
contourf(x,y,equipotential_chord1,levelsEq1,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 2.5], [0 0], 'linewidth', 2, 'color', 'r');

title('Chord = 2.5 m');
c = colorbar;
c.Label.String = 'Equipotential Value';


subplot(3,2,4)
contourf(x,y,equipotential_chord2,levelsEq2,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('Chord = 5 m');
ylabel('Y Position (m)');
c = colorbar;
c.Label.String = 'Equipotential Value';


subplot(3,2,6)
contourf(x,y,equipotential_chord3,levelsEq3,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('Chord = 10 m');
xlabel('X Position (m)');
c = colorbar;
c.Label.String = 'Equipotential Value';


