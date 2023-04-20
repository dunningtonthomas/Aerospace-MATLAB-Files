%% Clean Up
close all; clear; clc;

%% Import Data
fileName = "bennu.obj";
test = "BennuFull.obj";

%Reading in data
[facets, vertices] = read_obj(test);

%% Orbital Path
%Declaring details of constellation design with two satellites
%Satellite Parameters
t0 = 0;
tf = 60*60*24*7; %1 week timespan
A = 3.25^2 / 1000^2;
m = 2000;

%Satellite 1 initial conditions
v0 = 0.1 / 1000; %km/s
bennu_r = 0.2625;
X0_1 = [0; bennu_r*2; 0; v0; 0; 0.5*v0];

%Satellite 2 initial conditions
v0 = 0.1 / 1000; %km/s
bennu_r = 0.2625;
X0_2 = [0; bennu_r*2; 0; -v0; 0; 0.5*v0];


%Propogate the spacecraft position
[Xout_1, OEout_1, Tout_1] = propagate_spacecraft(X0_1, t0, tf, A, m);
[Xout_2, OEout_2, Tout_2] = propagate_spacecraft(X0_2, t0, tf, A, m);


%Plotting orbit around Bennu for a full week
figure();
set(0, 'defaulttextinterpreter', 'latex');
patch('Faces', facets, 'Vertices', vertices, 'FaceColor', 'red', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
view(3);
hold on
grid on
s1 = plot3(Xout_1(:,1), Xout_1(:,2), Xout_1(:,3)); %Sat 1
s2 = plot3(Xout_2(:,1), Xout_2(:,2), Xout_2(:,3)); %Sat 2

axis equal
xlabel('X Coordinate (km)');
ylabel('Y Coordinate (km)');
zlabel('Z Coordinate (km)');
title('Bennu Satellite Constellation');
legend([s1 s2], 'Sat 1', 'Sat 2');


%% Visibility Animation
%Determining Visibility
rOut_1 = Xout_1(:,1:3);
rOut_2 = Xout_2(:,1:3);

%Create vector of rotation of the vertices due to bennu's rotation
period = 4.297461 * 3600; %Time period of Bennu
angRate = 2*pi / period;
thetaVec = t0*angRate:60*angRate:tf*angRate;
vRotated = zeros(size(vertices));

%% Plot the animation for 1 day
%Run a for loop to calculate the visible faces for the spacecraft during a
%week
warning('off');
fig2 = figure();
fig2.WindowState = 'maximized';

%Plot for 1 day
day1 = 24*60*60;

%Creating animation of visibility
for i = 10:10:length(rOut_1(:,1))
    %Clear the figure
    clf;
    
    %Rotate Bennu vertices
    rotMat = [cos(thetaVec(i)), -sin(thetaVec(i)), 0; sin(thetaVec(i)), cos(thetaVec(i)), 0; 0, 0, 1];
    for j = 1:length(vertices(:,1))
        vRotated(j,:) = (rotMat * vertices(j,:)')'; 
    end

    %Call check view for spacecraft one and two
    [observable_1, elevationAngle_1, cameraAngle_1] = check_view(rOut_1(i,:), 0xDEADBEEF, facets, vRotated, 2);
    [observable_2, elevationAngle_2, cameraAngle_2] = check_view(rOut_2(i,:), 0xDEADBEEF, facets, vRotated, 2);

    %Determine the visible facets at the given position
    obsLog_1 = observable_1 == 1;
    obsLog_2 = observable_2 == 1;

    %Get the faces that are visible
    visFaces_1 = facets(obsLog_1, :);    
    visFaces_2 = facets(obsLog_2, :);
    visFaces_both = facets(obsLog_1 & obsLog_2, :);
    invisFaces = facets(~(obsLog_1 | obsLog_2), :);


    %Plot the figure with patch
    vis1 = patch('Faces', visFaces_1, 'Vertices', vRotated, 'FaceColor', 'green', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
    axis equal
    hold on
    vis2 = patch('Faces', visFaces_2, 'Vertices', vRotated, 'FaceColor', 'blue', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
    visBoth = patch('Faces', visFaces_both, 'Vertices', vRotated, 'FaceColor', 'cyan', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
    patch('Faces', invisFaces, 'Vertices', vRotated, 'FaceColor', 'red', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
    view(3);

    %Plot the satellite location
    sc_1 = scatter3(rOut_1(i,1), rOut_1(i,2), rOut_1(i,3), 'filled', 'markerEdgecolor', 'g', 'markerFaceColor', 'g');
    text(rOut_1(i,1), rOut_1(i,2), rOut_1(i,3), 'S1');
    sc_2 = scatter3(rOut_2(i,1), rOut_2(i,2), rOut_2(i,3), 'filled', 'markerEdgecolor', 'b', 'markerFaceColor', 'b');
    text(rOut_2(i,1), rOut_2(i,2), rOut_2(i,3), 'S2');
    grid on
    
    
    %Set axis limits
    xlim([min([rOut_1(:,1); rOut_2(:,1)]) max([rOut_1(:,1); rOut_2(:,1)])]);
    ylim([min([rOut_1(:,2); rOut_2(:,2)]) max([rOut_1(:,2); rOut_2(:,2)])]);
    zlim([min([rOut_1(:,3); rOut_2(:,3)]) max([rOut_1(:,3); rOut_2(:,3)])]);
    
    %Add labels
    xlabel('X Coordinate (km)');
    ylabel('Y Coordinate (km)');
    zlabel('Z Coordinate (km)');
    title('Bennu Satellite Constellation Animation');
    legend([sc_1 sc_2 vis1 vis2 visBoth], 'Sat 1', 'Sat 2', 'Sat 1 Visibility', 'Sat 2 Visibility', 'Both Visible');
        
    drawnow limitrate;
    
    if(Tout_1(i) >= 24*60*60) %Only run for 1 day, break loop
       break; 
    end
end



%% Run the following section ONLY FOR THE FULL WEEK, UNCOMENT CODE
%WARNING: THIS SECTION TAKES A LONG TIME TO RUN
% 
%Run a for loop to calculate the visible faces for the spacecraft during a
%week
% fig3 = figure();
% fig3.WindowState = 'maximized';
% 
% %Creating animation of visibility
% for i = 10:10:length(rOut_1(:,1))
%     %Clear the figure
%     clf;
%     
%     %Rotate Bennu vertices
%     rotMat = [cos(thetaVec(i)), -sin(thetaVec(i)), 0; sin(thetaVec(i)), cos(thetaVec(i)), 0; 0, 0, 1];
%     for j = 1:length(vertices(:,1))
%         vRotated(j,:) = (rotMat * vertices(j,:)')'; 
%     end
% 
%     %Call check view for spacecraft one and two
%     [observable_1, elevationAngle_1, cameraAngle_1] = check_view(rOut_1(i,:), 0xDEADBEEF, facets, vRotated, 2);
%     [observable_2, elevationAngle_2, cameraAngle_2] = check_view(rOut_2(i,:), 0xDEADBEEF, facets, vRotated, 2);
% 
%     %Determine the visible facets at the given position
%     obsLog_1 = observable_1 == 1;
%     obsLog_2 = observable_2 == 1;
% 
%     %Get the faces that are visible
%     visFaces_1 = facets(obsLog_1, :);    
%     visFaces_2 = facets(obsLog_2, :);
%     visFaces_both = facets(obsLog_1 & obsLog_2, :);
%     invisFaces = facets(~(obsLog_1 | obsLog_2), :);
% 
% 
%     %Plot the figure with patch
%     vis1 = patch('Faces', visFaces_1, 'Vertices', vRotated, 'FaceColor', 'green', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
%     axis equal
%     hold on
%     vis2 = patch('Faces', visFaces_2, 'Vertices', vRotated, 'FaceColor', 'blue', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
%     visBoth = patch('Faces', visFaces_both, 'Vertices', vRotated, 'FaceColor', 'cyan', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
%     patch('Faces', invisFaces, 'Vertices', vRotated, 'FaceColor', 'red', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
%     view(3);
% 
%     %Plot the satellite location
%     sc_1 = scatter3(rOut_1(i,1), rOut_1(i,2), rOut_1(i,3), 'filled', 'markerEdgecolor', 'g', 'markerFaceColor', 'g');
%     text(rOut_1(i,1), rOut_1(i,2), rOut_1(i,3), 'S1');
%     sc_2 = scatter3(rOut_2(i,1), rOut_2(i,2), rOut_2(i,3), 'filled', 'markerEdgecolor', 'b', 'markerFaceColor', 'b');
%     text(rOut_2(i,1), rOut_2(i,2), rOut_2(i,3), 'S2');
%     grid on
%     
%     
%     %Set axis limits
%     xlim([min([rOut_1(:,1); rOut_2(:,1)]) max([rOut_1(:,1); rOut_2(:,1)])]);
%     ylim([min([rOut_1(:,2); rOut_2(:,2)]) max([rOut_1(:,2); rOut_2(:,2)])]);
%     zlim([min([rOut_1(:,3); rOut_2(:,3)]) max([rOut_1(:,3); rOut_2(:,3)])]);
%     
%     %Add labels
%     xlabel('X Coordinate (km)');
%     ylabel('Y Coordinate (km)');
%     zlabel('Z Coordinate (km)');
%     title('Bennu Satellite Constellation Visibility for 1 Week');
%     legend([sc_1 sc_2 vis1 vis2 visBoth], 'Sat 1', 'Sat 2', 'Sat 1 Visibility', 'Sat 2 Visibility', 'Both Visible');
%         
%     drawnow limitrate;
%     
%     movieVec(i/10) = getframe(fig3);
% end
% 
% %Save animation to a file
% vidWrite = VideoWriter('VisibilityOrbit_1Week');
% vidWrite.FrameRate = 20;
% 
% open(vidWrite);
% writeVideo(vidWrite, movieVec);
% close(vidWrite);








