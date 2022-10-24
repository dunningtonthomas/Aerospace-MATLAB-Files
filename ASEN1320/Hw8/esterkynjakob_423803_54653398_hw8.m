close all; clear; clc;
%Variable Declaration
GasConstant = 287;
HeatRatio = 1.4;
Temp = [-56 15 -24 -56 17 -56];
VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5];
Regimes = ["Incompressible" "Subsonic" "Sonic"; 
           "Transonic" "Supersonic" "Hypersonic"];

%Calculating desired values using givens
TempK = Temp + 273.15;
SoundSpeed = sqrt(HeatRatio*GasConstant*TempK);
MachNumber = VehicleSpeed ./ SoundSpeed;

%Assigning Flight Regimes to each vehicle based on data
for i = 1:length(MachNumber)
    if MachNumber(i) < 0.3
        FlightRegime = Regimes(1);

    elseif MachNumber(i) >= 0.3 && MachNumber(i) < 0.8
        FlightRegime = Regimes(2);

    elseif MachNumber(i) >= 1 - 0.001 && MachNumber(i) <= 1 + 0.001
        FlightRegime = Regimes(3);
    
    elseif MachNumber(i) >= 0.8 && MachNumber(i) < 1.2
        FlightRegime = Regimes(4);

    elseif MachNumber(i) >=1.2 && MachNumber(i) < 5
        FlightRegime = Regimes(5);

    elseif MachNumber(i) > 5
        FlightRegime = Regimes(6);
    end

    %Printing each vehicles mach number and flight regime
    fprintf("Vehicle %0.0f has a Mach = %0.2g (%s)\n", i, MachNumber(i),FlightRegime);
end
