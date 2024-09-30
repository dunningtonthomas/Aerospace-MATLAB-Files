function DrawAircraft(time, aircraft_state, pts)
%
% aircraft_state_array is 12 x 1
%
    % process inputs to function
    pn       = aircraft_state(1);       % inertial North position     
    pe       = aircraft_state(2);       % inertial East position
    pd       = aircraft_state(3);       % inertial Down position
      
    phi      = aircraft_state(4);       % roll angle         
    theta    = aircraft_state(5);       % pitch angle     
    psi      = aircraft_state(6);       % yaw angle     

    u        = aircraft_state(7);       % body frame velocities
    v        = aircraft_state(8);       
    w        = aircraft_state(9); 
    
    p        = aircraft_state(10);      % roll rate
    q        = aircraft_state(11);      % pitch rate     
    r        = aircraft_state(12);      % yaw rate    
    t        = time;      % time

    % define persistent variables 
    persistent aircraft_handle1;
    persistent aircraft_handle2;
    persistent aircraft_handle3;
    persistent aircraft_handle4;
    %persistent pos_handle;
    persistent axis_vec;

    
    
    % first time function is called, initialize plot and persistent vars
    %if t<=0.01
    if isempty(aircraft_handle1)
        figure(20), clf;

        %pos_handle = plot3(pe, pn, -pd,'ko','MarkerFaceColor','g', 'MarkerSize',4);hold on;
        aircraft_handle1 = drawAircraftBody(pts.fuse, pn,pe,pd,phi,theta,psi, [], 'normal');
        aircraft_handle2 = drawAircraftBody(pts.wing, pn,pe,pd,phi,theta,psi, [], 'normal');
        aircraft_handle3 = drawAircraftBody(pts.tailwing, pn,pe,pd,phi,theta,psi, [], 'normal');
        aircraft_handle4 = drawAircraftBody(pts.tail, pn,pe,pd,phi,theta,psi, [], 'normal');
        
        title('Aircraft')
        xlabel('East')
        ylabel('North')
        zlabel('-Down')
        view(32,47)  % set the vieew angle for figure
        %axis_vec = [-100, 400,-100, 400, 0, 300];
        axis_vec = [-200, 200,-200, 200, -100, 100];
        axis([pe pe pn pn -pd -pd] + axis_vec);
        grid on;
        hold on
        
    % at every other time step, redraw base and rod
    else   
        %if (mod(t,2)==0)
        %    plot3(pe,pn,-pd,'ko','MarkerFaceColor','b', 'MarkerSize',4);
        %end
        drawAircraftBody(pts.fuse, pn,pe,pd,phi,theta,psi, aircraft_handle1);
        drawAircraftBody(pts.wing, pn,pe,pd,phi,theta,psi, aircraft_handle2);
        drawAircraftBody(pts.tailwing, pn,pe,pd,phi,theta,psi, aircraft_handle3);
        drawAircraftBody(pts.tail, pn,pe,pd,phi,theta,psi,aircraft_handle4);
        
        axis([pe pe pn pn -pd -pd] + axis_vec);

%         [flag, axis_new] = in_view(axis_vec,pn,pe,pd);
%         if (flag)
%             figure(20);
%             axis_vec = axis_new;
%             axis(axis_vec);
%         end

    end
end

  
%=======================================================================
% drawSpacecraftBody
% return handle if 7th argument is empty, otherwise use 7th arg as handle
%=======================================================================
%
function handle = drawAircraftBody(NED,pn,pe,pd,phi,theta,psi, handle, mode)
    SCALE = 10;


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
  if isempty(handle),
    handle = animatedline(XYZ(1,:),XYZ(2,:),XYZ(3,:)); % added EWF 5/6/15
    %handle = plot3(XYZ(1,:),XYZ(2,:),XYZ(3,:),'EraseMode', mode);
    hold on;
  else
    clearpoints(handle)
    addpoints(handle,XYZ(1,:),XYZ(2,:),XYZ(3,:));
    %set(handle,'XData',XYZ(1,:),'YData',XYZ(2,:),'ZData',XYZ(3,:));
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
% determines if aircraft is in current set of axis, and if not determines
% new axis
function [flag, axis_new] = in_view(axis_vec,pn,pe,pd)
    xp = pe;
    yp = pn;
    zp = -pd;
    
    flag = 0;
    axis_new = axis_vec;
    
    if (xp<axis_vec(1))
        flag = 1;
        dx = axis_vec(2) - axis_vec(1);
        axis_new(1:2) = axis_vec(1:2)-[dx dx];
    elseif(xp>axis_vec(2))
        flag = 2;
        dx = axis_vec(2) - axis_vec(1);
        axis_new(1:2) = axis_vec(1:2)+[dx dx];
    end

    if (yp<axis_vec(3))
        flag = 3;
        dy = axis_vec(4) - axis_vec(3);
        axis_new(3:4) = axis_vec(3:4)-[dy dy];
    elseif(yp>axis_vec(4))
        flag = 4;
        dy = axis_vec(4) - axis_vec(3);
        axis_new(3:4) = axis_vec(3:4)+[dy dy];
    end
        
    if (zp<axis_vec(5))
        flag = 5;
        dz = axis_vec(6) - axis_vec(5);
        axis_new(5:6) = axis_vec(5:6)-[dz dz];
    elseif(zp>axis_vec(6))
        flag = 6;
        dz = axis_vec(6) - axis_vec(5);
        axis_new(5:6) = axis_vec(5:6)+[dz dz];
    end
  
end

% end
  