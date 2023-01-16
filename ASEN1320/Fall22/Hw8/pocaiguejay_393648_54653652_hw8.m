% Clean Up
clear; close all; clc;

% Variable Declaration
R = 287;                                     % J/(kg*K); Specific Gas Const
y = 1.4;                                     % Specific Heat Ratio of Air

%  Vehicle Temperature in Celsius
Temp = [-56 15 -24 -56 17 -56];

% Vehicle Velocity in m/s
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];

% Calculate Speed of Sound
T = Temp + 273.15;                           % Converting Temp to Kelvin
SoundSpeed = sqrt(y*R*T);

% Calculate Mach Number
MachNumber = VehicleSpeed./SoundSpeed;

% Initialize a string array storing the flow regime of aircraft
Regimes = ["Incompressible", "Subsonic", "Transonic", "Sonic", "Supersonic","Hypersonic"];

% Iterate Each Vehicle Mach value, and print corresponding flow regime
for i = 1:length(MachNumber)

    if (MachNumber(i) < 0.3)
        stringVar = Regimes(1);

    elseif (MachNumber(i) >= 0.3 && MachNumber(i) < 0.8)
        stringVar = Regimes(2);

    elseif (MachNumber(i) >= 0.8 && MachNumber(i) < 1.2)
        stringVar = Regimes(3);

    elseif (MachNumber(i) == 1)
        stringVar = Regimes(4);

    elseif (MachNumber(i) >= 1.2 && MachNumber(i) < 5)
        stringVar = Regimes(5);

    elseif (MachNumber(i) > 5)
        stringVar = Regimes(6);

    end

fprintf("Vehicle %i has a Mach = %0.2g (%s)\n", i,  MachNumber(i), stringVar);
end



