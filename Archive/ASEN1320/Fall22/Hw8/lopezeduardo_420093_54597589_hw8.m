clear all; close all; clc; 

Temp = [-56, 15, -24, -56, 17, -56]; %6 Speeds in Celsius

VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5]; %The 6 speeds in m/s

Vehicle = [1:6]; %vehicle number for fprintf
y = 1.4; %Specific heat ratio of air
R = 287; %Specific gas constant of air (kg*K)
KTemp = Temp + 273.15; %Changing celsius vector into kelvin

SoundSpeed = sqrt(y.*KTemp.*R); %calculating SoundSpeed vector from Temp gamma and 


MachNumber = VehicleSpeed./SoundSpeed; %Calculating Mach number from V/a

Regimes = ["Incompressible", "Subsonic", "Sonic", "Transonic", "Supersonic", "Hypersonic"];
%stating string vector for 6 different names of machnumber

for i=1:length(MachNumber) %for loop to assign regime with mach number

    if (MachNumber(i) < 0.3)
        Regime = Regimes(1); %assigning incompressible

    elseif(MachNumber(i) >= 0.3 && MachNumber(i) < 0.8)
            Regime = Regimes(2); %subsonic

    elseif(MachNumber(i) >= (1-.001) && MachNumber(i) < (1+.001))
            Regime = Regimes(3); %sonic
          
    elseif(MachNumber(i) >= 0.8 && MachNumber(i) < 1.2)
            Regime = Regimes(4); %transonic

    elseif(MachNumber(i) >= 1.2 && MachNumber(i) < 5)
            Regime = Regimes(5); %Supersonic

    elseif(MachNumber(i) > 5)
            Regime = Regimes(6); %Hypersonic
    end
fprintf("Vehicle %g has a Mach = %0.2g (%s)\n", Vehicle(i), MachNumber(i), Regime)
%stating output, rounding mach to 2 significant digits. %g for numbers and
%s for strings.
end