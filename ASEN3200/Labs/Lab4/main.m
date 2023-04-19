%% Clean Up
close all; clear; clc;

%% Import Data
fileName = "bennu.obj";
test = "BennuFull.obj";

%Reading in data
[facets, vertices] = read_obj(fileName);

%% Analysis
%Plot Bennu
figure();
set(0, 'defaulttextinterpreter', 'latex');
patch('Faces', facets, 'Vertices', vertices, 'FaceColor', 'red', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
view(3);
axis equal

xlabel('X Coordinate');
ylabel('Y Coordinate');
zlabel('Z Coordinate');
title('Bennu');


%Testing propagate_spacecraft
v0 = 0.1 / 1000; %km/s
bennu_r = 0.2625;
X0 = [0; bennu_r*2; 0; v0; 0; 0.5*v0];

t0 = 0;
tf = 60*60*24*7; %1 week timespan
A = 3.25^2 / 1000^2;
m = 2000;

X0 = [0; 2; 0; v0; 0; 0.5*v0];


%Propogate the spacecraft position
[Xout, OEout, Tout] = propagate_spacecraft(X0, t0, tf, A, m);


%Plotting orbit
hold on
plot3(Xout(:,1), Xout(:,2), Xout(:,3));


%Check view call
rOut = Xout(:,1:3);

%For every facet calculate the elevation and camera angle and calculate
%whether or not is is observable
warning('off');
[observable, elevationAngle, cameraAngle] = check_view(rOut(1,:), 0xDEADBEEF, facets, vertices);

%clf clears figure
%animateline
%drawnow
%limitrate

%Run a for loop to calculate the visible faces for the spacecraft during a
%week
for i = 1:length(rOut(:,1))
    %Clear the figure
    clf;

    %Call check view
    [observable, elevationAngle, cameraAngle] = check_view(rOut(i,:), 0xDEADBEEF, facets, vertices);

    %Determine the visible facets at the given position
    obsLog = observable == 1;

    %Get the faces that are visible
    visFaces = facets(obsLog, :);
    invisFaces = facets(~obsLog, :);


    %Plot the figure with patch
    patch('Faces', visFaces, 'Vertices', vertices, 'FaceColor', 'green', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
    hold on
    patch('Faces', invisFaces, 'Vertices', vertices, 'FaceColor', 'red', 'EdgeColor', [0.5 0.5 0.5], 'linestyle', ':');
    view(3);

    %Plot the satellite location


        
    drawnow limitrate;
end






