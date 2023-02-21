% Lifting Cylinder Example:
%
% This script plots the streamlines for the flow around a cylinder with
% circulation.  The flow is constructed through the superposition of: 
%   1. a uniform flow, 
%   2. a dipole (source and sink at the same location), and 
%   3. a vortex.  
% The output is a plot showing the streamlines around the cylinder.

clear;
close all;
clc;

%% Define Domain
xmin=-3.5;
xmax=1.5;
ymin=-3.0;
ymax=1.5;

%% Define Number of Grid Points
nx=100; % steps in the x direction
ny=100; % steps in the y direction

%% Create mesh over domain using number of grid points specified
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));

%% Define Flow Parameters

U0 = 5.0;      % Uniform flow velocity

x_cyl = -1.0;  % x-location of cylinder
y_cyl = -1.0;  % y-location of cylinder
R_cyl = 1.0;   % Radius of cylinder

kappa = 2*pi*U0*R_cyl^2; % Dipole strength
Gamma = -8*pi;            % Vortex strength

%% Define a function which calculates the radius.
% Center of circle = (x1,y1)
radius= @(x,y,x1,y1) sqrt((x-x1).^2+(y-y1).^2);

%% Calculate psi for uniform stream (Eq. 3.55)
Psi_U0 = U0*y;

%% Calculate psi for doublet or dipole (Eq. 3.87)
Psi_K = -kappa/(2*pi)*sin(atan2(y-y_cyl,x-x_cyl))./(radius(x,y,x_cyl,y_cyl));

%% Calculate psi for vortex (Eq. 3.114)
Psi_Gamma = Gamma/(2*pi)*log(radius(x,y,x_cyl,y_cyl));

%% Add all streamfunctions together
StreamFunction = Psi_U0 + Psi_Gamma + Psi_K;

%% Determine color levels for contours
levmin = StreamFunction(1,nx); % defines the color levels -> trial and error to find a good representation
levmax = StreamFunction(ny,nx/2);
levels = linspace(levmin,levmax,50)';

%% Plot streamfunction at levels
contour(x,y,StreamFunction,levels,'LineWidth',1.5)

%% Plot cylinder on same graph
theta=linspace(0,2*pi);

figure(1)
hold on;
plot(x_cyl+R_cyl*cos(theta),y_cyl+R_cyl*sin(theta),'k');
hold off;

%% Adjust axis and label figure
axis equal
axis([xmin xmax ymin ymax])
ylabel('y')
xlabel('x')
