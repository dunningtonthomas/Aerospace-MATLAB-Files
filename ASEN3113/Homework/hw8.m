%% Clean Up
clear; close all; clc;


%% Problem 1

c1 = 3.74177 * 10^8;
c2 = 1.43878e4;

lambda = linspace(0.01,1000,1000000);
T = 5780;

E = c1 ./ ((lambda.^5).*(exp(c2./(lambda.*T))-1));



%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(lambda, E, 'linewidth', 2);
set(gca, 'XScale', 'log')
%set(gca, 'YScale', 'log')

title('Emissive Power of the SUN');
xlabel('Wavelength ($$ \mu m $$)');
ylabel('Emissive Power ($$ W/m^{2} \cdot \mu m $$)');



