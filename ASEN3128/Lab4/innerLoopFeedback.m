function [Fc,Gc] = innerLoopFeedback(var)
%INNERLOOPFEEDBACK This function takes in the 12by1 state matrix within var
%and calculates the forces and moments 

%Values for gravity and the mass
g = 9.81;
m = 0.068;

%Harcodign the gains found in problem1, the spin gain is from Lab 3
gainSpin = 0.004;
k1_lat = 0.0013;
k2_lat = 0.0023;
k1_long = 0.0016;
k2_long = 0.0029;

%Getting the angular rates
dp = var(10);
dq = var(11);
dr = var(12);

%Angles
dphi = var(4);
dtheta = var(5);


%Finding the control forces and moments
Zc = -m * g;

Lc = -k1_lat*dp - k2_lat*dphi;

Mc = -k1_long*dq - k2_long*dtheta;

Nc = -gainSpin * dr;


%Outputting the force and moment control vectors
Fc = [0; 0; Zc];
Gc = [Lc; Mc; Nc];

end

