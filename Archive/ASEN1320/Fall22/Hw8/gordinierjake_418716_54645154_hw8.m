%% Clean up
clear; close all; clc;

%% Variable declaration
y = 1.4;
R = 287;
%% Performing calculations and declaring arrays

Temp = [-56 15 -24 -56 17 -56];

VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5];

Kelvin = Temp + 273.15; % converting from celcius to kelvin

SoundSpeed = sqrt((y*R) * Kelvin); % equation for speed of sound

MachNumber = VehicleSpeed ./ SoundSpeed; % equation for determining the mach number

Regimes = ["Incompressible" "Subsonic" "Sonic" "Transonic" "Supersonic" "Hypersonic"];
%% Setting conditons for a for loop
for i=1:length(MachNumber)
%% Using if statements to set the different mach ranges with regimes
    if (MachNumber(i) < 0.3)
        fprintf('Vehicle %d has a Mach = %0.2g (%s)\n' , i, MachNumber(i), Regimes(1))

    elseif (MachNumber(i) >= 0.3 && MachNumber(i) < 0.8)
        fprintf('Vehicle %d has a Mach = %0.2g (%s)\n' , i, MachNumber(i), Regimes(2))

    elseif (MachNumber(i) >= 0.8 && MachNumber(i) < 1.2) && ~((MachNumber(i) >= (1-0.001) && MachNumber(i) <= (1 + 0.001)))
        fprintf('Vehicle %d has a Mach = %0.2g (%s)\n' , i, MachNumber(i), Regimes(4))

    elseif (MachNumber(i) >= (1-0.001) && MachNumber(i) <= (1 + 0.001))
        fprintf('Vehicle %d has a Mach = %0.2g (%s)\n' , i, MachNumber(i), Regimes(3))

    elseif (MachNumber(i) >= 1.2 && MachNumber(i) < 5)
        fprintf('Vehicle %d has a Mach = %0.2g (%s)\n' , i, MachNumber(i), Regimes(5))

    elseif (MachNumber(i) > 5)
        fprintf('Vehicle %d has a Mach = %0.2g (%s)\n' , i, MachNumber(i), Regimes(6))
    end
end
