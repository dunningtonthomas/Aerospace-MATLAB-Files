function [dX] = ROC(t,state,const,wind)
% Purpose: To calculate the rate of change of various parameters along 
% the flight trajector of a water rocket
%
% Inputs:   t = anonymous time variable
%          state = anonymous state vector containing
%             = [x, y, z, vx, vy, vz]
%           const = vector to hold constant values
%           wind = wind vector that holds the corresponding change in vel
% Outputs: dX = derivative state vector containing
%             =  [vx,vy,vz,d2x,d2y,d2z]
%      

%Constants from constant vector
g = const(1);
m0 = const(2);
mf = const(3);
Cd = const(4);
DBottle = const(5);
rhoAirAmb = const(6);
startAngle = const(7);
mu = const(8);

%Calculating area
areaBottle = pi*(DBottle / 2)^2;

%Getting initial states
x = state(1);
y = state(2);
z = state(3);
vx = state(4);
vy = state(5);
vz = state(6);

%Velocity vector and heading vector
vVec = [vx; vy; vz];
vHeading = vVec / norm(vVec);


%When the rocket is on the stand this is the heading
%It is fixed at an angle of 45 degrees, the stand is 0.5 meters long
if z < (0.25 + 0.5*cosd(45)) && t < 1
    vHeading = [cosd(startAngle); 0; sind(startAngle)];
    fGrav = [0; 0; -mf * g];
    fDrag = -((1/2)*rhoAirAmb*(norm(vVec))^2*Cd*areaBottle) * vHeading;
    
    %Adding friction on the rails
    FricMag = mu * mf * g * cosd(startAngle);
    fFric = -1 * abs(FricMag * vHeading);
    
elseif z <= 0 %Condition for rocket hitting the ground
    %All rates of change go to zero
    fGrav = [0; 0; 0];
    fDrag = [0; 0; 0];
    fFric = [0; 0; 0];
    vVec(1) = 0;
    vVec(2) = 0;
    vVec(3) = 0;
    
else
    vHeading = (vVec - wind) ./ norm((vVec - wind));
    fGrav = [0; 0; -mf * g];
    fDrag = -((1/2)*rhoAirAmb*(norm(vVec))^2*Cd*areaBottle) * vHeading;
    fFric = [0;0;0];
end

%Calculating the net force by summing all forces
fnet = fGrav + fDrag + fFric;
a = fnet ./ mf; %acceleration from F=ma

%Outputting the thrust and the rate of change vector
dX = [vVec(1); vVec(2); vVec(3); a(1); a(2); a(3)];
end

