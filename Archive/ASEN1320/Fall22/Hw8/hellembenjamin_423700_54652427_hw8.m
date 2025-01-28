
clear; close all; clc;
R = 287; %Gas Constant of air 
HeatRatio = 1.4;

Temp = [-56, 15, -24, -56, 17, -56];
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];

tempKelvin = Temp + 273.15;
SoundSpeed = sqrt(HeatRatio .* R .* tempKelvin);
MachNumber = (VehicleSpeed ./ SoundSpeed);
Regime = ["Low-speed, incompressible" "Subsonic" "Transonic" "Sonic" "Supersonic" "Hypersonic"];


for i = 1:length(MachNumber)
   
    if (MachNumber(i)< 0.3)
            regimeName = Regime(1);
            fprintf("Vehicle %i has a Mach = %0.2g, (%s) \n", (i), MachNumber(i), regimeName);
    elseif (0.3 <= MachNumber(i) && MachNumber(i)< 0.8)
            regimeName = Regime(2);
            fprintf("Vehicle %i has a Mach = %0.2g, (%s) \n", (i), MachNumber(i), regimeName);
    elseif (0.8 <= MachNumber(i) && MachNumber(i) < 1.2)
            regimeName = Regime(3);
            fprintf("Vehicle %i has a Mach = %0.2g, (%s) \n", (i), MachNumber(i), regimeName);
    elseif (MachNumber(i) == 1)
            regimeName = Regime(4);
            fprintf("Vehicle %i has a Mach = %0.2g, (%s) \n", (i), MachNumber(i), regimeName);
    elseif (1.2 <= MachNumber(i) && MachNumber(i) < 5)
            regimeName = Regime (5);
            fprintf("Vehicle %i has a Mach = %0.2g, (%s) \n", (i), MachNumber(i), regimeName);
    elseif (MachNumber(i) > 5)
            regimeName = Regime (6);
            fprintf("Vehicle %i has a Mach = %0.2g, (%s) \n", (i), MachNumber(i), regimeName);
    end
    
end


   


     
