%% Clean up
clear; close all; clc;


%% Finding the k3 value
%Constants
mass = 0.068;       %kg
radialDist = 0.06;  %m
km = 0.0024;    %N*m/N, controlMomentCoeff
nu = 1e-3;          %N/(m/s)^2, aeroForceCoeff
mu = 2e-6;         %N*m/(rad/s)^2, aeroMomentCoeff
g = 9.81;
Ix = 5.8e-5;    %kg*m^2
Iy = 7.2e-5;    %kg*m^2
Iz = 1.0e-4;   %kg*m^2
I = [Ix, 0, 0; 0, Iy, 0; 0, 0, Iz];


%Longitudinal
k1Long = 0.0016;
k2Long = 0.0029;

%Lateral
k1Lat = 0.0013;
k2Lat = 0.0023;
k3Lat = 0;


%Setting up the A matrix for lateral dynamics
A = [0, g, 0; 0, 0, 1; -k3Lat, -k2Lat, -k1Lat];

%Setting up various k3 values
k3Values = linspace(-0.001,0.001,1000);

%Eig returns 3 by 1 eigenvalues
eigenVec = zeros(length(k3Values), 3);

%Calculating the eigenvalues
%Imaginary tolerance
tolerance = 0.025;


for i = 1:length(k3Values)
    k3Lat = k3Values(i);
    A = [0, g, 0; 0, 0, 1; -k3Lat/Ix, -k2Lat/Ix, -k1Lat/Ix];
    eigenVec(i,:) = eig(A)';
    
    %Try to find the k3 value that gives us three eigenvalues that are
    %negative and all real within some tolerance
    imagComponents = imag(eigenVec(i,:));
    realComponents = real(eigenVec(i,:));   
end

%Getting the eigenvalue for k3
finalK3Value = k3Values(554);
A = [0, g, 0; 0, 0, 1; -finalK3Value/Ix, -k2Lat/Ix, -k1Lat/Ix];
eigenFinal = eig(A);
scatter(real(eigenFinal), imag(eigenFinal));

%Plotting the root locus plot
figure();
scatter(real(eigenVec(:,1)), imag(eigenVec(:,1)), 'r');
hold on
scatter(real(eigenVec(:,2)), imag(eigenVec(:,2)), 'r');
scatter(real(eigenVec(:,3)), imag(eigenVec(:,3)), 'r');
scatter(real(eigenFinal), imag(eigenFinal), 'g', 'filled');








