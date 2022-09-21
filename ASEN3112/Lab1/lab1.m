%% Clean Up 
close all; clear; clc;


%% Import Data
data20 = readmatrix('20inlbf_005.txt');
data400 = readmatrix('400inlbf_04.txt');

time20 = data20(:,1);
angle20 = data20(:,2);
shear20 = data20(:,3)* pi/180;
torque20 = data20(:,4);
axial20 = data20(:,5);


time400 = data400(:,1);
angle400 = data400(:,2);
shear400 = data400(:,3) * pi/180;
torque400 = data400(:,4);
axial400 = data400(:,5);


%% Analysis Open Wall
%Constants
radius = 0.5; %in
length = 10; %in
thickness = 0.0625; %in
G = 3.75e6; %psi

%Finding shear strain from the twist angle
gamma20 = (thickness * (angle20 * pi/180)) / length;

%Performing the least squares linear regression on the calculated shear
%strain
coeff1 = polyfit(gamma20, torque20, 1);

gammaFit20 = linspace(5.04e-3,5.24e-3,100);
torqueGammaFit20 = polyval(coeff1, gammaFit20);


%Performing least squares linear regression on the raw data
dphiDx = shear20;
coeff2 = polyfit(dphiDx, torque20, 1);

torsionEpsilonFit20 = linspace(-2.5e-3,0.5e-3,100);
torqueFit20 = polyval(coeff2, torsionEpsilonFit20);

%Finding the torsional rigidity
torsionalRigidity20_1 = coeff1(1);
torsionalRigidity20_2 = coeff2(1);

%Calculated J values
J20_1 = torsionalRigidity20_1 / G;
J20_2 = torsionalRigidity20_2 / G;

%% Analysis Closed Wall

%Finding shear strain from the twist angle
gamma400 = (thickness * (angle400 * pi/180)) / length;

%Performing the least squares linear regression on the calculated shear
%strain
coeff1 = polyfit(gamma400, torque400, 1);

gammaFit400 = linspace(5.04e-3,5.24e-3,100);
torqueGammaFit400 = polyval(coeff1, gammaFit400);


%Performing least squares linear regression on the raw data
dphiDx = shear400;
coeff2 = polyfit(dphiDx, torque400, 1);

torsionEpsilonFit400 = linspace(-2.5e-3,0.5e-3,100);
torqueFit400 = polyval(coeff2, torsionEpsilonFit400);

%Finding the torsional rigidity
torsionalRigidity400_1 = coeff1(1);
torsionalRigidity400_2 = coeff2(1);

%Calculated J values
J400_1 = torsionalRigidity400_1 / G;
J400_2 = torsionalRigidity400_2 / G;


%% Plotting
%Plotting torque over the deformation, the slope is the torsional rigidity
figure();
plot(shear20, torque20);
hold on
%plot(torsionEpsilonFit20, torqueFit20);

%Plotting torque over the deformation by calculating the 
figure();
plot(gamma20, torque20);
hold on
%plot(gammaFit20, torqueGammaFit20);





