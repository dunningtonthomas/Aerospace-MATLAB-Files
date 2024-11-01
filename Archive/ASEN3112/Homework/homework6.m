%% Clean up
close all; clear; clc;



%% Problem 3

vxFunc = @(x)(-2.0833e-4*(3*(x/0.5).^2 - 2*(x/0.5).^3) + 0.5*(-6.25e-4)*((x/0.5).^3 - (x/0.5).^2));

vxPrimeFunc = @(x)(-2.0833e-4*(24*x - 48*x.^2) + 0.5*(-6.25e-4)*(24*x.^2 - 8*x));

mxFunc = @(x)(10^6 * (-2.0833e-4 *(24 - 96*x) + 0.5 * (-6.25e-4)*(48*x - 8)));

xPlot = linspace(0,0.5,100); %length of the bar


%Plotting
%Displacements
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(xPlot, vxFunc(xPlot), 'linewidth', 2);

xlabel('Distance Along the Beam $$(m)$$')
ylabel('Displacement $$(m)$$');
title('Displacement of Points Along the Beam');

%Rotation
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(xPlot, vxPrimeFunc(xPlot), 'linewidth', 2, 'color', 'r');

xlabel('Distance Along the Beam $$(m)$$')
ylabel('Rotation $$(rad)$$');
title('Rotations of Points Along the Beam');

%Bending Moment
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(xPlot, mxFunc(xPlot), 'linewidth', 2, 'color', 'm');

xlabel('Distance Along the Beam $$(m)$$')
ylabel('Bending Moment $$(Nm)$$');
title('Bending Moments Along the Beam');


