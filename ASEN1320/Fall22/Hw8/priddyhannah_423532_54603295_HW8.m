clear; close all; clc;

Temp = [-56 15 -24 -56 17 -56];
VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5];

R = 287;
Gamma = 1.4;
%Variable declaration

Temp = Temp + 273.15; %change to Kelvin

Soundspeed = sqrt(Temp .* R .*Gamma); %finding the speed of sound
MachNumber = VehicleSpeed./Soundspeed; %finding the Mach by dividing v by a

Regimes = ["incompressable" "Subsonic" "Transonic" "Sonic" "Supersonic" "Hypersonic"]; %string array

for i = 1:length(MachNumber) %for loop to iterate through the different Machnumbers and assign a value in the string array
    if MachNumber(i) < 0.3
        label = Regimes(1);
    elseif (MachNumber(i) < 0.8)
        label = Regimes(2);
    elseif (MachNumber(i) < 1.2 && ~(.99 < MachNumber(i) && MachNumber(i) < 1.01))
        label = Regimes(3);
    elseif (.99 < MachNumber(i) && MachNumber(i) < 1.01)
        label = Regimes(4);
    elseif (MachNumber(i) < 5)
        label = Regimes(5);
    else
        label = Regimes(6); %if statement runs through the sonic conditions and assigns the label
    end
    fprintf( "Vehicle %i has a Mach = %0.3g (%s) \n", i, MachNumber(i), label) %print for every statement in the loop
end