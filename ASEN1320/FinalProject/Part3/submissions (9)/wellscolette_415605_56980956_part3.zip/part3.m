%clearing command window
close all;clear all;clc

%loading in the Sat1Position, Sat2Position, Sat1Visibility, and
%Sat2Visibility csv files
Sat1V = load("Sat1Visibility.csv");
Sat2V = load("Sat2Visibility.csv");
Sat1P = load("Sat1Position.csv");
Sat2P = load("Sat2Position.csv");

%creating the variables for each x y and z of the sat 1 and sat 2 positions
S1_Px = Sat1P(:,1);
S1_Py = Sat1P(:,2);
S1_Pz = Sat1P(:,3);

S2_Px = Sat2P(:,1);
S2_Py = Sat2P(:,2);
S2_Pz = Sat2P(:,3);

%naming the figure
figure('Name', 'Part3.Fig');

%plotting the sat1 position orbit 
Sat1_P = plot3(S1_Px, S1_Py, S1_Pz,  'r-', 'linewidth', 2);

%hold on allows the 2 plots to be on the same graph/figure
%grid on creates a grid
    hold on;
    grid on;
%plotting the sat2 position orbit
Sat2_P = plot3(S2_Px, S2_Py, S2_Pz,  'b-', 'linewidth', 2);

%creating a for loop to iterate over the the number of positions 1441
for i = 1:1441

    %if sat1visibility = 1, then plot the position points corresponding
    %with the ith value
    if Sat1V(i) ==1
       Sat1_V = plot3(S1_Px(i), S1_Py(i), S1_Pz(i),"r*",'markersize', 8);
    end

    % if sat2Visibility = 1, then plot the position points corresponding
    % with the ith value
    if Sat2V(i) ==1
       Sat2_V = plot3(S2_Px(i), S2_Py(i), S2_Pz(i), 'b*', 'markersize', 8);
    end

    %creating the title, x, y, and z labels
    title("Position of ISS and Hubble and their Visibility/Communication Points");
    xlabel("X Axis");
    ylabel("Y Axis");
    zlabel("Z Axis");

end

%making a legend for the graph
    legend([Sat1_P, Sat2_P, Sat1_V, Sat2_V], "ISS Orbit","Hubble Orbit","Visiblity points of ISS", "Visibility points of Hubble");
