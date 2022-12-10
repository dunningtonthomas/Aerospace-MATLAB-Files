clear; clc; close all; 

%Loading the x,y,z positions:
Sat1_position = readmatrix("Sat1Position.csv");
Sat2_position = readmatrix("Sat2Position.csv");
Sat1_visibility = readmatrix("Sat1Visibility.csv");
Sat2_visibility = readmatrix("Sat2Visibility.csv");

%Variable Declaration:
Sat1_x = Sat1_position(:,1);
Sat1_y = Sat1_position(:,2);
Sat1_z = Sat1_position(:,3);
Sat2_x = Sat2_position(:,1);
Sat2_y = Sat2_position(:,2);
Sat2_z = Sat2_position(:,3);

%Plotting Sat1_position and Sat2_position orbits:
plot3(Sat1_x,Sat1_y,Sat1_z);
hold on
plot3(Sat2_x,Sat2_y,Sat2_z);

%Nested for-loop to plot when it's 1:
for i=1:length(Sat1_visibility)
    if (Sat1_visibility(i) == 1)
        scatter3(Sat1_x(i),Sat1_y(i),Sat1_z(i),'ko');
    end
end

for j=1:length(Sat2_visibility)
    if (Sat2_visibility(j) == 1)
        scatter3(Sat2_x(j),Sat2_y(j),Sat2_z(j),'ko');
    end
end

%Making it aesthetic:
title("Positions of ISS and Hubble Telescope in visible range")
xlabel('x')
ylabel('y')
zlabel('z')
legend("ISS","Hubble Space Telescope", "Ground Station Visibility")