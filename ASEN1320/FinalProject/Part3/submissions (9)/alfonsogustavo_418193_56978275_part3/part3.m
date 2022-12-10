close all;clear all;clc

%Loads the data files as readable matricies
GsPosition = readmatrix("GSPosition.csv");
Sat1Position = readmatrix("Sat1Position.csv");
Sat2Position = readmatrix("Sat2Position.csv");
Sat1Vis = readmatrix("Sat1Visibility.csv");
Sat2Vis = readmatrix("Sat2Visibility.csv");

%Names the figure
figure('Name',"Part3") %creates name for figure

%Plots the orbits in 3D plot
plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3))%creates 3d plot for sat1
hold on %keeps sat 2 on the same plot
plot3(Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3))%adds sat2 to the plot
hold on
plot3(GsPosition(:,1),GsPosition(:,2),GsPosition(:,3))
hold on


%Runs through all the values from the sat visibility csv files and if it is
%visible(value of 1), it ouputs a green diamond on that point
for i = 1:1441
    if Sat1Vis(i) == 1 
        plot3(Sat1Position(i,1),Sat1Position(i,2),Sat1Position(i,3),'diamondg')
        hold on
    end
end
for i = 1:1440
    if Sat2Vis(i) == 1
        plot3(Sat2Position(i,1),Sat2Position(i,2),Sat2Position(i,3),'diamondg')
        hold on    
    end
end


grid on 
xlabel("X","FontSize",14) %FontSize option set to 14 to improve visibility and clarity
ylabel("Y","FontSize",14)
zlabel("Z","FontSize",14)
title("Orbits of ISS and Hubble Telescope during 1 day","FontSize",14)
legend({'ISS','Hubble Telescope','Ground Station','Visible to GS'},'FontSize',14,'Location','southwest')%creates legend and moves it to a better position(bottom left)
savefig("part3.fig")%saves the plot as a .fig file 
