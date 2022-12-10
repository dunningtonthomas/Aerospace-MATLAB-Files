close all; clear all; clc

Sat1PositionSeconds = readmatrix('Sat1Position.csv');
Sat2PositionSeconds = readmatrix('Sat2Position.csv');
Sat1Visibility = readmatrix('Sat1Visibility.csv');
Sat2Visibility = readmatrix('Sat2Visibility.csv');

% Extract every 60th element
Sat1Position = Sat1PositionSeconds(1:60:end, :);
Sat2Position = Sat2PositionSeconds(1:60:end, :);

%figure();
hold on;
plot3(Sat1Position(:,1), Sat1Position(:,2), Sat1Position(:,3));


plot3(Sat1Position(:,1), Sat1Position(:,2), Sat1Position(:,3));
plot3(Sat2Position(:,1), Sat2Position(:,2), Sat2Position(:,3));

% Plot points only when visible
for i = 1:1440
    if (Sat1Visibility(i) == 1)
        plot3(Sat1Position(i,1), Sat1Position(i,2), Sat1Position(i,3), 'go');
    end

    if (Sat2Visibility(i) == 1)
        plot3(Sat2Position(i,1), Sat2Position(i,2), Sat2Position(i,3), 'go');
    end
end

% Labels
legend('ISS Orbit', 'Hubble Orbit', 'Visibility Regions');

xlabel('X');
ylabel('Y');
zlabel('Z');

title('Visibility of ISS & Hubble During Oribit');

grid on;
