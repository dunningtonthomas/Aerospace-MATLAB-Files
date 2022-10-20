clc;
clear all;
close all;

gamma = 1.4;                     % [-] Specific heat ratio
R =     287;                     % [J/kg*K] specific gas constant air 

Temp(1,:) = [-56 15 -24 -56 17 -56];                      % [Celsius] 
Temp(1,:) = Temp(1,:)+273.15;

VehicleSpeed(1,:) = [599.5 340.3 78.2 212.3 1743.5 262.5];              % [m/s]

SoundSpeed(1,:) = sqrt(gamma*R*Temp(1,:));

MachNumber(1,:) = VehicleSpeed(1,:)./SoundSpeed(1,:);

for i = linspace(1,6,6)

Regimes = string(["Incompressible"; "Subsonic"; "Sonic"; "Transonic"; "Supersonic"; "Hypersonic"])';

if (MachNumber(1,i) < 0.3)
    Regime = Regimes(1,1);

elseif ((0.3 <= MachNumber(1,i)) && (MachNumber(:,i) < 0.8))
    Regime = Regimes(1,2);

elseif ((0.8 <= MachNumber(1,i)) && (MachNumber(:,i) < 1.2) && (MachNumber(:,i) ~= 1))
    Regime = Regimes(1,4);

elseif (MachNumber(1,i) == 1)
    Regime = Regimes(1,3);

elseif ((1.2 <= MachNumber(1,i)) && (MachNumber(:,i) < 5))
    Regime = Regimes(1,5);

elseif (MachNumber(1,i) > 5)
    Regime = Regimes(1,6);

end

fprintf("Vehicle %d has a Mach = %0.2g (%s)\n", i, MachNumber(1,i), Regime);

end