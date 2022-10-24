%% Clean up
clear; close all; clc;

%%declaring variables
R = 287;
y = 1.4;

%%declares arrays for each vehicle 
Vehicle1 = [-56, 599.5];
Vehicle2 = [15, 340.3];
Vehicle3 = [-24, 78.2];
Vehicle4 = [-56, 212.3];
Vehicle5 = [17, 1743.5];
Vehicle6 = [-56, 262.5];

%%temperature of each vehicle
Temp = [-56, 15, -24, -56, 17, -56];

%%speed of each vehicle
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];

%%calculate speed of sound
SoundSpeed = sqrt(y*R.*(Temp+273.15));

MachNumber = VehicleSpeed./SoundSpeed;

Regimes = ["Incompressible" "Subsonic" "Transonic" "Sonic" "Supersonic" "Hypersonic"];

%%for statment to find regimes
for i = 1:6
    if (MachNumber(i) < 0.3)
    Regime(i) = Regimes (1);
    elseif ((0.3 <= MachNumber(i)) && (MachNumber(i) < 0.8))
    Regime(i) = Regimes (2);
    elseif ((0.8 <= MachNumber(i)) && (MachNumber(i) < 1.2))
    Regime(i) = Regimes (3);
    elseif (MachNumber == 1)
    Regime(i) = Regimes (4);
    elseif ((1.2 <= MachNumber(i)) && (MachNumber(i) < 5))
    Regime(i) = Regimes (5);
    else (MachNumber(i) > 5);
    Regime(i) = Regimes (6);
    end

    %%print out the mach speed of each vehicle and what regime they are
    fprintf("Vehicle %d has a Mach = %#0.2g (%s)\n", round(i), MachNumber(i), Regime(i));

end

