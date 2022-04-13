function [] = CpCalc(file)
%% Center of Pressure Calculator for Rockets and Aircraft
% 
% Created by Duncan McGough on 4/20/17
%
% Version 1.1
% Edited: 4/21/17
% Changelog:
% Added all necessary functions (freehanddraw.m and xycentroid.m) inside 
% this file for user ease. Converted to function and added capability for 
% skewed ruler placement. 
% 
% Purpose:
% This program will calculate the center of pressure for a rocket or
% aircraft. The user first outlines the rocket or aircraft body in the
% photo given to this function. Then, the program will request the user to
% draw a reference line at the base of the object. This is usually at the
% nozzle or back of the rocket, or could be the tail of the aircraft.
% Finally, it requests the user to draw on top of the unit of measurement
% inside the photo. This provides a unit of scale for the program to
% calculate from. 
%
% Inputs: 
% Photo file location or name, in quotations. Needs to have
% extension (i.e. .jpg or .JPG or .PNG or .png or something). Extension is
% case-sensitive.
%
% Outputs: 
% The location of Cp as well as a graphical representation of the
% location.
%


%% Allocation
RefAxis = [0 0]; 

%% Menu
% Test to see if aligned object
out1 = menu('Is the object in the image you are attempting to import centered on an axis, either vertically or horizontally?', 'Yes', 'No');
if out1 == 2
    error('The object must be aligned otherwise this program will fail to compute the correct location of Cp. Please retake the image or rotate the image before proceeding.')
end

% Give instructions
out2 = menu('Instructions: When you see the crosshair, you may click once to begin drawing and double click to end the drawing process. It is recommended to enlargen the window on your screen so that your accuracy is better.','Got it, let"s begin!')


%% Import image
C = imread(file);
C = flipud(C);

%% Draw outline
figure(1)
hold on
image(C)
title('Draw Around The Object')
[myobj,xs,ys] = freehanddraw(gca,'color','r','linewidth',3); % grabs line drawn around object
hold off

%% Find base reference

% Draw at base
figure(2)
hold on
image(C)
title('Draw a Reference Line At The Base Of The Object To Measure Cp From')
[myobj2,xs2,ys2] = freehanddraw(gca,'color','r','linewidth',3); % grabs line drawn around object
hold off

% find reference axis
RefBaseX = abs(xs2(end-1)-xs2(1));
RefBaseY = abs(ys2(end-1)-ys2(1));
% 1 means object is oriented vertically, 
%   0 means object is oriented horizontally
if RefBaseX > RefBaseY
    RefAxis = [1,mean(ys2)];
elseif RefBaseY > RefBaseX
    RefAxis = [0,mean(xs2)];
end


%% Find scale

% draw line
figure(3)
hold on
image(C)
title('Draw a Straight Line On Top of One Unit of Measurement')
[myobj3,xs3,ys3] = freehanddraw(gca,'color','r','linewidth',3); % grabs line drawn around object
hold off

% remove last point on line so it doesn't connect back to beginning
xs3(end) = [];
ys3(end) = [];

% Find magnitude of unit length
unit_measure = sqrt((ys3(end)-ys3(1))^2 + (xs3(end)-xs3(1))^2); 

%% Close Figures
close all

%% Calculate Centroid
[xbar,ybar,area] = xycentroid(xs,ys);
if RefAxis(1) == 1 % if rocket/aircraft is vertical
    % distance between ybar and reference axis / reference length
    Cp = (abs(mean(ys2) - ybar))/unit_measure; 
elseif RefAxis(1) == 0 % if rocket/aircraft is horizontal
    % distance between xbar and reference axis / reference length
    Cp = (abs(mean(xs2) - xbar))/unit_measure;
end

%% Display to User
fprintf('Cp is located at %.5g units from the reference axis you drew. \n', Cp)
figure
hold on
image(C)
plot(xs,ys,'LineWidth', 3, 'Color', 'r')
plot([0 size(C,2)], [ybar ybar], 'LineWidth', 3, 'Color', 'g')
plot([xbar xbar], [0 size(C,1)], 'LineWidth', 3, 'Color', 'g')
axis([0 size(C,2) 0 size(C,1)])
title('Location of Cp')

%% Drawing Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [lineobj,xs,ys] = freehanddraw(varargin)
% [LINEOBJ,XS,YS] = FREEHANDDRAW(ax_handle,line_options)
%
% Draw a smooth freehand line object on the current axis (default),
% or on the axis specified by handle in the first input argument.
% Left-click to begin drawing, right-click to terminate, or double-click
% to close contour and terminate.
% 
%
% INPUT ARGUMENTS:  First:      axis handle (optional)
%                  Additional: valid line property/value pairs
%
% OUTPUT ARGUMENTS: 1) Handle to line object
%                  2) x-data
%                  3) y-data
% (Note that output args 2 and 3 can also be extracted from the first output
% argument.)
%
% Ex: [myobj,xs,ys] = freehanddraw(gca,'color','r','linewidth',3);
%     freehanddraw('linestyle','--');
%
% Written by Brett Shoelson, PhD
% shoelson@helix.nih.gov
% 3/29/05
% Modified: 
% 4/20/17: Works with R2016b - removed 'doublebuffer' instances
% Edited by Duncan McGough
% duncan.mcgough@colorado.edu

axdef = 0;
if nargin ~= 0 & ishandle(varargin{1})
	try
		axes(varargin{1});
		axdef = 1;
	catch
		error('If the initial input argument is a handle, it must be to a valid axis.');
	end
end
	
	
%Get current figure and axis parameters
oldvals = get(gcf);
oldhold = ishold(gca);

hold on;

set(gcf,'Pointer','crosshair');

%Get the initial point
[xs,ys,zs] = ginput(1);

%Create and store line object
if axdef
	lineobj = line(xs,ys,'tag','tmpregsel',varargin{2:end});
else
	lineobj = line(xs,ys,'tag','tmpregsel',varargin{:});
end
setappdata(gcf,'lineobj',lineobj);

%Modify wbmf of current figure to update lineobject on mouse motion
set(gcf,'windowbuttonmotionfcn',@wbmfcn);
set(gcf,'windowbuttondownfcn',@wbdfcn);
%Wait for right-click or double-click
while ~strcmp(get(gcf,'SelectionType'),'alt') & ~strcmp(get(gcf,'SelectionType'),'open')
	drawnow;
end

%Extract xyz data from line object for return in output variables
%(Also retrievable from first output argument)
if nargout > 1
	xs = get(getappdata(gcf,'lineobj'),'xdata')';
end
if nargout > 2
	ys = get(getappdata(gcf,'lineobj'),'ydata')';
end

%Clear temporary variables from base workspace
evalin('caller','clear tmpx tmpy tmpz done gca lineobj');

%Reset figure parameters
set(gcf,'Pointer',oldvals.Pointer,...
	'windowbuttonmotionfcn',oldvals.WindowButtonMotionFcn,...
    'windowbuttondownfcn',oldvals.WindowButtonDownFcn);
%Reset hold value of the axis
if ~oldhold, hold off; end 


function wbmfcn(varargin)
lineobj = getappdata(gcf,'lineobj');
if strcmp(get(gcf,'selectiontype'),'normal');
    tmpx = get(lineobj,'xdata');
    tmpy = get(lineobj,'ydata');
    a=get(gca,'currentpoint');
    set(lineobj,'xdata',[tmpx,a(1,1)],'ydata',[tmpy,a(1,2)]);
    drawnow;
else
    setappdata(gcf,'lineobj',lineobj);
end

end

function wbdfcn(varargin)
lineobj = getappdata(gcf,'lineobj');
if strcmp(get(gcf,'selectiontype'),'open')
    tmpx = get(lineobj,'xdata');
    tmpy = get(lineobj,'ydata');
    a=get(gca,'currentpoint');
    set(lineobj,'xdata',[tmpx,tmpx(1)],'ydata',[tmpy,tmpy(1)]);
    setappdata(gcf,'lineobj',lineobj);
    drawnow;
end
return
end

end

%% Centroid Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x_bar, y_bar, As] = xycentroid(x,y)
%Function calculates centroid and area of a list of xy points
% Author:  Sean de Wolski 
%SCd 11/24/2010
%
%
%Input Arguments:
%   -x: vector of x coordinates (can be row or column vector)
%   -y: vector of y coordinates (can be row or column vector)
%
%Output Arguments:
%   -x_bar: x location of centroid
%   -y_bar: y location of centroid
%   -A: area of polygon
%

      %Error checking:
      assert(nargin==2,'This function expects 2 and only 2 input arguments');
      assert(all(size(x(:))==size(y(:))),'Input arguments: x & y are expected to be the same length');
      x = x(:);
      y = y(:);

      %Engine:
      A = x(1:end-1).*y(2:end)-x(2:end).*y(1:end-1);
      As = sum(A)/2;
      x_bar = (sum((x(2:end)+x(1:end-1)).*A)*1/6)/As;
      y_bar = (sum((y(2:end)+y(1:end-1)).*A)*1/6)/As;

end

end