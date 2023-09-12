%% ASEN 3111 - Computational Assignment 3 - Main
%
%SUMMARY: This code has 5 problems. Problem 1 calculates the sectional lift
%coefficient of a NACA 0012 airfoil using the vortex panel method and finds
%the number of panels required for less than 1 percent error. Problem 2
%Compares three different symmetric airfoils of varying thickness and
%calculates lift with the vortex panel method and thin airfoil theory.
%Problem 3 does the same with airfoils of the same thickness but different
%camber. Problem 4 involves the PLLT function which implements the PLLT
%equation to get the span efficiency factor. It then outputs a figure of
%deltas with different root/tip chord ratios. Problem 5 calculates the lift
%and drag of a cessna 150 and number of odd terms required for various
%errors.
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase
% Rupprecht
% Date: 4/5/2023

%% Clean Up
close all; clear; clc;

%% Problem 1
%NACA 0012 airfoil
m = 0;
p = 0;
t = 12 / 100;
c = 5; %Doesn't matter for CL calculation
N = 1000; %Number of panels for the "true" value

%Parameters
AoA = 10; %degrees
Vinf = 100; %Doesn't matter for CL calculation

%Calling Naca function to get the x and y coordinates of the airfoil
[x1,y1] = NACA_Airfoils(m,p,t,c,N);

%Apply vortex panel method to get the CL
CL_NACA0012 = Vortex_Panel(x1,y1,100,10); %AoA of 10 degrees

%Calculate error using a while loop
relError = 100;
i = 10; %Start at 10 panels, go up by 10
while(relError > 1 && i < 1000)
    %Calling with i panels
    [xTemp,yTemp] = NACA_Airfoils(m,p,t,c,i);

    %Calculating CL
    CL_Vec(i/10) = Vortex_Panel(xTemp,yTemp,100,10);

    %Calculating error
    relError = abs(CL_Vec(i/10) - CL_NACA0012) ./ CL_NACA0012 * 100;
    numPanels = i; %Store index
    i = i + 10; %Update iterator
end

%Printing to the command window
fprintf("-----------Problem 1-----------\n");
fprintf("NACA 0012 Sectional Lift Coefficient at 10 Degrees AoA: %f\n", CL_NACA0012);
fprintf("Number of panels required for less than 1 percent relative error: %d\n\n", numPanels-2); %Subtract two because leading edge and trailing edge are double counted


%% Problem 2
%Get the x and y locations for various airfoils:
%NACA 0006
m = 0;
p = 0;
t = 6 / 100;
c = 5;
N = numPanels;

[x0006,y0006] = NACA_Airfoils(m,p,t,c,N);

%NACA 0012
m = 0;
p = 0;
t = 12 / 100;
c = 5;
N = numPanels;

[x0012,y0012] = NACA_Airfoils(m,p,t,c,N);

%NACA 0024
m = 0;
p = 0;
t = 24 / 100;
c = 5;
N = numPanels;

[x0024,y0024] = NACA_Airfoils(m,p,t,c,N);


%Getting the CL versus angle of attack at 25 different aoa
AoAVec = linspace(-10,10,25);
CL_0006 = zeros(length(AoAVec),1);
CL_0012 = zeros(length(AoAVec),1);
CL_0024 = zeros(length(AoAVec),1);

for i = 1:length(AoAVec)
    CL_0006(i) = Vortex_Panel(x0006,y0006,100,AoAVec(i));
    CL_0012(i) = Vortex_Panel(x0012,y0012,100,AoAVec(i));
    CL_0024(i) = Vortex_Panel(x0024,y0024,100,AoAVec(i));
end

%Plotting the cl versus angle of attack for the above airfoils
figure()
set(0, 'defaulttextinterpreter', 'latex');
plot(AoAVec, CL_0006, 'linewidth', 2);
hold on;
grid on;
plot(AoAVec, CL_0012, 'linewidth', 2);
plot(AoAVec, CL_0024, 'linewidth', 2);
%Plotting the thin airfoil equivalent
plot(AoAVec, 2*pi*pi/180 *AoAVec, 'linewidth', 2, 'linestyle', '--')

title('\bf{PROBLEM 2:} Sectional Lift Coefficient Versus Angle of Attack');
xlabel('Angle of Attack ($$^{\circ}$$)');
ylabel('Sectional Coefficient of Lift $$c_{l}$$');
legend('NACA 0006', 'NACA 0012', 'NACA 0024', 'Thin Airfoil', 'location', 'nw')

%Performing linear regression to get the lift slope and the zero angle of
%attack
coeff0006 = polyfit(AoAVec, CL_0006, 1);
coeff0012 = polyfit(AoAVec, CL_0012, 1);
coeff0024 = polyfit(AoAVec, CL_0024, 1);

%Finding zero lift angle of attack
zeroAOA_0006 = roots(coeff0006);
zeroAOA_0012 = roots(coeff0012);
zeroAOA_0024 = roots(coeff0024);

%Printing to the command window
fprintf("-----------Problem 2-----------\n");
fprintf('NACA 0006:\n');
fprintf('\tVortex Panel:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', coeff0006(1));
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', abs(zeroAOA_0006))
fprintf('\tThin Airfoil:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', 2*pi* pi / 180);
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', 0)

fprintf('NACA 0012:\n');
fprintf('\tVortex Panel:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', coeff0012(1));
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', zeroAOA_0012)
fprintf('\tThin Airfoil:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', 2*pi* pi / 180);
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', 0)

fprintf('NACA 0024:\n');
fprintf('\tVortex Panel:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', coeff0024(1));
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', zeroAOA_0024)
fprintf('\tThin Airfoil:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', 2*pi * pi / 180);
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', 0)


%% Problem 3
%NACA 2412
m = 2/100;
p = 4/10;
t = 12 / 100;
c = 5;
N = numPanels;

[x2412,y2412] = NACA_Airfoils(m,p,t,c,N);

%NACA 4412
m = 4/100;
p = 4/10;
t = 12 / 100;
c = 5;
N = numPanels;

[x4412,y4412] = NACA_Airfoils(m,p,t,c,N);

%Calculating the cl versus aoa using the vortex panel code
CL_2412 = zeros(length(AoAVec),1);
CL_4412 = zeros(length(AoAVec),1);

for i = 1:length(AoAVec)
    CL_2412(i) = Vortex_Panel(x2412,y2412,100,AoAVec(i));
    CL_4412(i) = Vortex_Panel(x4412,y4412,100,AoAVec(i));
end

%Getting the zero angle of attack for the thin airfoil case
alphaTA_L0_0012 = 0;
alphaTA_L0_2412 = zeroLiftALpha(2/100, 4/10);
alphaTA_L0_4412 = zeroLiftALpha(4/100, 4/10);

%Plotting the cl versus angle of attack for the above airfoils
figure();
plot(AoAVec, CL_0012, 'linewidth', 2, 'color', 'r');
hold on;
grid on;
%0012 Thin airfoil
plot(AoAVec, 2*pi*pi/180 * (AoAVec - alphaTA_L0_0012) , 'linestyle', '--', 'color', 'r');
plot(AoAVec, CL_2412, 'linewidth', 2, 'color', 'm');
%2412 Thin airfoil
plot(AoAVec, 2*pi*pi/180 * (AoAVec - alphaTA_L0_2412), 'linestyle', '--', 'color', 'm');
plot(AoAVec, CL_4412, 'linewidth', 2, 'color', 'b');
%4412 Thin airfoil
plot(AoAVec, 2*pi*pi/180 * (AoAVec - alphaTA_L0_4412), 'linestyle', '--', 'color', 'b');


title('\bf{PROBLEM 3:} Sectional Lift Coefficient Versus Angle of Attack');
xlabel('Angle of Attack ($$^{\circ}$$)');
ylabel('Sectional Coefficient of Lift $$c_{l}$$');
legend('NACA 0012', 'Thin Airfoil', 'NACA 2412', 'Thin Airfoil', 'NACA 4412', 'Thin Airfoil', 'location', 'nw')


%Performing linear regression to get the lift slope and the zero angle of
%attack
coeff2412 = polyfit(AoAVec, CL_2412, 1);
coeff4412 = polyfit(AoAVec, CL_4412, 1);

%Finding zero lift angle of attack
zeroAOA_2412 = roots(coeff2412);
zeroAOA_4412 = roots(coeff4412);

%Printing to the command window
fprintf("\n-----------Problem 3-----------\n");
fprintf('NACA 0012:\n');
fprintf('\tVortex Panel:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', coeff0012(1));
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', zeroAOA_0012)
fprintf('\tThin Airfoil:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', 2*pi* pi / 180);
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', 0)

fprintf('NACA 2412:\n');
fprintf('\tVortex Panel:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', coeff2412(1));
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', zeroAOA_2412)
fprintf('\tThin Airfoil:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', 2*pi* pi / 180);
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', alphaTA_L0_2412)

fprintf('NACA 4412:\n');
fprintf('\tVortex Panel:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', coeff4412(1));
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', zeroAOA_4412)
fprintf('\tThin Airfoil:\n')
fprintf('\t\tSectional Lift Slope (cl/deg): %f\n', 2*pi * pi / 180);
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', alphaTA_L0_4412)

%% Problem 4
%Reproduce Fig 5.20 from Anderson
cr = 10;
ct = linspace(0.01*cr, cr, 100); %Various ct/cr ratios

%AR = 10, 8, 6, 4 from Anderson figure
ARvals = [4; 6; 8; 10];
eVals = zeros(length(ct),length(ARvals));

%Calling PLLT multiple times to get various span efficieny factors in eVals
for j = 1:length(ARvals)
    AR = ARvals(j);
    for i = 1:length(ct)
        b = AR *(cr + ct(i)) / 2;
        [eVals(i,j),~,~] = PLLT(b,2*pi,2*pi,ct(i),cr,0,0,4*pi/180,4*pi/180,50);
    end
end

%Solving for delta given e
delta = 1 ./ eVals - 1;

%Plotting the results of delta versus taper ratio for various AR values
figure();
plot(ct ./ cr, delta(:,1), 'linewidth', 2);
hold on
grid on
plot(ct ./ cr, delta(:,2), 'linewidth', 2);
plot(ct ./ cr, delta(:,3), 'linewidth', 2);
plot(ct ./ cr, delta(:,4), 'linewidth', 2);

xlabel('Taper Ratio, $$\frac{c_{t}}{c_{r}}$$');
ylabel('$$\delta$$');
legend('AR = 4', 'AR = 6', 'AR = 8', 'AR = 10');
title('\bf{PROBLEM 4:} $$\boldmath\delta$$ Versus Taper Ratio');


%% Problem 5
%Defining characteristics of Cessna 150 Wing
b = 33 + 4/12;
a0_t = coeff0012(1) * 180/pi; %Airfoil results from the previous section
a0_r = coeff2412(1) * 180/pi;
c_t = 3 + 8.5/12;
c_r = 5 + 4/12;
aero_t = zeroAOA_0012 * pi/180; %Airfoil results from the previous section
aero_r = zeroAOA_2412 * pi/180; 
geo_t = (3 + 0) * pi / 180;
geo_r = (3 + 1) * pi / 180;

%Calling PLLT for the Cessna
[e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,10);

%60 knots at 15000 ft std atmos
rho = 1.496e-3; %slugs/ft^3
speed = 60 * 1.688; %ft/s

%Calculating lift and induced drag
S = b/2*(c_t + c_r); %ft^2
lift = c_L * (0.5*rho*speed^2*S);
drag = c_Di * (0.5*rho*speed^2*S);

%Metric units
%60 knots at 15000 ft std atmos
rho = 0.7779; %kg/m^3
speed = 30.8667; %m/s

%Calculating lift and induced drag
S = b/2*(c_t + c_r) * 0.3048^2; %m^2
lift_SI = c_L * (0.5*rho*speed^2*S);
drag_SI = c_Di * (0.5*rho*speed^2*S);

%Determining the number of terms to get 10, 1, and 1/10 relative error
Nvec = 2:1:100;
cLVec = zeros(length(Nvec), 1);
cDVec = zeros(length(Nvec), 1);
cLError = zeros(length(Nvec), 1);
cDError = zeros(length(Nvec), 1);
for i = Nvec
    [~,cLVec(i-1),cDVec(i-1)] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,i);
    cLError(i-1) = abs((cLVec(i-1) - c_L) / c_L * 100); %Relative error calculation
    cDError(i-1) = abs((cDVec(i-1) - c_Di) / c_Di * 100); 
end

%Determining error less than 10, 1, and 0.1 percent
%10 percent
cL_Error10 = cLError <= 10;
cLN10 = find(cL_Error10);
cLN10 = cLN10(1) + 1; %Add one because the first index corresponds to 2 terms

cD_Error10 = cDError <= 10;
cDN10 = find(cD_Error10);
cDN10 = cDN10(1) + 1;

%1 percent
cL_Error1 = cLError <= 1;
cLN1 = find(cL_Error1);
cLN1 = cLN1(1) + 1;

cD_Error1 = cDError <= 1;
cDN1 = find(cD_Error1);
cDN1 = cDN1(1) + 1;

%0.1 percent
cL_Error01 = cLError <= 0.1;
cLN01 = find(cL_Error01);
cLN01 = cLN01(1) + 1;

cD_Error01 = cDError <= 0.1;
cDN01 = find(cD_Error01);
cDN01 = cDN01(1) + 1;


%Printing values to the command window
fprintf("\n-----------Problem 5-----------\n");
fprintf("Cessna 150 traveling 60 knots at 15,000 ft:\n")
fprintf("\t English Units:\n")
fprintf("\t\t Lift (lbf): %f\n", lift)
fprintf("\t\t Drag (lbf): %f\n", drag)
fprintf("\t SI Units:\n")
fprintf("\t\t Lift (N): %f\n", lift_SI)
fprintf("\t\t Drag (N): %f\n", drag_SI)
fprintf("Number of odd terms for less than 10 percent error:\n")
fprintf("\t CL: %d \n", cLN10);
fprintf("\t CDi: %d \n", cDN10);
fprintf("Number of odd terms for less than 1 percent error:\n")
fprintf("\t CL: %d \n", cLN1);
fprintf("\t CDi: %d \n", cDN1);
fprintf("Number of odd terms for less than 0.1 percent error:\n")
fprintf("\t CL: %d \n", cLN01);
fprintf("\t CDi: %d \n", cDN01);



