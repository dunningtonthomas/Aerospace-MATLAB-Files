close all; clear; clc;

%Reading in csv files as matrices
Sat1Position = readmatrix('Sat1Position.csv');
Sat2Position = readmatrix('Sat2Position.csv');
Sat1Visibility = readmatrix('Sat1Visibility.csv');
Sat2Visibility = readmatrix('Sat2Visibility.csv');

%Splitting position matrices into vectors to simplify plotting
x1 = Sat1Position(:,1);
y1 = Sat1Position(:,2);
z1 = Sat1Position(:,3);

x2 = Sat2Position(:,1);
y2 = Sat2Position(:,2);
z2 = Sat2Position(:,3);

%Plot Orbits
plot3(x1,y1,z1);
hold on;
plot3(x2,y2,z2);

%Plot markers on orbits where the satellites are found to be visible
for i = 1:length(Sat1Visibility)
    if Sat1Visibility(i) == 1
        plot3(x1(i),y1(i),z1(i),'mo')
    end
    
    if Sat2Visibility(i) == 1
        plot3(x2(i),y2(i),z2(i),'mo')
    end
end

%Plot attributes
grid on;
title('Orbit models for ISS and Hubble')
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');
legend('ISS (Satellite 1)','Hubble (Satellite 2)','Visibility from GS');

%Save as figure
savefig('part3.fig');

