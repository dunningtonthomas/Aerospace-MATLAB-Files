close all; clc;


%%read both Sat position then seperate into X Y Z.
Sat1Position = readmatrix("Sat1Position.csv");

Sat1PositionX = Sat1Position(:,1);
Sat1PositionY = Sat1Position(:,2);
Sat1PositionZ = Sat1Position(:,3);


Sat2Position = readmatrix("Sat2Position.csv");

Sat2PositionX = Sat2Position(:,1);
Sat2PositionY = Sat2Position(:,2);
Sat2PositionZ = Sat2Position(:,3);


%Using logical expression only read Sat Visibility if 1, so if true.
Sat1Visibility = readmatrix("Sat1Visibility.csv") > 0;

Sat2Visibility = readmatrix("Sat2Visibility.csv") > 0;


%%Plotting all Sattelite Positions 

%Sat1Position plot
plot3(Sat1PositionX, Sat1PositionY, Sat1PositionZ, 'color', 'red');

hold on 

%Sat2Position plot
plot3(Sat2PositionX, Sat2PositionY, Sat2PositionZ, 'color', 'green');
hold on



%%Using scatter3 function, plotting points on graph of which is only when sat is visible


%plotting visible points of Sat1
scatter3(Sat1PositionX(Sat1Visibility), Sat1PositionY(Sat1Visibility), Sat1PositionZ(Sat1Visibility));

hold on

%plotting visibile points of sat2
scatter3(Sat2PositionX(Sat2Visibility), Sat2PositionY(Sat2Visibility), Sat2PositionZ(Sat2Visibility));

grid on



%% title, labels, and legend

title('Positions and Visibility of both ISS and Hubble Over Time'); %title
xlabel('X Position'); % x axis label
ylabel('Y Position'); % y axis label
zlabel('Z Position'); % z axis label
legend("ISS", "Hubble"); %legend for both satellites




%%Animation extra credit

%Animinated line func for both satellites

%MamimumNumPoints makes it so theres only 1 point going around, and doesnt
%repeat around graph. And Marker changes it into different shape
ISS = animatedline('MaximumNumPoints', 1, 'Marker', 'pentagram');

Hubble = animatedline('MaximumNumPoints', 1, 'Marker', 'pentagram');

%for loop for each position animation must go through
for k=1:1441

    %adds points of ISS position over time 
addpoints(ISS, Sat1PositionX(k), Sat1PositionY(k), Sat1PositionZ(k));
    %adds points of Hubble Position over time
addpoints(Hubble, Sat2PositionX(k), Sat2PositionY(k), Sat2PositionZ(k));


%drawnow allows position to update every point and draw it 
drawnow;

end
%change angle of view of graph
view(15, 35);
drawnow;




