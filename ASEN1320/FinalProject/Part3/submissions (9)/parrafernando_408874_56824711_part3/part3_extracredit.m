%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%              ASEN 1320: Final Project Extra Credit                   %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% =======Close all files, clear workspace, clear command window.==========
clear; close all; clc;

%-------------------------------------------------------------------------
Sat1Position = readmatrix('Sat1Position.csv');
Sat1_xValues = Sat1Position(:,1);
Sat1_yValues = Sat1Position(:,2);
Sat1_zValues = Sat1Position(:,3);

%-------------------------------------------------------------------------
GSPosition = readmatrix('GSPosition.csv');
GSPosition_xValues = GSPosition(:,1);
GSPosition_yValues = GSPosition(:,2);
GSPosition_zValues = GSPosition(:,3);

%-------------------------------------------------------------------------
Sat2Position = readmatrix('Sat2Position.csv');
Sat2_xValues = Sat2Position(:,1);
Sat2_yValues = Sat2Position(:,2);
Sat2_zValues = Sat2Position(:,3);

%-------------------------------------------------------------------------
Sat1Visibility = readmatrix('Sat1Visibility.csv');  
Sat1LogicalVector = Sat1Visibility == 1; 

Sat1_xVisibility = Sat1_xValues(Sat1LogicalVector);  
Sat1_yVisibility = Sat1_yValues(Sat1LogicalVector);  
Sat1_zVisibility = Sat1_zValues(Sat1LogicalVector); 

GS1_xValues = GSPosition(:,1);       
GS1_yValues = GSPosition(:,2);       
GS1_zValues = GSPosition(:,3);       

GS1_xVisibility = GS1_xValues(Sat1LogicalVector);  
GS1_yVisibility = GS1_yValues(Sat1LogicalVector);  
GS1_zVisibility = GS1_zValues(Sat1LogicalVector);

% ISS Visibility Matrix
ISS_Visibility = [Sat1_xVisibility, Sat1_yVisibility, Sat1_zVisibility];
% GS_ISS Visibility Matrix
GS1_Visibility = [GS1_xVisibility, GS1_yVisibility, GS1_zVisibility];
%-------------------------------------------------------------------------
Sat2Visibility = readmatrix('Sat2Visibility.csv');
Sat2LogicalVector = Sat2Visibility == 1; 

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
%-------------------------------------------------------------------------

figh = figure();  
t = 0:60:86400;
hold on;

for k = 1:length(t)
    clf;

    t_k = t(k);
    foo = t_k / 1500; 
    Sat1x_k = Sat1_xValues(k);
    Sat1y_k = Sat1_yValues (k);
    Sat1z_k = Sat1_zValues(k); 
    
    Sat2x_k = Sat2_xValues(k);
    Sat2y_k = Sat2_yValues (k);
    Sat2z_k = Sat2_zValues(k); 

    GSx_k = GSPosition_xValues(k);
    GSy_k = GSPosition_yValues(k);
    GSz_k = GSPosition_zValues(k);
    
    plot3(Sat1_xValues, Sat1_yValues, Sat1_zValues, '-', 'LineWidth', ...
          2, 'Color',[0 0.450980392156863 0.741176470588235]);
    hold on;
    plot3(Sat1x_k, Sat1y_k, Sat1z_k, 'o', 'LineWidth', 3, 'MarkerSize', ...
          15, 'Color',[0 0.450980392156863 0.741176470588235]); 
    plot3(ISS_Visibility(:,1), ISS_Visibility(:,2), ISS_Visibility(:,3), ...
    'MarkerSize',25,'Marker','.', 'LineStyle','none', 'Color', ...
    [0 0.450980392156863 0.741176470588235]); 
    plot3(Sat2_xValues, Sat2_yValues, Sat2_zValues, '-', 'LineWidth', ... 
        2, 'Color', [0.929411764705882 0.690196078431373 0.129411764705882]);
    plot3(Sat2x_k, Sat2y_k, Sat2z_k, 'o', 'LineWidth', 3, 'MarkerSize',...
        15, 'Color', [0.929411764705882 0.690196078431373 0.129411764705882]);
    plot3(Hubble_Visibility(:,1), Hubble_Visibility(:,2), ...
      Hubble_Visibility(:,3), 'MarkerSize',25,'Marker','.','LineStyle', ...
      'none','Color',[0.929411764705882 0.690196078431373 0.129411764705882]); 
    plot3(GSPosition_xValues, GSPosition_yValues, GSPosition_zValues, ...
        '-', 'LineWidth', 2, 'Color', ... 
        [0.470588235294118 0.670588235294118 0.188235294117647]);
    plot3(GSx_k, GSy_k, GSz_k, 'o', 'LineWidth', 3, 'MarkerSize', 15, ...
        'Color', [0.470588235294118 0.670588235294118 0.188235294117647]);
    plot3(GS1_Visibility(:,1), GS1_Visibility(:,2), GS1_Visibility(:,3), ...
    'MarkerSize',25,'Marker','.', 'LineStyle','none', 'Color', ...
    [0 0.450980392156863 0.741176470588235]); 
    plot3(GS2_Visibility(:,1), GS2_Visibility(:,2), ...
      GS2_Visibility(:,3), 'MarkerSize',25,'Marker','.','LineStyle', ...
      'none','Color',[0.929411764705882 0.690196078431373 0.129411764705882]); 
    %plot3(GSPosition(1,1), GSPosition(1,2), GSPosition(1,3), '.', ....
     %   'LineWidth', 2, 'MarkerSize', 15, ...
      %  'Color', [0 0 0]);

    grid on;
    title({'International Space Station (ISS), Hubble Space Telescope, ' ... 
        ,'& Goldstone Observatory(GS) Orbits with Visibility', ...
        ' Points for One Day'}, ...
        'FontWeight','bold','FontSize',11);
    xlabel('X Position');
    ylabel('Y Position');
    zlabel('Z Position');
    legend('ISS Path', 'ISS Position', ... 
        'ISS Visibility Point' , 'Hubble Path', ...
        'Hubble Position', ' Hubble Visibility Point', ...
        'GS Path', 'GS Position');
    title(legend, 'Legend')

    annotation('textbox', [0.6, 0.2, 0.1, 0.1], 'String', "Time in minutes")
    annotation('textbox', [0.8, 0.2, 0.1, 0.1], 'String', num2str(t_k/60))

    view([29*foo 25]); 
    box on;
    ax = gca;
    ax.BoxStyle = 'full';
    figh.Color = [1 1 1];

    movieVector(k) = getframe(figh, [5 5 540 400]);

end 
 
myOrbit = VideoWriter('part3','MPEG-4'); 
myOrbit.FrameRate = 20;
open(myOrbit);
writeVideo(myOrbit, movieVector);
close(myOrbit); 

%------------------------------------------------------------------------- 



