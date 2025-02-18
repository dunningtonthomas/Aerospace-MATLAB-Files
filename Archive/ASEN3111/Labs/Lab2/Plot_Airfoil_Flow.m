function [StreamFunction, Equipotential, Cp] = Plot_Airfoil_Flow(c,alpha,V_inf,p_inf,rho_inf,N,boolPlot)
%SUMMARY: Plot_Arifoil_Flow visualizes the streamfunction, equipotential,
%and coefficient of pressure contours for a flow over a given airfoil. It also returns 3
%different matrices with the values of the streamfunction, equipotential,
%and coefficient of pressure.
%
%INPUTS: c is the chord length, alpha is the angle of attack, V_inf is the
%free stream velocity, p_inf is the free stream pressure, rho_inf is the
%free stream density, N is the number of discrete vortices, and boolPlot is
%a boolen used to determine whether or not the plots are produced---> true
%means they are produced and false means not
%
%OUTPUTS: Create three figures of the contours of the streamfunction, the
%equipotentials, and the coefficient of pressure, also return the matrices
%associated with these three visualizations
%
%Author: Thomas Dunnington
%Collaborators: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase
%Rupprecht
%Data: 3/1/2023

%% Define the Domain
%Creating the domain of the meshgrid
xmin = -0.5*c; 
xmax = 1.5*c;
ymin = -5;
ymax = 5;

%% Define Number of Grid Points
nx=100; % steps in the x direction
ny=100; % steps in the y direction

%% Create mesh over domain using number of grid points specified
[x,y]=meshgrid(linspace(xmin,xmax,nx),linspace(ymin,ymax,ny));


%% Parameters
%Vortex Strength
gamma = @(xi)(2*alpha*V_inf*sqrt((1 - xi/c)./(xi/c)));

%Delta x along the airfoil
delX = c / N;


%% Calculate psi for vortex (Eq. 3.114)
%Function to calculate the radius for every point
%The radius is distance from the vortex center to the point in the meshgrid
yCenter = 0; %Always at y = 0
radius= @(x,y,xCenter) sqrt((x-xCenter).^2+(y-yCenter).^2);
theta = @(x,y,xCenter) (atan2(-1*y,-1*(x-xCenter)));

%3D matrix where each 2D section is the streamfunction for a vortex
Psi_Gamma_arr = zeros(nx, ny, N);
Psi_Gamma_final = zeros(nx, ny); %The total vortex streamlines

%3D matrix where each 2D section is the equipotential for a vortex
Phi_Gamma_arr = zeros(nx, ny, N);
Phi_Gamma_final = zeros(nx, ny); 

%3D matrix where each 2D section is the u component of velocity for a vortex
u_arr = zeros(nx, ny, N);
u_final = zeros(nx, ny); 

%3D matrix where each 2D section is the v component of velocity for a vortex
v_arr = zeros(nx, ny, N);
v_final = zeros(nx, ny); 

xLoc = delX / 2; %Start the vortex location at 1/2 step

%Loop through each vortex and calculate the various components as induced
%by that vortex
for i = 1:N
    %Calculating the psi due to the vortex
    Psi_Gamma_arr(:,:,i) = gamma(xLoc)*delX/(2*pi)*log(radius(x,y,xLoc));
    
    %Calculating the phi due to the vortex
    Phi_Gamma_arr(:,:,i) = -1*gamma(xLoc)*delX/(2*pi)*theta(x,y,xLoc);
    
    %Calculating the u component of velocity due to the vortex
    u_arr(:,:,i) = (gamma(xLoc)*delX*y) ./ (2*pi*radius(x,y,xLoc).^2); 
    
    %Calculating the v component of velocity due to the vortex
    v_arr(:,:,i) = -1*(gamma(xLoc)*delX*(x - xLoc)) ./ (2*pi*radius(x,y,xLoc).^2);

    %Update the next x location of the vortex
    xLoc = xLoc + delX;
end

%Adding the streamlines together
Psi_Gamma_final = sum(Psi_Gamma_arr, 3);

%Adding the equipotential lines together
Phi_Gamma_final = sum(Phi_Gamma_arr, 3);

%Adding the velocity components together
u_final = sum(u_arr, 3); 
v_final = sum(v_arr, 3); 

%% Calculating psi, phi, and velocity components for uniform flow
%We need the uniform flow to be at an angle of alpha
Psi_U0 = -1*V_inf * sin(alpha) * x + V_inf * cos(alpha) * y;

%Equipotential
Phi_U0 = V_inf * cos(alpha) * x + V_inf * sin(alpha) * y;

%Velocity components
u_uniform = V_inf * cos(alpha);
v_uniform = V_inf * sin(alpha);

%% Summing to get the final psi, phi, and velocity components
StreamFunction = Psi_Gamma_final + Psi_U0;
Equipotential = Phi_Gamma_final + Phi_U0;
uTotal = u_final + u_uniform;
vTotal = v_final + v_uniform;

%% Calculating the coefficient of pressure
Cp = 1 - (uTotal ./ V_inf).^2 - (vTotal ./ V_inf).^2;


%% Plotting
%Only continue to plot if the boolPlot variable is true
if(boolPlot)

    %% Determine color levels for contours
    %Stream function levels
    levminStream = min(StreamFunction, [], 'all');
    levmaxStream = max(StreamFunction, [], 'all');
    levelsStream = linspace(levminStream,levmaxStream,20)';
    
    %Equipotential levels
    levminEq = min(Equipotential, [], 'all');
    levmaxEq = max(Equipotential, [], 'all');
    levelsEq = linspace(levminEq,levmaxEq,20)';
    
    %Coefficient of Pressure
    levelsPress = linspace(-3,1,40);
    
    %% Plot streamfunction at levels
    figure();
    set(0, 'defaulttextinterpreter', 'latex')
    contourf(x,y,StreamFunction,levelsStream,'LineWidth',1.5)
    axis equal;
    hold on
    
    %Plot the airfoil
    plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');
    
    %Labels
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    title('\textbf{Streamlines With 500 Vortices}');
    subtitle('c = 5 m, $$\alpha = 15^{\circ}$$, $$V_{\infty} = 34$$ m/s, $$p_{\infty} = 101.3e3$$ Pa, $$\rho_{\infty} = 1.225$$ $$kg/m^{3}$$');
    c1 = colorbar;
    c1.Label.String = 'Streamfunction Value';
    
    %% Plot Equipotentials at levels
    figure();
    set(0, 'defaulttextinterpreter', 'latex')
    contourf(x,y,Equipotential,levelsEq,'LineWidth',1.5)
    axis equal;
    hold on
    
    %Plot the airfoil
    plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');
    
    %Labels
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    title('\textbf{Equipotentials With 500 Vortices}');
    subtitle('c = 5 m, $$\alpha = 15^{\circ}$$, $$V_{\infty} = 34$$ m/s, $$p_{\infty} = 101.3e3$$ Pa, $$\rho_{\infty} = 1.225$$ $$kg/m^{3}$$');
    c2 = colorbar;
    c2.Label.String = 'Equipotential Value';
    
    
    %% Plot Pressure at levels
    figure();
    set(0, 'defaulttextinterpreter', 'latex')
    contourf(x,y,Cp,levelsPress,'Linewidth',0.5)
    axis equal;
    hold on
    
    %Plot the airfoil
    plot([0 5], [0 0], 'linewidth', 2, 'color', 'r');
    
    %Labels
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    title('\textbf{Coefficient of Pressure Contours With 500 Vortices}');
    subtitle('c = 5 m, $$\alpha = 15^{\circ}$$, $$V_{\infty} = 34$$ m/s, $$p_{\infty} = 101.3e3$$ Pa, $$\rho_{\infty} = 1.225$$ $$kg/m^{3}$$');
    c3 = colorbar;
    c3.Label.String = 'Coefficient of Pressure';

end %End if statement for plotting

end %End Function

