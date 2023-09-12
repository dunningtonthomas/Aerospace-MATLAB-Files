%% ASEN 3111 - Computational Assignment 4 - Main

% This main script calls the ObliqueShockBeta, DiamondAirfoil, and
% LinearTheory functions to 1. compute and plot beta-theta-M plot, 2.
% calculate the coefficients of sectional lift and wave drag for an
% asymmetric airfoil, 3. compare c_l and c_dw values from shock expansion
% theory to the c_l and c_dw values from linear supersonic theory. 

% The main script is organized into the three problems with all plotting
% done at the end of each section. 

% Author: Alyxis Ellington
% Collaborators: Jake Spagnolli
% Date: 12/4/22

% clear all; clc; close all;

%% Problem 1


% theta and M vectors to be passed into Oblique shock funtion
theta_vec = linspace(0,50,100);
M_vec = linspace(1,20,100);

% Intializing variables
Beta_w = zeros(length(M_vec),length(M_vec));
Beta_s = zeros(length(M_vec),length(M_vec));


for i = 1:length(M_vec)
    
    % varrying theta for one M value
    for j = 1:length(theta_vec)       
    [Beta_w(i,j)] = ObliqueShockBeta(M_vec(i),theta_vec(j),1.4,'Weak');
    
    % extracting real values of weak solution
        if isreal(Beta_w(i,j)) == 0
        Beta_w(i,j) = NaN;
        end
    end
    
    for j = 1:length(M_vec)
    [Beta_s(i,j)] = ObliqueShockBeta(M_vec(i),theta_vec(j),1.4,'Strong');
  
     % extracting real values of strong solution
        if isreal(Beta_s(i,j)) == 0
        Beta_s(i,j) = NaN;
        end
    end
end

% plotting theta-beta-m
figure()
hold on
grid on
plot(theta_vec,transpose(Beta_w))
plot(theta_vec,transpose(Beta_s))
ylim([0,90])
ylabel('Shock-Wave Angle (deg)')
xlabel('Deflection Angle (deg)')
title('Beta-Theta-M Chart')


%% Problem 2
fprintf('\n <strong>Problem 2:</strong>\n')

% Calling DiamondAirfoil function
[c_l,c_dw] = DiamondAirfoil(3, 10, 7.5, 5);

fprintf('Sectional lift coeff: %.4f \n', c_l)
fprintf('Sectional wave drag coeff: %.4f \n', c_dw)


%% Problem 3

% Mach and alpha 
alpha_vec = linspace(-0,10,100);
M2 = 2;
M3 = 3;
M4 = 4;
M5 = 5;

% calculating coefficents at each mach and alpha value
for i = 1:length(alpha_vec)

[c_l_vec_M2(i),c_dw_vec_M2(i)] = DiamondAirfoil(M2, alpha_vec(i), 10, 5);
[c_l_vec_M3(i),c_dw_vec_M3(i)] = DiamondAirfoil(M3, alpha_vec(i), 10, 5);
[c_l_vec_M4(i),c_dw_vec_M4(i)] = DiamondAirfoil(M4, alpha_vec(i), 10, 5);
[c_l_vec_M5(i),c_dw_vec_M5(i)] = DiamondAirfoil(M5, alpha_vec(i), 10, 5);

[c_l_lin_M2(i),c_dw_lin_M2(i)] = LinearTheory(M2, alpha_vec(i), 10, 5);
[c_l_lin_M3(i),c_dw_lin_M3(i)] = LinearTheory(M3, alpha_vec(i), 10, 5);
[c_l_lin_M4(i),c_dw_lin_M4(i)] = LinearTheory(M4, alpha_vec(i), 10, 5);
[c_l_lin_M5(i),c_dw_lin_M5(i)] = LinearTheory(M5, alpha_vec(i), 10, 5);
end

%Plotting
figure()
hold on
grid on
plot(alpha_vec,c_l_vec_M2,'r')
plot(alpha_vec,c_l_lin_M2,'--','Color','r')
plot(alpha_vec,c_l_vec_M3,'b')
plot(alpha_vec,c_l_lin_M3,'--','Color','b')
plot(alpha_vec,c_l_vec_M4,'g')
plot(alpha_vec,c_l_lin_M4,'--','Color','g')
plot(alpha_vec,c_l_vec_M5,'m')
plot(alpha_vec,c_l_lin_M5,'--','Color','m')
legend({'M = 2','M = 2 linear','M = 3','M = 3 linear','M = 4','M = 4 linear','M = 5','M = 5 linear'},'Location','northwest')
ylabel('cl')
xlabel('Angle of attack (degrees)')
title('cl vs aoa')


figure()
hold on
grid on
plot(alpha_vec,c_dw_vec_M2,'r')
plot(alpha_vec,c_dw_lin_M2,'--','Color','r')
plot(alpha_vec,c_dw_vec_M3,'b')
plot(alpha_vec,c_dw_lin_M3,'--','Color','b')
plot(alpha_vec,c_dw_vec_M4,'g')
plot(alpha_vec,c_dw_lin_M4,'--','Color','g')
plot(alpha_vec,c_dw_vec_M5,'m')
plot(alpha_vec,c_dw_lin_M5,'--','Color','m')
legend({'M = 2','M = 2 linear','M = 3','M = 3 linear','M = 4','M = 4 linear','M = 5','M = 5 linear'},'Location','northwest')
ylabel('cdw')
xlabel('Angle of attack (degrees)')
title('cdw vs aoa')


