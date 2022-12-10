%final project part 3
close all; clear; clc

%reading in the data from Sat1Position
datamatrix1 = readmatrix("Sat1Position.csv");
%sorting datamtrix1 into x y and z matrices
x1 = datamatrix1(:,1);
y1 = datamatrix1(:,2);
z1 = datamatrix1(:,3);

%reading in data from Sat2Position
datamatrix2 = readmatrix("Sat2Position.csv");
%sorting datamatrix2 into x y and z matrices
x2 = datamatrix2(:,1);
y2 = datamatrix2(:,2);
z2 = datamatrix2(:,3);

%reading in data from the visibility csv files
Visibility1 = readmatrix("Sat1Visibility.csv");
Visibility2 = readmatrix("Sat2Visibility.csv");

%declaring n as the length of datamatrix 1 aka 1441 to be used in for loops
n=length(datamatrix1);

%plotting the orbits of Hubble and the ISS
ISS = plot3(x1,y1,z1,"b-");
hold on %holding on the plot to add more to it
Hubble = plot3(x2,y2,z2,"m-");
%labeling the axises and adding a title
xlabel('X Position(km)')
ylabel('Y position(km)')
zlabel('Z Position(km)')
title('Position and Visibility of ISS and Hubble Over 1 Day')

%in a for loop plotting the visibility
for i=1:n
if Visibility1(i) == 1 %if the value is equal to 1
    sat1Vis = plot3(x1(i),y1(i),z1(i),'g*'); %that point will be plotted
    %if it is anything but one it will just continue
end
end

%plotting visibility of 2nd sattelite
for i=1:n
if Visibility2(i) == 1 %if value is equal to 1
    sat2Vis = plot3(x2(i),y2(i),z2(i),'c*'); %that point wwill be plotted
    %if the value is anything but 1 it will continue
end
end

%adding a legend
legend([ISS, Hubble, sat1Vis, sat2Vis], 'ISS', 'Hubble', 'ISS Visibility', 'Hubble Visibility', 'location', 'best');
%turning grid on
grid on
%turning off the plot
hold off