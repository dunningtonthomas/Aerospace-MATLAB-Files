%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%                ASEN 1320: Final Project Part 1                       %
%          Main Program File from the Modular Program                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% =======Close all files, clear workspace, clear command window.==========
clear all; close all; clc;

% ========================= VARIABLE DECLARATION ========================
% Position of the two Low-Earth-Orbit(LEO) spacecrafts in Earth Centered
% Inertial (ECI) coordinates [x; y; x], and spacecraft velocities [vx; vy;
% vz] directions  respectively. 

Sat1 = [1986.2; 6388.2; -1237.2; ...        % ISS    [ x;  y;  z; 
       -4.93  ; 0.40  ;  -5.83];            %         vx; vy; vz]
Sat2 = [6480.8; 1108.2; -2145.5; ...        % Hubble [x;  y;  z; 
        -0.29 ; 7.07  ;  2.75 ];            %         vx; vy; vz]

GS = [-2314.87; 4663.275; 3673.747];        % Goldstone Observatory 
                                            % Position [x0; y0; z0]
%-------------------------------------------------------------------------
tspan = 0:60:86400;         % Time used to generate position & velocity 
                            % every 60 seconds for a given day.  
tolerance = 1e-12;          % Absolute Error Tolearnce

% ========================== ANALYSIS ====================================

% Anonymous Functions with Function Handle
% functionReference = @operator(arguements)functionbody(inputs);
f = @OrbitEOM; 

options1 = odeset('RelTol', tolerance , 'AbsTol', tolerance);

% [out1, out2]= ode45(fucntionHandle, timeSpan, initialConditions, options) 
[~, OrbitEOMSat1] = ode45(f, tspan, Sat1, options1);    % ISS Outputs
[t, OrbitEOMSat2] = ode45(f, tspan, Sat2, options1);    % Hubble Ouputs

Sat1Position = OrbitEOMSat1(:, (1:3));  % First 3 columns of Outputs are
Sat2Position = OrbitEOMSat2(:, (1:3));  % the position of each spacecraft

%-----------------------Write a matrix to a file---------------------------
writematrix(Sat1Position, 'Sat1Position.csv');
writematrix(Sat2Position, 'Sat2Position.csv');

%----------------------------Plot Command----------------------------------
figure('Name', 'part1.fig')
plot3(Sat1Position(:,1), Sat1Position(:,2), Sat1Position(:,3)); 
hold on; 
grid on;
plot3(Sat2Position(:,1), Sat2Position(:,2), Sat2Position(:,3));
title({'International Space Station (ISS) ',['& Hubble Space Telescope' ...
       ' Positions  ']},'FontWeight','bold','FontSize',11);
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
legend('ISS', 'Hubble'); 
%-------------------------------------------------------------------------