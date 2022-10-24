%% clean up 
clear; close all; clc;

%% variable declaration
R = 287; %defines and declares R 
y = 1.4; %declares and defines gamma as y
e = 0.001; %declares and defines epsilon

%% array declarations
Temp = [-56 15 -24 -56 17 -56]; %declares an array called temp of size 6
Temp = Temp + 273.15; %defines Temp with an equation to convert the celcius temperatures to Kelving

VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5]; %declares and defines vehicleSpeed array of a size 6

SoundSpeed = sqrt(Temp*R*y); %defines the sound of speed and plugs in equation

MachNumber = VehicleSpeed ./ SoundSpeed; %defines the mach number by dviding vehiclespeed by soundspeed

Regimes = ["Incompressible" "Subsonic" "Transonic" "Sonic" "Supersonic" "Hypersonic"]; %declares a string array called regimes of size 6

vehicle = (1:6); %declares a vehicle array of size 6 from 1-6


%% For Loop
for i=(1:6) %sets the size of the for loop and defines and declares i as a size 6
    if MachNumber(i) < 0.3 %checks to see if MachNumber is less than 0.3
        fprintf("Vehicle %i has a Mach = %.3g (%s) \n", vehicle(i), MachNumber(i), Regimes(1)) %prints out a line which calls vehicle i MachNumber and incompressible

    elseif (0.3 <= MachNumber(i))  && (MachNumber(i) < 0.8) %checks to see if MachNumber is between 0.3 and 0.8
            fprintf("Vehicle %i has a Mach = %.3g (%s) \n", vehicle(i), MachNumber(i), Regimes(2)) %prints out a line which calls vehicle i MachNumber and subsonic

    elseif (0.8 <= MachNumber(1,i)) && (MachNumber(i)< 1.2) %checks to see if MachNumber is between  0.8 and 1.2
            fprintf("Vehicle %i has a Mach = %.3g (%s) \n", vehicle(i), MachNumber(i), Regimes(3)) %prints out a line which calls vehicle i MachNumber and transonic

    elseif (1-e < MachNumber(i)) && (MachNumber(i) <1+e) %checks to see if MachNumber is equal to 1 with an error size of epsilon
            fprintf("Vehicle %i has a Mach = %.3g (%s) \n", vehicle(i), MachNumber(i), Regimes(4)) %prints out a line which calls vehicle i MachNumber and sonic

    elseif (1.2 <= MachNumber(1,i)) && (MachNumber(i)< 5) %checks to see if MachNumber is between 1.2 and 5
            fprintf("Vehicle %i has a Mach = %.3g (%s) \n", vehicle(i), MachNumber(i), Regimes(5)) %prints out a line which calls vehicle i MachNumber and supersonic

    else %says that if none of the previous conditions are true prinr the following 
        fprintf("Vehicle %i has a Mach = %.3g (%s) \n", vehicle(i), MachNumber(i), Regimes(6)) %prints out a line which calls vehicle i MachNumber and hypersonic
    end
end





