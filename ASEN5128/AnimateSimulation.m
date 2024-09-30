% function AnimateSimulation(tout, xarray)
%
% Created by: Eric W. Frew
% Date last modified: March 7, 2013
%
% This code was created for ASEN 3128. It is based off code that was
% originally created by Randy Beard and Tim McLain. The original code is
% part of the Design Code provided at http://uavbook.byu.edu/.
%
% The animation code is designed to take as input the time vector and state
% array output from a simulation using ODE45. Currently tout is not used
% but is included for future use.
%   
% The function automatically sets the X- and Y- axes to be equal (square)
% and to include the complete simulation path. The range of the Z axis must
% be at least 20% of the range of the X- and Y-axes. 
%
% The size of the aircraft icon is scaled according to the overall range of
% the simulation path. The aircraft is defined at the bottom of the file.
%
% The 3-D aircraft path is drawn in green. The projections onto the X-Y
% plane and the Y-Z plane are drawn in black at the bottom and end of the
% simluation, respectively, Dashed black lines connect the aircraft
% position to the projections in these planes.

function AnimateSimulation(tout, xarray)

[m,n]=size(xarray);
maxP = max([xarray(:,1:2), -xarray(:,3)]);
minP = min([xarray(:,1:2), -xarray(:,3)]);
rangeP = maxP-minP;
centP = (maxP+minP)/2;
maxDim = max(rangeP');
scale_plot = maxDim/50;
axisMin = centP - 1.05*maxDim*[1 1 1];
axisMax = centP + 1.05*maxDim*[1 1 1];

delZ = 1.05*max(.2*maxDim, rangeP(3));
axisMin(3) = centP(3) - delZ;
axisMax(3) = centP(3) + delZ;

%pts = DefineAircraftPts();
DefineTTwistor;

% initialize plots with initial state
figure(21);clf;
pos=xarray(1,1:3)';
att=xarray(1,4:6)';
plot3(xarray(:,2), xarray(:,1), -xarray(:,3), 'b--'); hold on;
plot3(xarray(:,2), xarray(:,1), axisMin(3)*ones(size(xarray(:,1))), 'g--');
plot3(xarray(:,2), axisMax(1)*ones(size(xarray(:,1))), -xarray(:,3), 'g--');
aircraft_handle1 = drawAircraftBody(pts.fuse, pos, att, scale_plot, [], 'normal');
aircraft_handle2 = drawAircraftBody(pts.wing, pos, att, scale_plot, [], 'normal');
aircraft_handle3 = drawAircraftBody(pts.tailwing, pos, att, scale_plot, [], 'normal');
aircraft_handle4 = drawAircraftBody(pts.tail, pos, att, scale_plot, [], 'normal');

line_handle1 = drawLine(pos, [pos(1:2); -axisMin(3)], [], 'normal');
line_handle2 = drawLine(pos, [axisMax(1); pos(2:3)], [], 'normal');

title('Aircraft')
xlabel('East')
ylabel('North')
zlabel('-Down')
view(32,47)  % set the vieew angle for figure
%axis([-10000,200000,-10000,200000,0,50000]);
axis([axisMin(2) axisMax(2) axisMin(1) axisMax(1) axisMin(3) axisMax(3)]);
grid on;
hold on


for i=2:m
    pos=xarray(i,1:3)';
    att=xarray(i,4:6)';
    drawAircraftBody(pts.fuse, pos, att, scale_plot, aircraft_handle1);
    drawAircraftBody(pts.wing, pos, att, scale_plot, aircraft_handle2);
    drawAircraftBody(pts.tailwing, pos, att, scale_plot, aircraft_handle3);
    drawAircraftBody(pts.tail, pos, att, scale_plot, aircraft_handle4);
    drawLine(pos, [pos(1:2); -axisMin(3)], line_handle1);
    drawLine(pos, [axisMax(1); pos(2:3)], line_handle2);
end % for i=...    


end %AnimateSimulation

  
%=======================================================================
% drawAircraftBody
% return handle if 7th argument is empty, otherwise use 7th arg as handle
%=======================================================================
%
function handle = drawAircraftBody(NED, position, euler_angles, scale_plot, handle, mode)
    SCALE = scale_plot;

    pn = position(1,1);
    pe = position(2,1);
    pd = position(3,1);

    phi = euler_angles(1,1);
    theta = euler_angles(2,1);
    psi = euler_angles(3,1);


  NED = SCALE*rotate(NED,phi,theta,psi); % rotate spacecraft by phi, theta, psi
  NED = translate(NED,pn,pe,pd); % translate spacecraft
  % transform vertices from NED to XYZ (for matlab rendering)
   R = [...
       0, 1, 0;...
       1, 0, 0;...
       0, 0, -1;...
       ];
   XYZ = R*NED;
  
  % plot spacecraft
  if isempty(handle)
    %handle = animatedline(XYZ(1,:),XYZ(2,:),XYZ(3,:));
    handle = plot3(XYZ(1,:),XYZ(2,:),XYZ(3,:),'k');
    hold on;
  else
    set(handle,'XData',XYZ(1,:),'YData',XYZ(2,:),'ZData',XYZ(3,:));
    %clearpoints(handle);
    %addpoints(handle,XYZ(1,:),XYZ(2,:),XYZ(3,:));
    drawnow
  end
end

function handle = drawLine(pos1, pos2, handle, mode)
  
  R = [...
       0, 1, 0;...
       1, 0, 0;...
       0, 0, -1;...
       ];
   XYZ1 = R*pos1;
   XYZ2 = R*pos2;
   XYZ = [XYZ1 XYZ2];
  
  % plot spacecraft
  if isempty(handle)
    %handle = animatedline(XYZ(1,:),XYZ(2,:),XYZ(3,:),'ko-.');
    handle = plot3(XYZ(1,:),XYZ(2,:),XYZ(3,:),'ko-.');
    hold on;
  else
    set(handle,'XData',XYZ(1,:),'YData',XYZ(2,:),'ZData',XYZ(3,:));
    %clearpoints(handle);
    %addpoints(handle,XYZ(1,:),XYZ(2,:),XYZ(3,:));
    drawnow
  end
end
 

%%%%%%%%%%%%%%%%%%%%%%%
function XYZ=rotate(XYZ,phi,theta,psi);
  % define rotation matrix
  R_roll = [...
          1, 0, 0;...
          0, cos(phi), -sin(phi);...
          0, sin(phi), cos(phi)];
  R_pitch = [...
          cos(theta), 0, sin(theta);...
          0, 1, 0;...
          -sin(theta), 0, cos(theta)];
  R_yaw = [...
          cos(psi), -sin(psi), 0;...
          sin(psi), cos(psi), 0;...
          0, 0, 1];
  R = R_yaw*R_pitch*R_roll;

  % rotate vertices
  XYZ = R*XYZ;
  
end
% end rotateVert

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% translate vertices by pn, pe, pd
function XYZ = translate(XYZ,pn,pe,pd)

  XYZ = XYZ + repmat([pn;pe;pd],1,size(XYZ,2));
  
end

% end translateXYZ

  



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% translate vertices by pn, pe, pd

function pts = DefineAircraftPts();
% DefineDefaultAircraft.m
% Defines vertices needed for animation

% Geometry
fuse_h = 1;
fuse_w = 1;
fuse_l1 = 3;
fuse_l2 = 1;
fuse_l3 = 10;

wing_l = 1.5;
wing_w = 9;

tailwing_l = 1;
tailwing_w = 4;

tail_h = 3;



% Define the vertices (physical location of vertices
  V = [...
	 fuse_l1    0    0;... % point 1
     fuse_l2   fuse_w/2    -fuse_h/2;... % point 2
     fuse_l2   -fuse_w/2    -fuse_h/2;... % point 3
     fuse_l2   -fuse_w/2    fuse_h/2;... % point 4
	 fuse_l2   fuse_w/2    fuse_h/2;... % point 5
     -fuse_l3   0   0;... % point 6
     
     0   wing_w/2   0;... % point 7
     -wing_l   wing_w/2   0;... % point 8
	 -wing_l   -wing_w/2   0;... % point 9
     0   -wing_w/2   0;... % point 10
     
    -fuse_l3+tailwing_l  tailwing_w/2  0;... % point 11
    -fuse_l3  tailwing_w/2  0;... % point 12
    -fuse_l3  -tailwing_w/2  0;... % point 13
    -fuse_l3+tailwing_l  -tailwing_w/2  0;... % point 14
    
    -fuse_l3+tailwing_l 0  0;... % point 15
    -fuse_l3  0  -tail_h;... % point 16
  ];

pts.fuse = [...
    V(1,:);...
    V(2,:);...
    V(6,:);...
    V(3,:);...
    V(1,:);...
    V(5,:);...
    V(6,:);...
    V(5,:);...
    V(1,:)]';

pts.wing = [...
    V(7,:);...
    V(8,:);...
    V(9,:);...
    V(10,:);...
    V(7,:)]';

pts.tailwing = [...
    V(11,:);...
    V(12,:);...
    V(13,:);...
    V(14,:);...
    V(11,:)]';

pts.tail = [...
    V(6,:);...
    V(15,:);...
    V(16,:);...
    V(6,:)]';

end % DefineAircraftPts

