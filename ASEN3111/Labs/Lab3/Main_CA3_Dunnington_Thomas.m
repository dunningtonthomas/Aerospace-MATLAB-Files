%% ASEN 3111 - Computational Assignment 3 - Main
%SUMMARY: 
%
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase
% Rupprecht
% Date: 4/6/2023

%% Clean Up
close all; clear; clc;

%% Problem 1
%NACA 0012 airfoil
m = 0;
p = 0;
t = 12 / 100;
c = 5; %Doesn't matter for CL
N = 1000; %Number of panels for the "true" value

%Parameters
AoA = 10; %degrees
Vinf = 100; %Doesn't matter for CL

%Calling Naca function to get the x and y coordinates of the airfoil
[x1,y1] = NACA_Airfoils(m,p,t,c,N);

%Apply vortex panel method to get the CL
CL_NACA0012 = Vortex_Panel(x1,y1,100,10); %AoA of 10 degrees

%Determining the number of panels required to be within 1% error
% CL_Vec = zeros(N/10, 1);
% k = 1;
% for i = 10:10:N
%     %Calling with i panels
%     [xTemp,yTemp] = NACA_Airfoils(m,p,t,c,i);
%     CL_Vec(i/10) = Vortex_Panel(xTemp,yTemp,100,10);
% 
%     %Calculating error
%     relError = (CL_Vec(i/10) - CL_NACA0012) ./ CL_NACA0012 * 100;
%     if(abs(relError) < 1)
%         validPanels(k) = i;
%         k = k + 1; %Update iterator
%     end
% end
% 
% numPanels = validPanels(1); %Error is less than 1%

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
fprintf("\tNACA 0012 Sectional Lift Coefficient at 10 Degrees AoA: %f\n", CL_NACA0012);
fprintf("\tNumber of panels required for less than 1 percent relative error: %d\n\n", numPanels-2); %Subtract two because leading edge and trailing edge are double counted


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
plot(AoAVec, 2*pi*pi/180 *AoAVec, 'linewidth', 2)

title('Sectional Lift Coefficient Versus Angle of Attack');
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
fprintf('\t\tZero Lift Angle of Attack (deg): %f\n', zeroAOA_0006)
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

%Calculating the cl versus aoa
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
figure()
set(0, 'defaulttextinterpreter', 'latex');
plot(AoAVec, CL_0012, 'linewidth', 2, 'color', 'r');
hold on;
grid on;
plot(AoAVec, CL_2412, 'linewidth', 2, 'color', 'm');
plot(AoAVec, CL_4412, 'linewidth', 2, 'color', 'b');
%Plotting thin airfoil theory
% plot(AoAVec, polyval([2*pi*pi/180, 0], AoAVec), 'linestyle', '--', 'color', 'r');
% plot(AoAVec, polyval([2*pi*pi/180, alphaTA_L0_2412], AoAVec), 'linestyle', '--', 'color', 'm');
% plot(AoAVec, polyval([2*pi*pi/180, alphaTA_L0_4412], AoAVec), 'linestyle', '--', 'color', 'b');


title('Sectional Lift Coefficient Versus Angle of Attack');
xlabel('Angle of Attack ($$^{\circ}$$)');
ylabel('Sectional Coefficient of Lift $$c_{l}$$');
legend('NACA 0012', 'NACA 2412', 'NACA 4412', 'location', 'nw')


%Performing linear regression to get the lift slope and the zero angle of
%attack
coeff2412 = polyfit(AoAVec, CL_2412, 1);
coeff4412 = polyfit(AoAVec, CL_4412, 1);

%Finding zero lift angle of attack
zeroAOA_2412 = roots(coeff2412);
zeroAOA_4412 = roots(coeff4412);

%Printing to the command window
fprintf("-----------Problem 3-----------\n");
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

%%TODO
%Plot thin airfoil theory on top of vortex panels
%Problem 4

