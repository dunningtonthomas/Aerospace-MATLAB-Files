close all, clear all, clc

S1Pos = readmatrix("Sat1Position.csv");             %loading in csv files
S2Pos = readmatrix("Sat2Position.csv");
S1Viz = readmatrix("Sat1Visibility.csv");
S2Viz = readmatrix("Sat2Visibility.csv");

temp1 = zeros(1440,3);                              %creating temp matrices
temp2 = zeros(1440,3);

for i = 1:1440                                      %sorting visible parts into temp matrices
    if S1Viz(i) == 1
        temp1(i,1) = S1Pos(i,1);
        temp1(i,2) = S1Pos(i,2);
        temp1(i,3) = S1Pos(i,3);
    end
end

for i = 1:1440
    if S2Viz(i) == 1
        temp2(i,1) = S2Pos(i,1);
        temp2(i,2) = S2Pos(i,2);
        temp2(i,3) = S2Pos(i,3);
    end
end

temp1(temp1==0) = NaN;                              %removing zeros in temp matrices
temp2(temp2==0) = NaN;

plot3(temp1(:,1), temp1(:,2), temp1(:,3), 'r*')     %plotting everything
hold on;
plot3(temp2(:,1), temp2(:,2), temp2(:,3), 'c*') 
hold on;
plot3(S1Pos(:,1), S1Pos(:,2), S1Pos(:,3), 'g', LineWidth=1.5) 
hold on;
plot3(S2Pos(:,1), S2Pos(:,2), S2Pos(:,3), LineWidth=1.5)
ylabel('Y (km)')
xlabel('X (km)')
zlabel('Z (km)')
legend('Visibility of ISS', 'Visibility of Hubble Space Telescope', 'Orbit of ISS', 'Orbit of Hubble Space Telescope')
title('Visibilty periods of ISS and Hubble Space Telescope')
saveas(gcf,'part3',"fig")