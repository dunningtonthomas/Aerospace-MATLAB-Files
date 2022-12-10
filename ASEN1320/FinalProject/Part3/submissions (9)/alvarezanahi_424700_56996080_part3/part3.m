%housekeeping :)
close all; clear all; clc


%Calling in the position files
filenameA = 'Sat1Position.csv'; 
Sat1P = readmatrix(filenameA);
                                 
filenameB = 'Sat2Position.csv';
Sat2P  = readmatrix(filenameB);

%Calling in the Visibility files
filenameC = 'Sat1Visibility.csv';
Sat1V = readmatrix(filenameC);
                                 
filenameD = 'Sat2Visibility.csv';
Sat2V = readmatrix(filenameD);

%Assigning Variables to Sat 1 Position Columns
Sat1PX = Sat1P(:,1); 
Sat1PY = Sat1P(:,2);
Sat1PZ = Sat1P(:,3);

%Assigning Variables to Sat 2 Position Columns
Sat2PX = Sat2P(:,1);
Sat2PY = Sat2P(:,2);
Sat2PZ = Sat2P(:,3);

%Plotting Position Columns for both Sat1Position and Sat2Position
plot3(Sat1P(:,1), Sat1P(:,2), Sat1P(:,3)), 'r-';
hold on;
plot3(Sat2P(:,1), Sat2P(:,2), Sat2P(:,3)), 'b-';

%For loop in order to see Visibility Range
for i = 1:1441
    if Sat1V(i) == 1
        plot3(Sat1PX(i), Sat1PY(i), Sat1PZ(i), 'c*');
    grid on;
    end

    if Sat2V(i) == 1
        plot3(Sat2PX(i), Sat2PY(i), Sat2PZ(i), 'm*');
    grid on;
    end
end
hold off;
%plotting Part 3

title('Orbit of ISS and Hubble Satellites With Visibility');
xlabel('X Positon With Visibility Range');
ylabel('Y Position With Visibility Range');
%zlabel('Z Position With Visibility Range')
legend('ISS Satellite','Hubble Satellite', 'ISS Satellite Visibility', 'Hubble Satellite Visibility');
hold off;


an = animatedline('MaximumNumPoints',25,'Marker','>');
an2 = animatedline('MaximumNumPoints',20,"Marker",'>');

x = Sat1PX;
y = Sat1PY;
z = Sat1PZ;

a = Sat2PX;
b = Sat2PY;
c = Sat2PZ;

 hold on;
for k = 1:1441
    addpoints(an,x(k),y(k),z(k));
    addpoints(an2,a(k),b(k),c(k));
    drawnow;
end

