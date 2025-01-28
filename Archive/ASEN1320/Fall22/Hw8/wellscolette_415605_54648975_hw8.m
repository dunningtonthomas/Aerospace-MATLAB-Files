%clearing out command window
clear; close all; clc;

%declaring variables and vectors 
Temp = [-56, 15, -24, -56, 17, -56];
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];
T = Temp + 273.15;
y = 1.4;
R = 287;
SoundSpeed = sqrt(y*R*T);
MachNumber = VehicleSpeed ./ SoundSpeed;
Regimes = ["Incompressible" "Subsonic" "Sonic" "Transonic" "Supersonic" "Hypersonic"];

%creating a for loop to run each of the MachNumbers to see what regime
%they are in
for i = 1: length(MachNumber)

%if MachNumber is less than 0.3, then the regime is incompressible
if (MachNumber(i) < 0.3)
    RegimineVar = Regimes(1);

% if MachNumber is greater than or equal to 0.3 and less than 0.8, then the
% regime is subsonic
elseif((0.3 <= MachNumber(i)) && (MachNumber(i)) < 0.8 )
    RegimineVar = Regimes(2);

%if Machnumber is greater than or equal to 0.8 and is less than 1.2, then
%regime is sonic
elseif( (0.8 <= MachNumber(i)) && (MachNumber(i) < 1.2))
    RegimineVar = Regimes(3);

%if MachNumber is equal to 1, then the regime is transonic
elseif(MachNumber(i) == 1)
    RegimineVar = Regimes(4);

%if MachNumber is less than or equal to 1.2 and less than 5, then the
%regime is supersonic
elseif(1.2 <= MachNumber(i)) && (MachNumber(i) <5)
    RegimineVar = Regimes(5);

%if MachNumber is less than 5, then the regimine is hypersonic
elseif(MachNumber(i) > 5)
    RegimineVar = Regimes(6);
end


%printing out the vehicle, the mach number, and the regime. 
fprintf("Vehicle %i has a Mach= %-.3g (%s) \n", i, MachNumber(i), RegimineVar);

%ending for loop
end