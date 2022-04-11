function [dX] = ROC(t,state,const,wind,thrustVec,timeThrust)
% Purpose: To calculate the rate of change of various parameters along 
% the flight trajector of a water rocket
%
% Inputs:   t = anonymous time variable
%          state = anonymous state vector containing
%             = [x, y, z, vx, vy, vz]
%           const = vector to hold constant values
%           wind = wind vector that holds the corresponding change in vel
%           thrustFunc = function handle of thrust polynomial fit
%           initTime = time the polynomial is valid
% Outputs: dX = derivative state vector containing
%             =  [vx,vy,vz,d2x,d2y,d2z,dmdt]
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
rhoWater = 1000;
DThroat = 0.021;  

%Calculating area
areaBottle = pi*(DBottle / 2)^2;
areaNozzle = pi*(DThroat / 2)^2;

%Getting initial states
x = state(1);
y = state(2);
z = state(3);
vx = state(4);
vy = state(5);
vz = state(6);
m = state(7);

%Velocity vector and heading vector
vVec = [vx; vy; vz];
vHeading = vVec / norm(vVec);


%Calculating thrust
if(t < timeThrust(end)) %Base case, thrust is zero    
    [~, ind] = min((abs(t - timeThrust))); %Finding time that is closest to t for ode45
    if(t <= timeThrust(1)) %First Case
        thrust = thrustVec(1);        
    elseif(t < timeThrust(ind) && (ind - 1) > 0) %Interpolate with previous
        deltaTh = thrustVec(ind) - thrustVec(ind - 1);
        deltaT = timeThrust(ind) - timeThrust(ind - 1);
        slope = deltaTh / deltaT;
        thrust = thrustVec(ind - 1) + slope*(t - timeThrust(ind - 1));
    elseif(t > timeThrust(ind) && (ind + 1) < length(timeThrust)) %interpolate with next
        deltaTh = thrustVec(ind + 1) - thrustVec(ind);
        deltaT = timeThrust(ind + 1) - timeThrust(ind );
        slope = deltaTh / deltaT;
        thrust = thrustVec(ind) + slope*(t - timeThrust(ind));        
    else %No interpolation
        thrust = thrustVec(ind);
    end
else
    thrust = 0;   
end

%Calculating mass flow rate
dmdt = -1 * sqrt(rhoWater * areaNozzle * thrust);


%When the rocket is on the stand this is the heading
%It is fixed at an angle of 45 degrees, the stand is 0.5 meters long
if z < (0.25 + 0.5*cosd(45)) && t < 1
    vHeading = [cosd(startAngle); 0; sind(startAngle)];
    fGrav = [0; 0; -m * g];
    fDrag = -((1/2)*rhoAirAmb*(norm(vVec))^2*Cd*areaBottle) * vHeading;
    fThrust = thrust * vHeading;
    
    %Adding friction on the rails
    FricMag = mu * m * g * cosd(startAngle);
    fFric = -FricMag * vHeading;
    
elseif z <= 0 %Condition for rocket hitting the ground
    %All rates of change go to zero
    fGrav = [0; 0; 0];
    fDrag = [0; 0; 0];
    fFric = [0; 0; 0];
    fThrust = [0; 0; 0];
    vVec = [0;0;0];    
else
    vHeading = (vVec - wind) ./ norm((vVec - wind));
    fGrav = [0; 0; -m * g];
    fDrag = -((1/2)*rhoAirAmb*(norm(vVec))^2*Cd*areaBottle) * vHeading;
    fThrust = thrust * vHeading;
    fFric = [0;0;0];
end

%Calculating the net force by summing all forces
fnet = fGrav + fDrag + fFric + fThrust;
a = fnet ./ m; %acceleration from F=ma

%Outputting the thrust and the rate of change vector
dX = [vVec(1); vVec(2); vVec(3); a(1); a(2); a(3); dmdt];
end

