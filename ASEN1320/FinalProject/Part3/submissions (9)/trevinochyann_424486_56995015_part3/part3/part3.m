%%clean up
clear; close all; clc;

%%calls in all files
load("GSPosition.csv");
load("Sat1Position.csv");
load("Sat2Position.csv");
load("Sat1Visibility.csv");
load("Sat2Visibility.csv");

%%sets each row from respective positions to x, y and z (number after :
%%says what column to call from
x = Sat1Position(:,1);
y = Sat1Position(:,2);
z = Sat1Position(:,3);
x2 = Sat2Position(:,1);
y2 = Sat2Position(:,2);
z2 = Sat2Position(:,3);
x3 = GSPosition(:,1);
y3 = GSPosition(:,2);
z3 = GSPosition(:,3);
x4 = Sat1Visibility(:,1) == 1;
x5 = Sat2Visibility(:,1) == 1;

%%plot the ISS orbit
p1 = plot3(x,y,z,'r', 'DisplayName', 'ISS Orbit');
hold on %%allows us to graph both orbits
grid on

%%assignes where the ISS position equals 1 to visibility 
xVis = x(x4);
yVis = y(x4);
zVis = z(x4);

%%plots points where the ISS position equals 1/plots the visibility
p4 = plot3(xVis,yVis,zVis, '.k', 'DisplayName', 'ISS Visibility');

%%plot the hubble orbit
p2 = plot3(x2,y2,z2, 'DisplayName', 'Hubble Orbit');

%%assignes where the Hubble position equals 1 to visibility 
x2Vis = x2(x5);
y2Vis = y2(x5);
z2Vis = z2(x5);

%%plots points where the Hubble position equals 1/plots the visibility
p5 = plot3(x2Vis,y2Vis,z2Vis, '.m', 'DisplayName', 'ISS Visibility');

%%plots the ground station
p3 = plot3(x3,y3,z3, 'DisplayName', 'Ground Station Position');

%%creates a legend for each plot the name is listed in the original plots
legend([p1,p2,p3,p4,p5]);
grid on

%%labels eavh axis
xlabel('x-position');
ylabel('y-position');
zlabel('z-position');

%%titles the graph
title('Plot of ISS and Hubble Orbits and When they are Visbile');

%%creates an animations for the plots
h = length(x);

for k=2:h
    set(p1, 'xdata', x(1:k), 'ydata', y(1:k), 'zdata', z(1:k));
    set(p2, 'xdata', x2(1:k), 'ydata', y2(1:k), 'zdata', z2(1:k));
    pause(0.001);
    %%set(p3, 'xdata', x3(1:k), 'ydata', y3(1:k), 'zdata', z3(1:k)); Didn't
    %%add this because the animation for the GS was super slow compared to
    %%the other two
end 

hold off

