clear; close all; clc;
%Clean up command window, workspace, etc. - Just clears everthing before
%running again

%declaration and initalizing of variables and arrarys
HeatRatio = 1.4;
R = 287;
Temp = [-56 15 -24 -56 17 -56];
VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5];

%updating temperature array to add 273.15 to each value so temperature is in Kelvin
Temp = Temp + 273.15;

%calculating speed of sound by taking the square root of temperature, the
%heat ratio and the gas constant
SoundSpeed = sqrt(Temp .* HeatRatio .* R); %it is multiplying elementaly by using .*

%calculating mach number by dividing the vehicle arrray by the soundspeed
%array and storing it into the MachNumber array.
MachNumber = VehicleSpeed ./ SoundSpeed; %divides elementaly by using./

Regimes = ["Incompressible" "Subsonic" "Transonic" "Sonic" "Supersonic" "Hypersonic"];

%for loop with a length of 6 because MachNumber has a lenght of 6
for i=1:length(MachNumber)
    %using if else statments to assign the different regimes to different mach numbers
    if (MachNumber(i) <  0.3)
    Regime = Regimes(1);    
    elseif (MachNumber(i) >=0.3 && MachNumber(i)<0.8)
    Regime = Regimes(2);      
    elseif (MachNumber(i) >=0.8 && MachNumber(i)<1.2)
    Regime = Regimes(3);  
    elseif (MachNumber(i) >= 1-0.001 && MachNumber(i)<= 1+0.001) 
    Regime = Regimes(4); 
    elseif (MachNumber(i) >=1.2 && MachNumber(i)<5)
    Regime = Regimes(5);  
    else
    Regime = Regimes(6);      
    end
%while still in the for loop printing out the index number for the vehicle number,
%the mach number at that index to 2 precision, 
% and the coresponding regime to the Mach number in the parenthese
fprintf("Vehicle %i has a Mach = %0.2g (%s)\n",i, MachNumber(i), Regime);
end