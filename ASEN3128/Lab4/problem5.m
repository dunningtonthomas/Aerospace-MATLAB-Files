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
k3Long = 0;

%Lateral
k1Lat = 0.0013;
k2Lat = 0.0023;
k3Lat = 0;


%Setting up the A matrix for lateral dynamics
Alat = [0, g, 0; 0, 0, 1; -k3Lat, -k2Lat, -k1Lat];

%Setting up the A matrix for longitudinal dynamics
Along = [0, -g, 0,; 0, 0, 1; -k3Long, -k2Long, -k1Long];

%Setting up various k3 values
k3Values = linspace(-0.001,0.001,1000);

%Eig returns 3 by 1 eigenvalues
eigenVecLat = zeros(length(k3Values), 3);
eigenVecLong = zeros(length(k3Values), 3);

%Calculating the eigenvalues
%Imaginary tolerance
tolerance = 0.025;


for i = 1:length(k3Values)
    k3Lat = k3Values(i);
    k3Long = k3Values(i);
    Alat = [0, g, 0; 0, 0, 1; -k3Lat/Ix, -k2Lat/Ix, -k1Lat/Ix];
    Along = [0, -g, 0,; 0, 0, 1; -k3Long/Iy, -k2Long/Iy, -k1Long/Iy];
    eigenVecLat(i,:) = eig(Alat)';
    eigenVecLong(i,:) = eig(Along)';
    
    %Try to find the k3 value that gives us three eigenvalues that are
    %negative and all real within some tolerance
    imagComponents = imag(eigenVecLat(i,:));
    realComponents = real(eigenVecLat(i,:));
    
    realComponentsLong = real(eigenVecLong(i,:));
    
    if(realComponentsLong(1) == -1.04722 || realComponentsLong(2) == -1.04722 || realComponentsLong(3) == -1.04722)
        x = 5
    end
end


%Getting the eigenvalue for k3
%Lateral
finalK3ValueLat = k3Values(554);
Alat = [0, g, 0; 0, 0, 1; -finalK3ValueLat/Ix, -k2Lat/Ix, -k1Lat/Ix];
eigenFinalLat = eig(Alat);


%Longitudinal
finalK3ValueLong = k3Values(431);
Along = [0, -g, 0; 0, 0, 1; -finalK3ValueLong/Iy, -k2Long/Iy, -k1Long/Iy];
eigenFinalLong = eig(Along);
scatter(real(eigenFinalLong), imag(eigenFinalLong));


%Plotting the root locus plots
%Lateral dynamics
figure();
scatter(real(eigenVecLat(:,1)), imag(eigenVecLat(:,1)), 'r');
hold on
scatter(real(eigenVecLat(:,2)), imag(eigenVecLat(:,2)), 'r');
scatter(real(eigenVecLat(:,3)), imag(eigenVecLat(:,3)), 'r');
scatter(real(eigenFinalLat), imag(eigenFinalLat), 'g', 'filled');

title('Lateral');



%Longitudinal
figure();
scatter(real(eigenVecLong(:,1)), imag(eigenVecLong(:,1)), 'r');
hold on
scatter(real(eigenVecLong(:,2)), imag(eigenVecLong(:,2)), 'r');
scatter(real(eigenVecLong(:,3)), imag(eigenVecLong(:,3)), 'r');
scatter(real(eigenFinalLong), imag(eigenFinalLong), 'g', 'filled');

title('Longitudinal');






