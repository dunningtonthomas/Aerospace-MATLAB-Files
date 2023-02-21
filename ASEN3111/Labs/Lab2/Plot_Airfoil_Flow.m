function Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N)
%SUMMARY: 
%INPUTS:
%OUTPUTS: Return nothing, plot the flow

%% Define the Domain
xmin = -2*c; %2 times the chord
xmax = 2*c;
ymin = -c;
ymax = c;

%% Define Number of Grid Points
nx=100; % steps in the x direction
ny=100; % steps in the y direction

%% Create mesh over domain using number of grid points specified
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));


%% Parameters
%Vortex Strength
gamma = @(xi)(2*alpha*V_inf*sqrt((1 - xi./c)/(xi./c)));

%Delta x along the airfoil
delX = c / N;


%% Calculate psi for vortex (Eq. 3.114)
%Function to calculate the radius for every point
%The radius is distance from the vortex center to the point in the meshgrid
yCenter = 0; %Always at y = 0
radius= @(x,y,xCenter,yCenter) sqrt((x-xCenter).^2+(y-yCenter).^2);

%The radius from the vortices is the
Psi_Gamma = gamma/(2*pi)*log();



end

