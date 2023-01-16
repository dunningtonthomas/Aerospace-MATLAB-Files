function [Fc,Gc] = VelocityReferenceFeedback(t,var,latOrLong)
%VELOCITYREFERENCEFEEDBACK This function takes as input the time t and the
%12 by 1 state matrix in var
%It then calculates the forces and moments required to move the quadrotor
%to the desired reference position by applying a reference velocity
%INPUTS: latOrLong is a string of 'lat' or 'long' which corresponds to a
%lateral reference velocity or a longitudinal reference velocity

%Gravity and mass
g = 9.81;
m = 0.068;

%Gains determined in the previous problems
gainSpin = 0.004;
k1_lat = 0.0013;
k2_lat = 0.0023;
k3_lat = 1.0711e-4;
k1_long = 0.0016;
k2_long = 0.0029;
k3_long = -1.3914e-4;

%Getting the angular rates
dp = var(10);
dq = var(11);
dr = var(12);

%Getting the velocities
du = var(7);
dv = var(8);

%Angles
dphi = var(4);
dtheta = var(5);


if(t < 2) %Condition for applying the reference velocity
    %Finding the control forces and moments with a reference velocity
        %Calculating the reference velocity based on the time
        if(latOrLong == "lat")
            
             vRef = 0.5; %Move 0.5 m/s for 2 seconds for a displacement of 1m
             uRef = 0;
            
        elseif(latOrLong == "long")
            
             vRef = 0; %Move 0.5 m/s for 2 seconds for a displacement of 1m
             uRef = 0.5;      
             
        else
            fprintf('ERROR VelocityReferenceFeedback\n');   
        end

else %Stop velocity command after 2 seconds
    vRef = 0;
    uRef = 0;
end


%Calculating the control forces and moments
Zc = -m * g;

Lc = -k1_lat*dp - k2_lat*dphi + k3_lat*(vRef - dv);

Mc = -k1_long*dq - k2_long*dtheta + k3_long*(uRef - du);

Nc = -gainSpin * dr;
       

%Outputting the force and moment control vectors
Fc = [0; 0; Zc];
Gc = [Lc; Mc; Nc];

end

