close all; clear all; 

%create filename variable
filename='animation.gif';


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
plot3(sat1posx,sat1posy,sat1posz,sat2posx,sat2posy,sat2posz);
hold on
p1=plot3(sat1visx(1),sat1visy(1),sat1visz(1),'*');
p2=plot3(sat2visx(1),sat2visy(1),sat2visz(1),'*');

%graph specificiations 
xlabel('X Position (km)');
ylabel('Y Position(km)');
zlabel('Z Position (km)');
legend('International Space Station (ISS) Trajectory','Hubble Space Telescope Trajectory', 'ISS Visibility Range','Hubble Visibility Range');
title('Spacecraft Orbit Trajectories and Visibility Ranges');

for k=1:1441
    %update line
    p1.XData=sat1visx(1:k);
    p1.YData=sat1visy(1:k);
    p1.ZData=sat1visz(1:k);

    p2.XData=sat2visx(1:k);
    p2.YData=sat2visy(1:k);
    p2.ZData=sat2visz(1:k);

    pause(0.1)

    % Saving the figure
    frame = getframe(gcf);
    ima = frame2im(frame);
    [imin,cm] = rgb2ind(ima,256);
    if k == 1
        imwrite(imin,cm,filename,'gif', 'Loopcount',inf,...
        'DelayTime',0.2);
    else
        imwrite(imin,cm,filename,'gif','WriteMode','append',...
        'DelayTime',0.2);
    end
end






