%% ASEN 3111 - Computational Assignment 2 - Main
%SUMMARY: This code is split into three parts, the first part calculates
%the streamfunction, equipotential, and Cp contours for an airfoil with
%given parameters. This is shown in Figures 1-3. The second part includes
%an error analysis on the number of discrete vortices required, this is
%included in Figure 4. The remaining Figures are for the last part which
%includes a study on the effect of varying airfoil parameters on the
%resulting streamfunction and equipotentials
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase
% Rupprecht
% Date: 3/1/2023

%% Clean Up
close all; clear; clc;


%% PROBLEM 1: Streamlines, Equipotential lines, and Pressure Contour

c = 5; %meters
alpha = 15 * pi/180; %Radians
V_inf = 34; %m/s
p_inf = 101.3 * 10^3; %Pa
rho_inf = 1.225; %kg/m^3
N = 500; %Maximum number of vortices used, taken as the "true" value

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

%The following for loop will calculate the mean percent error for the
%streamfunction, equipotential, and pressure by computing the error at
%every point in the meshgrid and averaging the absolute value of the
%result, this allows us to quantify the error for the entire grid for a
%given number of N vortices. Our true value is our maximum case of 500
%vortices
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

%Printing to the command window the convergence values
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
xline(convergeStream, '-', 'Streamfunction Convergence', 'linewidth', 2);
xline(convergeEquipotential, '-','Equipotential Convergence', 'linewidth', 2);
xline(convergeCp, '-', 'Cp Convergence', 'linewidth', 2);

xlabel('Number of N vortices');
ylabel('Mean Percent Error (\%)');
title('\textbf{Mean Percent Error}');
legend('Cp', 'Streamfunction', 'Equipotential', 'Less than 1 % Error', 'location', 'Nw');

%% Problem 3: Study on changes in airfoil characteristics
%Vary: 1) chord length  2) angle of attack  3) free stream velocity
%Have three different cases, smaller, original, greater for each of the
%above parameters

%ReDefine Original Parameters
alpha = 15 * pi/180; %Radius
V_inf = 34; %m/s
p_inf = 101.3 * 10^3;
rho_inf = 1.225; %kg/m^3
N = 500; %The true value

%% Chord Length Variation

%Calculating the matrices for streamfunction and equipotentials for three
%different chord values
%Smaller chord
c = 2.5;
[streamfunc_chord1, equipotential_chord1, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Original Case
c = 5;
[streamfunc_chord2, equipotential_chord2, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Greater chord
c = 10;
[streamfunc_chord3, equipotential_chord3, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Defining the levels, trial and error
levelsEqFinal = linspace(-250, 650, 50);
levelsStreamFinal = linspace(-200,300,20);

%Define Domain 1
xmin = -0.5*2.5;
xmax = 1.5*2.5;
ymin = -3;
ymax = 3;

%Grid points
nx=100;
ny=100; 

%Create meshgid
[x1,y1]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));

%Define Domain 2
xmin = -0.5*5;
xmax = 1.5*5;
ymin = -5;
ymax = 5;

%Grid points
nx=100;
ny=100; 

%Create meshgid
[x2,y2]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));


%Define Domain 3
xmin = -3;
xmax = 11;
ymin = -5;
ymax = 5;

%Grid points
nx=100;
ny=100; 

%Create meshgid
[x3,y3]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));

%Creating Subplot 3 by 2 with the first column including the
%streamfunctions and the second including the equipotentials
%Plotting the variations with chord
figure('units','normalized', 'outerposition', [0 0 1 1]);
sgtitle('\textbf{Variation in Chord Length}')
set(0, 'defaulttextinterpreter', 'latex')
subplot(3,2,1)
contourf(x1,y1,streamfunc_chord1,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 2.5], [0 0], 'linewidth', 2, 'color', 'r');
    
title('\textbf{c = 2.5 m}');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';

%Original Chord Streamfunction
subplot(3,2,3)
contourf(x2,y2,streamfunc_chord2,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('\textbf{c = 5 m}');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';

%Large Chord Streamfunction
subplot(3,2,5)
contourf(x3,y3,streamfunc_chord3,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 10], [0 0], 'linewidth', 2, 'color', 'r');

title('\textbf{c = 10 m}');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';


%Small Chord Equipotential
subplot(3,2,2)
contourf(x1,y1,equipotential_chord1,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 2.5], [0 0], 'linewidth', 2, 'color', 'r');

title('\textbf{c = 2.5 m}');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';


%Original Chord Equipotential
subplot(3,2,4)
contourf(x2,y2,equipotential_chord2,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('\textbf{c = 5 m}');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';


%Large Chord Equipotential
subplot(3,2,6)
contourf(x3,y3,equipotential_chord3,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 10], [0 0], 'linewidth', 2, 'color', 'r');

title('\textbf{c = 10 m}');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';


%% Angle of Attack Variation
%Calculating the matrices for streamfunction and equipotentials for three
%different aoa values
%Default chord length
c = 5;

%Small Alpha
alpha = 5 * pi / 180; 
[streamfunc_aoa1, equipotential_aoa1, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Original Case
alpha = 15 * pi / 180; 
[streamfunc_aoa2, equipotential_aoa2, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Greater Aoa
alpha = 30 * pi / 180; 
[streamfunc_aoa3, equipotential_aoa3, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Defining the levels, trial and error
levelsEqFinal = linspace(-250, 650, 50);
levelsStreamFinal = linspace(-200,300,20);

%Define Domain 1
xmin = -0.5*5;
xmax = 1.5*5;
ymin = -5;
ymax = 5;

%Grid points
nx=100;
ny=100; 

%Create meshgid
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));



%Creating Subplot 3 by 2 with the first column including the
%streamfunctions and the second including the equipotentials
%Plotting the variations with Angle of attack
figure('units','normalized', 'outerposition', [0 0 1 1]);
sgtitle('\textbf{Variation in Angle of Attack}')
set(0, 'defaulttextinterpreter', 'latex')
subplot(3,2,1)
contourf(x,y,streamfunc_aoa1,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');
    
title('\boldmath$$\mathbf{\alpha = 5^{\circ}}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';

%Original Aoa Streamfunction
subplot(3,2,3)
contourf(x,y,streamfunc_aoa2,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('\boldmath$$\mathbf{\alpha = 15^{\circ}}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';

%Large Aoa Streamfunction
subplot(3,2,5)
contourf(x,y,streamfunc_aoa3,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('\boldmath$$\mathbf{\alpha = 30^{\circ}}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';


%Small Aoa Equipotential
subplot(3,2,2)
contourf(x,y,equipotential_aoa1,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('\boldmath$$\mathbf{\alpha = 5^{\circ}}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';


%Original Aoa Equipotential
subplot(3,2,4)
contourf(x,y,equipotential_aoa2,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('\boldmath$$\mathbf{\alpha = 15^{\circ}}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';


%Large Aoa Equipotential
subplot(3,2,6)
contourf(x,y,equipotential_aoa3,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('\boldmath$$\mathbf{\alpha = 30^{\circ}}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';

%% Free Stream Flow Speed Variation
%Calculating the matrices for streamfunction and equipotentials for three
%different V_inf values
%Default angle of attack and chord
c = 5;
alpha = 15 * pi / 180;

%Small V_inf
V_inf = 15;
[streamfunc_V1, equipotential_V1, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Original Case
V_inf = 34;
[streamfunc_V2, equipotential_V2, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Greater V_inf
V_inf = 60;
[streamfunc_V3, equipotential_V3, ~] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,0);

%Defining the levels, trial and error
levelsEqFinal = linspace(-250, 650, 50);
levelsStreamFinal = linspace(-300,300,40);

%Define Domain 1
xmin = -0.5*5;
xmax = 1.5*5;
ymin = -5;
ymax = 5;

%Grid points
nx=100;
ny=100; 

%Create meshgid
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));


%Creating Subplot 3 by 2 with the first column including the
%streamfunctions and the second including the equipotentials
%Plotting the variations with free stream velocity
figure('units','normalized', 'outerposition', [0 0 1 1]);
sgtitle('\textbf{Variation in Free Stream Velocity}')
set(0, 'defaulttextinterpreter', 'latex')
subplot(3,2,1)
contourf(x,y,streamfunc_V1,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');
    
title('$$\mathbf{V_{\infty} = 15}$$ $$\mathbf{m/s}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';

%Original V Streamfunction
subplot(3,2,3)
contourf(x,y,streamfunc_V2,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('$$\mathbf{V_{\infty} = 34}$$ $$\mathbf{m/s}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';

%Large V Streamfunction
subplot(3,2,5)
contourf(x,y,streamfunc_V3,levelsStreamFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('$$\mathbf{V_{\infty} = 60}$$ $$\mathbf{m/s}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Streamfunction Value';


%Small V Equipotential
subplot(3,2,2)
contourf(x,y,equipotential_V1,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('$$\mathbf{V_{\infty} = 15}$$ $$\mathbf{m/s}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';


%Original V Equipotential
subplot(3,2,4)
contourf(x,y,equipotential_V2,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('$$\mathbf{V_{\infty} = 34}$$ $$\mathbf{m/s}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';


%Large V Equipotential
subplot(3,2,6)
contourf(x,y,equipotential_V3,levelsEqFinal,'LineWidth',1)
axis equal;
hold on
    
%Plot the airfoil
plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');

title('$$\mathbf{V_{\infty} = 60}$$ $$\mathbf{m/s}$$');
xlabel('X Position (m)');
ylabel('Y Position (m)');
c1 = colorbar;
c1.Label.String = 'Equipotential Value';

