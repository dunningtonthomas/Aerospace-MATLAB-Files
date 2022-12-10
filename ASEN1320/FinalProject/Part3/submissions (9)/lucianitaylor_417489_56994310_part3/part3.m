close all; clear; clc;

Sat1_Position = readmatrix("Sat1Position.csv"); % reads in my csv file for sat 1
Sat2_Position = readmatrix("Sat2Position.csv"); % reads in my csv file for sat 2

Sat1_Visibility = readmatrix("Sat1Visibility.csv"); % reads in my csv file for sat 1 visibility
Sat2_Visibility = readmatrix("Sat2Visibility.csv"); % reads in my csv file for sat 2 visibility

x1 = Sat1_Position(:,1); % my x is first coloumn 
y1 = Sat1_Position(:,2); % my y is second coloumn
z1 = Sat1_Position(:,3); % my z is third coloumn

x2 = Sat2_Position(:,1); % my x is fist coloumn
y2 = Sat2_Position(:,2); % my y is second coloumn
z2 = Sat2_Position(:,3); % my z is third coloumn

visibility_1 = Sat1_Visibility(:,1); % my visibility for sat 1 is first coloumn
visibility_2 = Sat2_Visibility(:,1); % my visibility for sat 2 is second coloumn

plot3(x1,y1,z1,'g'); % plots satellite 1 position green color CHRISTMAS
hold on; % holds it on

plot3(x2,y2,z2,'r'); % plots satellite 2 position red color CHRISTMAS
hold on; % holds it on there

length = length(Sat1_Position); % length of sat 1 positon 

for i = 1:length % for loop iterating from 1 to length

    if visibility_1(i) == 1 % if the number equals 1, plot a star :)
        plot3(x1(i),y1(i),z1(i),"khexagram");
    end

    if visibility_2(i) == 1 % if the number equals 1, plot a star :)
        plot3(x2(i),y2(i),z2(i),"khexagram");
    end
end

xlabel('X AXIS'); % XLABEL
ylabel('Y AXIS'); % YLABEL
zlabel('Z AXIS'); % ZLABEL
title('Satellites and Visbility'); % TITLE
legend('ISS Satellite','Hubble Satellite','ISS Visibility','Hubble Visibility','Satellite movement') %LEGEND;
savefig('part3.fig'); % SAVES THE FIG

Animation = animatedline("MaximumNumPoints",1,"Marker","o"); % Animation extra credit

for i=1:length % for loop going 1 to length

    addpoints(Animation,x1(i),y1(i),z1(i)); % add points function that uses animation and goes around sat 1 position
    drawnow;

    addpoints(Animation,x2(i),y2(i),z2(i)); 
    drawnow;

end
savefig('animation.fig');