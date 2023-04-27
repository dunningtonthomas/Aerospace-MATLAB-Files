%% ASEN 3111 - Computational Assignment 4 - Main
%SUMMARY: 
%   Problem 1: Uses the provided ObliqueShockBeta function to
%   generate the plot 9.9 from Anderson of the shock angle versus the
%   deflection angle and various mach numbers.
%   Problem 2: Uses the DiamondAirfoil function, which uses
%   shock expansion theory, to calculate the coefficient of lift and drag
%   on an airfoil given the airfoil geometry and freestream conditions.
%   Problem 3: Analyzes the effect of angle of attack and mach number of
%   the coefficient of lift and drag. Two plots are generated with lift and
%   drag using shock expansion theory and the linearizedSupersonic function
%   which implements linear supersonic theory to calculate the coefficients
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase
% Rupprecht
% Date: 4/27/2023

%% Clean Up
close all; clear; clc;

%% Problem 1
%Recreate Fig 9.9
%Declare Mach number array
Mtemp = [1:0.1:2]';
MVec = [Mtemp; 2.2; 2.4; 2.6; 2.8; 3; 3.2; 3.4; 3.6; 3.8; 4; 4.5; 5; 6; 8; 10; 20];

%Declaring weak and strong matrices, each column is the deflection angle
thetaVals = linspace(0, 50, 1000)';
weakMat = zeros(length(thetaVals), length(MVec));
strongMat = zeros(length(thetaVals), length(MVec));

%Calling ObliqueShockBeta for various mach values and using the theta
%vector
for i = 1:length(MVec)
    for j = 1:length(thetaVals)
        weakMat(j,i) = ObliqueShockBeta(MVec(i),thetaVals(j),1.4,'Weak');
        strongMat(j,i) = ObliqueShockBeta(MVec(i),thetaVals(j),1.4,'Strong');
    end
end

%Defining blue intensity for the color
blueVal = linspace(0.5,1,length(MVec));
greenVal = linspace(1, 0, length(MVec));

%Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');

%Preliminary colors for legend later
plot(0,0,'color', [0; 1; 0.5]);
hold on
plot(0,0,'color', [0; 0.5; 1]);

%Checker to plot mach number on the plot
checker = 1;

%Plotting the rest of the mach numbers
for i = 1:length(MVec)
    %Flip checker to plot mach number on plot
    checker = ~checker;

    %Getting rid of imaginary and negative values
    weakLog = ~imag(weakMat(:,i)) & weakMat(:,i) >= 0;
    strongLog = ~imag(strongMat(:,i)) & strongMat(:,i) >= 0;
    
    %Defining the color 
    colorPlot = [0; greenVal(i); blueVal(i)];

    %Plotting weak and strong shocks for a given mach number
    plot([thetaVals(weakLog); flip(thetaVals(strongLog))], [weakMat(weakLog,i); flip(strongMat(strongLog,i))], 'color', colorPlot);

    %Adding number to the plot
    %Weak
    thetaEnd = thetaVals(weakLog);
    weakEnd = weakMat(weakLog,i);
    strongEnd = strongMat(strongLog,i);
    
    %Add text of mach number to every other plot so it is not too crowded
    if(weakEnd)
        if(checker)
            text(thetaEnd(end), weakEnd(end), num2str(MVec(i)));
        end
    end
end

%Adding legend and labels
text(thetaEnd(length(thetaEnd) / 2), weakEnd(length(thetaEnd) / 2), '$$\leftarrow$$ Weak Shock');
text(thetaEnd(length(thetaEnd) / 2), strongEnd(length(thetaEnd) / 2), '$$\leftarrow$$ Strong Shock');
leg = legend('Low Mach Number', 'High Mach Number', 'location', 'se');
title(leg, '## = Mach Number')
xlabel('Deflection Angle $$(\theta^{\circ})$$')
ylabel('Shock Wave Angle $$(\delta^{\circ})$$')
title('Oblique Shock $$\theta - \beta - M$$ Relationship');


%% Problem 2
fprintf("--------Problem 2--------\n");

%Define parameters of the diamond airfoil
alpha = 10;
M = 3;
epsilon1 = 7.5;
epsilon2 = 5;

%Calling diamond airfoil to get cl and cd
[c_l,c_dw] = DiamondAirfoil(M, alpha, epsilon1, epsilon2);

%Checking for a bow shock
if(c_l == 0xDEADBEEF && c_dw == 0xDEADBEEF) %Bow shock error condition returned from diamondAirfoil
    fprintf("The flow produces a bow shock.\n");
    
else
    %Outputting to the terminal
    fprintf("Coefficient of Lift and Wave Drag: \n")
    fprintf("\t cl: %f \n", c_l);
    fprintf("\t cdw: %f \n", c_dw);
end


%% Problem 3
%Generate two plots: 1) cl versus alpha 2) cd versis alpha for M = 2,3,4,5
%Compare results to linearized supersonic flow

%Allocating memory for variables to be used
MVec = [2 3 4 5]; %Vector of mach numbers
alphaVec = linspace(-10,10,100); %Vector of angle of attacks
clMat_SE = zeros(length(alphaVec), length(MVec)); %Each column is a Mach number, each row is a cl at a given alpha
cdMat_SE = zeros(length(alphaVec), length(MVec));

%Linearized matrices
clMat_L = zeros(length(alphaVec), length(MVec)); %Each column is a Mach number, each row is a cl at a given alpha
cdMat_L = zeros(length(alphaVec), length(MVec));

%Call diamond airfoil and linearized functions, use the same epsilon values as in problem 2 
for i = 1:length(MVec) %Loop through mach numbers
    for j = 1:length(alphaVec) %Loop through alphas
        [clMat_SE(j,i),cdMat_SE(j,i)] = DiamondAirfoil(MVec(i), alphaVec(j), epsilon1, epsilon2);       
        [clMat_L(j,i),cdMat_L(j,i)] = linearizedSupersonic(MVec(i), alphaVec(j), epsilon1, epsilon2);
    end 
end


%Plotting
%Cl versus angle of attack
figure();
%Initial plots used for legend
plot(0,0,'color', 'k', 'linewidth', 2); %Used for legend shock expansion
hold on;
plot(0,0,'linestyle', '--', 'color', 'k', 'linewidth', 2); %Used for legend linearized theory

%Plot the shock expansion results
plot(alphaVec, clMat_SE(:,1), 'color', [0 0.4470 0.7410], 'linewidth', 2);
plot(alphaVec, clMat_SE(:,2), 'color', [0.8500 0.3250 0.0980], 'linewidth', 2);
plot(alphaVec, clMat_SE(:,3), 'color', [0.9290 0.6940 0.1250], 'linewidth', 2);
plot(alphaVec, clMat_SE(:,4), 'color', [0.4940 0.1840 0.5560], 'linewidth', 2);

%Plot the linearized results
plot(alphaVec, clMat_L(:,1), 'linestyle', '--', 'color', [0 0.4470 0.7410], 'linewidth', 2);
plot(alphaVec, clMat_L(:,2), 'linestyle', '--', 'color', [0.8500 0.3250 0.0980], 'linewidth', 2);
plot(alphaVec, clMat_L(:,3), 'linestyle', '--', 'color', [0.9290 0.6940 0.1250], 'linewidth', 2);
plot(alphaVec, clMat_L(:,4), 'linestyle', '--', 'color', [0.4940 0.1840 0.5560], 'linewidth', 2);

%Add Labels
xlabel('Angle of attack $$(\alpha ^{\circ})$$');
ylabel('Coefficient of Lift $$(c_{l})$$');
title('Shock Expansion and Linearized Theory Coefficient of Lift in Supersonic Flow');
legend('Shock Expansion', 'Linearized Theory','M = 2', 'M = 3', 'M = 4', 'M = 5', 'location', 'nw');


%Cd versus angle of attack
figure();
%Initial plots used for legend
plot(0,0,'color', 'k', 'linewidth', 2); %Used for legend shock expansion
hold on;
plot(0,0,'linestyle', '--', 'color', 'k', 'linewidth', 2); %Used for legend linearized theory

%Plot the shock expansion results
plot(alphaVec, cdMat_SE(:,1), 'color', [0 0.4470 0.7410], 'linewidth', 2);
plot(alphaVec, cdMat_SE(:,2), 'color', [0.8500 0.3250 0.0980], 'linewidth', 2);
plot(alphaVec, cdMat_SE(:,3), 'color', [0.9290 0.6940 0.1250], 'linewidth', 2);
plot(alphaVec, cdMat_SE(:,4), 'color', [0.4940 0.1840 0.5560], 'linewidth', 2);

%Plot the linearized results
plot(alphaVec, cdMat_L(:,1), 'linestyle', '--', 'color', [0 0.4470 0.7410], 'linewidth', 2);
plot(alphaVec, cdMat_L(:,2), 'linestyle', '--', 'color', [0.8500 0.3250 0.0980], 'linewidth', 2);
plot(alphaVec, cdMat_L(:,3), 'linestyle', '--', 'color', [0.9290 0.6940 0.1250], 'linewidth', 2);
plot(alphaVec, cdMat_L(:,4), 'linestyle', '--', 'color', [0.4940 0.1840 0.5560], 'linewidth', 2);

%Add Labels
xlabel('Angle of attack $$(\alpha ^{\circ})$$');
ylabel('Coefficient of Drag $$(c_{dw})$$');
title('Shock Expansion and Linearized Theory Wave Drag in Supersonic Flow');
legend('Shock Expansion', 'Linearized Theory','M = 2', 'M = 3', 'M = 4', 'M = 5', 'location', 'n');













