close all;clear; clc; %clear terminal and variables

%Declare constant variables
R = 287;
y = 1.4;

%Declare Temp and VehicleSpeed vectors
Temp = [-56, 15, -24, -56, 17, -56];
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];

%Convert temperature vector to Kelvin
TempK = Temp + 273.15;

%Calculate Speed of Sound / Mach Number of each individual plane based on
%data from previous two vectors
SoundSpeed = sqrt(y*R.*TempK);
MachNumber = VehicleSpeed ./ SoundSpeed;

Regimes = ["Incompressible", "Subsonic", "Transonic", "Sonic", "Supersonic", "Hypersonic"];

%For loop checks each condition using elseif chain. 0.001 allowance around
%Mach 1 is included in this result.
for i = 1:length(VehicleSpeed)

if MachNumber(i) < 0.3
    fprintf("Vehicle %1g has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regimes(1));
elseif MachNumber(i) < 0.8
    fprintf("Vehicle %1g has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regimes(2));
elseif MachNumber(i) < 0.999
    fprintf("Vehicle %1g has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regimes(3));
elseif MachNumber(i) < 1.001
    fprintf("Vehicle %1g has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regimes(4));
elseif MachNumber(i) < 1.2
    fprintf("Vehicle %1g has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regimes(3));
elseif MachNumber(i) < 5
    fprintf("Vehicle %1g has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regimes(5));
else
    fprintf("Vehicle %1g has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regimes(6));
end

end