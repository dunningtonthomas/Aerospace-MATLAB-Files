clc;
clear;
close all;

% reads in the files

filename1 = "Sat1Position.csv";
Sat1Position = readmatrix(filename1);

filename2 = "Sat2Position.csv";
Sat2Position = readmatrix(filename2);

filename3 = "Sat1Visibility.csv"; 
Sat1Visibility = readmatrix(filename3);

filename4 = "Sat2Visibility.csv";
Sat2Visibility = readmatrix(filename4);

filename5 = "GSPosition.csv";
GSPosition = readmatrix(filename5);

% determines when to put a star for the visibility and when to not plot the data
for i = 1:length(Sat1Visibility(:,1))
    x = Sat1Visibility(i,1);
    y = Sat2Visibility(i,1);
    if x == 1
        Sat1PosVis(i,:) = [Sat1Position(i,1) Sat1Position(i,2) Sat1Position(i,3)];
    end
    if x == 0
        Sat1PosVis(i,:) = [NaN, NaN, NaN];
    end

    if y == 1
        Sat2PosVis(i,:) = [Sat2Position(i,1) Sat2Position(i,2) Sat2Position(i,3)];
    end
    if y == 0
        Sat2PosVis(i,:) = [NaN, NaN, NaN];
    end

end

% Plots Earth using jpeg and sphere

original = imread('2k_earth_daymap.jpeg'); % might need this image, so I included it
imshow(original)

[x y z] = sphere;
r = -6371;
surf(r*x,r*y,r*z);
hold on

h = findobj('Type', 'surface');
set(h, 'CData', original, 'FaceColor', 'texturemap', 'edgecolor', 'none')

axis equal

% Plots 3D graph of both sattelite positions

plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3),'lineWidth', 2.5);
title('Orbit Visualization');
xlabel('X-Position');
ylabel('Y-Position');
zlabel('Z-Position');
hold on
grid on
plot3(Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3),'lineWidth', 2.5);
plot3(Sat1PosVis(:,1),Sat1PosVis(:,2),Sat1PosVis(:,3), '*', 'lineWidth', 50);
plot3(Sat2PosVis(:,1),Sat2PosVis(:,2),Sat2PosVis(:,3), '*', 'lineWidth', 50);
plot3(GSPosition(:,1),GSPosition(:,2),GSPosition(:,3),'lineWidth', 3);

legend('Earth', 'ISS','Hubble','ISS Visibility', 'Hubble Visibility', 'Ground Station');

savefig('part3.fig');

% ANIMATES THE PLOT
% 
% h = animatedline('LineStyle', '-', 'LineWidth', 2.5);
% hd = animatedline('MaximumNumPoints', 1,'Marker','.', 'MarkerSize', 40);
% 
% h2 = animatedline('LineStyle', '-', 'LineWidth', 2.5);
% h2d = animatedline('MaximumNumPoints', 1, 'Marker','.', 'MarkerSize', 40);
% 
% h3 = animatedline('LineStyle', '-', 'LineWidth', 2.5);
% h3d = animatedline('MaximumNumPoints', 1, 'Marker','.', 'MarkerSize', 40);
% 
% % HOW DO YOU ROTATE A SPHERE
% 
% x = Sat1Position(:,1);
% y = Sat1Position(:,2);
% z = Sat1Position(:,3);
% 
% xd = Sat1Position(:,1);
% yd = Sat1Position(:,2);
% zd = Sat1Position(:,3);
% 
% x2 = Sat2Position(:,1);
% y2 = Sat2Position(:,2);
% z2 = Sat2Position(:,3);
% 
% x2d = Sat2Position(:,1);
% y2d = Sat2Position(:,2);
% z2d = Sat2Position(:,3);
% 
% x3 = GSPosition(:,1);
% y3 = GSPosition(:,2);
% z3 = GSPosition(:,3);
% 
% x3d = GSPosition(:,1);
% y3d = GSPosition(:,2);
% z3d = GSPosition(:,3);
% 
% for k = 1:length(x)
%     addpoints(h,x(k),y(k),z(k));
%     drawnow;
%     addpoints(hd,xd(k),yd(k),zd(k));
%     drawnow;
% 
%     addpoints(h2,x2(k),y2(k),z2(k));
%     drawnow;
%     addpoints(h2d,x2d(k),y2d(k),z2d(k));
%     drawnow;
% 
%     addpoints(h3,x3(k),y3(k),z3(k));
%     drawnow;
% 
%     addpoints(h3d,x3d(k),y3d(k),z3d(k));
%     drawnow;
% end
% 
% obj = videoWriter('part3extracredit.mp4');
% obj.Quality = 100;
% obj.FrameRate = 30;
% open(obj);
% for i = 1:length(Sat1Visibility(:,1))
%     writeVideo(obj, frames(i));
% end
% obj.close();

