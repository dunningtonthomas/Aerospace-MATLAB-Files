close all; clear all; 

%load files 
sat1pos=load('Sat1Position.csv');
sat2pos=load('Sat2Position.csv');
sat1vis=load('Sat1Visibility.csv');
sat2vis=load('Sat2Visibility.csv');

%create x y and z coordinate vectors
sat1posx=sat1pos(:,1);
sat1posy=sat1pos(:,2);
sat1posz=sat1pos(:,3);

sat2posx=sat2pos(:,1);
sat2posy=sat2pos(:,2);
sat2posz=sat2pos(:,3);

%create logical vectors
logVec1=sat1vis==1;
logVec2=sat2vis==1;

%use logical vector to index
sat1visx=sat1posx(logVec1);
sat1visy=sat1posy(logVec1);
sat1visz=sat1posz(logVec1);

sat2visx=sat2posx(logVec2);
sat2visy=sat2posy(logVec2);
sat2visz=sat2posz(logVec2);

%plot
plot3(sat1posx,sat1posy,sat1posz,sat2posx,sat2posy,sat2posz, sat1visx,sat1visy,sat1visz,'*',sat2visx,sat2visy,sat2visz,'*');

%graph specificiations 
xlabel('X Position (km)');
ylabel('Y Position(km)');
zlabel('Z Position (km)');
legend('International Space Station (ISS) Trajectory','Hubble Space Telescope Trajectory', 'ISS Visibility Range','Hubble Visibility Range');
title('Spacecraft Orbit Trajectories and Visibility Ranges');













