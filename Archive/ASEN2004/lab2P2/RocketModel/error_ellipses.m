clc; clear all; close all; 
 
%% Replace this section of code with your real data
impacts = readmatrix('impacts.csv');
baseImpact = readmatrix('baseImpact.csv');
xBase = baseImpact(1);
yBase = baseImpact(2);
x = impacts(:,1); % Randomly create some x data, meters
y = impacts(:,2); % Randomly create some y data, meters
%%

figure; plot(x,y,'k.','markersize',6)
axis equal; grid on; xlabel('x [m]'); ylabel('y [m]'); hold on;
plot(xBase,yBase,'-h', 'LineStyle', 'none', 'color', 'r', 'MarkerSize',12, 'MarkerFaceColor', 'r');
 
% Calculate covariance matrix
P = cov(x,y);
mean_x = mean(x);
mean_y = mean(y);
 
% Calculate the define the error ellipses
n=100; % Number of points around ellipse
p=0:pi/n:2*pi; % angles around a circle
 
[eigvec,eigval] = eig(P); % Compute eigen-stuff
xy_vect = [cos(p'),sin(p')] * sqrt(eigval) * eigvec'; % Transformation
x_vect = xy_vect(:,1);
y_vect = xy_vect(:,2);
 
% Plot the error ellipses overlaid on the same figure
plot(1*x_vect+mean_x, 1*y_vect+mean_y, 'b')
plot(2*x_vect+mean_x, 2*y_vect+mean_y, 'g')
plot(3*x_vect+mean_x, 3*y_vect+mean_y, 'r')

title('Monte Carlo Simulation');
legend('Impact Points', 'Predicted Impact', '1 $\sigma$', '2 $\sigma$', '3 $\sigma$', 'Interpreter','latex');
