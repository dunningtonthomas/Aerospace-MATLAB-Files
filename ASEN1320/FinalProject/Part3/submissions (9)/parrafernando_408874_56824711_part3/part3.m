%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%                ASEN 1320: Final Project Part 3                       %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% =======Close all files, clear workspace, clear command window.==========
clear all; close all; clc;

%--------------Read in CSV Files for Object Positions----------------------
Sat1Position = readmatrix('Sat1Position.csv');
Sat2Position = readmatrix('Sat2Position.csv');
GSPosition = readmatrix('GSPosition.csv');

%-------Create a Logical Vector for ISS's visibility points from-----------
%----------our Visibility CSV file for x, y, and z coordniates-------------

Sat1Visibility = readmatrix('Sat1Visibility.csv');  
Sat1LogicalVector = Sat1Visibility == 1; % LogicalVector = FileName == 1

% CoordinateValue = ISS_Position(All Rows, Column)
Sat1_xValues = Sat1Position(:,1);       % Retrieve x, y, and z values
Sat1_yValues = Sat1Position(:,2);       % from its respective column 
Sat1_zValues = Sat1Position(:,3);       % and storing them individually 
                                        % to its respective coordinate
Sat1_xVisibility = Sat1_xValues(Sat1LogicalVector); % if yes (1), then 
Sat1_yVisibility = Sat1_yValues(Sat1LogicalVector); % store ISS Position 
Sat1_zVisibility = Sat1_zValues(Sat1LogicalVector); % to its respective 
                                                    % coordinate to
                                                    % identify it as a
                                                    % visibility point

% CoordinateValue = GS_ISS_Position(All Rows, Column)
GS1_xValues = GSPosition(:,1);       % Retrieve x, y, and z values
GS1_yValues = GSPosition(:,2);       % from its respective column 
GS1_zValues = GSPosition(:,3);       % and storing them individually 
                                     % to its respective coordinate
GS1_xVisibility = GS1_xValues(Sat1LogicalVector); % if yes (1), then 
GS1_yVisibility = GS1_yValues(Sat1LogicalVector); % store GS Position 
GS1_zVisibility = GS1_zValues(Sat1LogicalVector); % to its respective 
                                                    % coordinate to
                                                    % identify it as a
                                                    % visibility point
% ISS Visibility Matrix
ISS_Visibility = [Sat1_xVisibility, Sat1_yVisibility, Sat1_zVisibility];
% GS_ISS Visibility Matrix
GS1_Visibility = [GS1_xVisibility, GS1_yVisibility, GS1_zVisibility];


%-----Create a Logical Vector for Hubble's visibility points from----------
%----------our Visibility CSV file for x, y, and z coordniates-------------
%--------------------Repeat same process as above--------------------------

Sat2Visibility = readmatrix('Sat2Visibility.csv');       
Sat2LogicalVector = Sat2Visibility == 1;       

Sat2_xValues = Sat2Position(:,1);
Sat2_yValues = Sat2Position(:,2);
Sat2_zValues = Sat2Position(:,3);

Sat2_xVisibility = Sat2_xValues(Sat2LogicalVector);
Sat2_yVisibility = Sat2_yValues(Sat2LogicalVector);
Sat2_zVisibility = Sat2_zValues(Sat2LogicalVector);

GS2_xValues = GSPosition(:,1);      
GS2_yValues = GSPosition(:,2);       
GS2_zValues = GSPosition(:,3);       
                                     
GS2_xVisibility = GS2_xValues(Sat2LogicalVector);  
GS2_yVisibility = GS2_yValues(Sat2LogicalVector); 
GS2_zVisibility = GS2_zValues(Sat2LogicalVector); 
                                                 
% Hubble Visibility Matrix
Hubble_Visibility = [Sat2_xVisibility, Sat2_yVisibility, Sat2_zVisibility];
% GS_Hubble Visibility Matrix
GS2_Visibility = [GS2_xVisibility, GS2_yVisibility, GS2_zVisibility];


%------------------------Plotting Commands---------------------------------

%figure('Name'); 

plot3(Sat1Position(:,1), Sat1Position(:,2), Sat1Position(:,3), ...
      'LineWidth',2.5); 
hold on; 
plot3(Sat2Position(:,1), Sat2Position(:,2), Sat2Position(:,3), ...
      'LineWidth',2.5);
plot3(GSPosition(:,1), GSPosition(:,2), GSPosition(:,3), 'LineWidth',2.5);

plot3(ISS_Visibility(:,1), ISS_Visibility(:,2), ISS_Visibility(:,3), ...
    'MarkerSize',25,'Marker','.', 'LineStyle','none', 'Color', ...
    [1 0.0745098039215686 0.650980392156863]);
plot3(Hubble_Visibility(:,1), Hubble_Visibility(:,2), ...
      Hubble_Visibility(:,3), 'MarkerSize',25,'Marker','.','LineStyle', ...
      'none','Color',[0 1 0]);
plot3(GS1_Visibility(:,1), GS1_Visibility(:,2), ...
      GS1_Visibility(:,3), 'MarkerSize',25,'Marker','.', ...
      'LineStyle','none', 'Color', ...
      [1 0.0745098039215686 0.650980392156863]);
plot3(GS2_Visibility(:,1), GS2_Visibility(:,2), ...
      GS2_Visibility(:,3), 'MarkerSize',25,'Marker','.', ... 
      'LineStyle', 'none','Color',[0 1 0]);
grid on;
title({'International Space Station (ISS), Hubble Space Telescope, ' ... 
        ,'& Goldstone Observatory Orbits with Visibility Points'}, ...
        'FontWeight','bold','FontSize',11);
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
legend('ISS Path', 'Hubble Path', 'Goldstone Observatory Path', ...
        'ISS Visibility Point', 'Hubble Visibility Point');
title(legend, 'Legend');

%==========================================================================
