close all; clear variables; clc;    %commands clean up command window and workspace

% Variable Declaration: specific heat ratio of the air, specific gas
% constant of the air, the various temperatures and vehicle speeds for
% each of the six aircraft (stored in double arrays), and the flight
% regimes (stored in string array)

y = 1.4;        

R = 287; 

Temp = [-56, 15, -24, -56, 17, -56]; 

VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5]; 

Regimes = ["Incompressible", "Subsonic", "Sonic", "Transonic", "Supersonic", "Hypersonic"];


% Algorithm that computes the speed of sound in each aircraft's operating
% environment 
SpeedSound = sqrt((Temp + 273.15).* (y*R));

% Algorithm that computes the mach number of each Vehicle 
MachNumber = VehicleSpeed ./ SpeedSound; 



% For loop iterating 6 times for the number of different mach numbers
for i=1: length(MachNumber)

  %if and elseif statements that assign certain ranges of mach numbers to certain flight regimes 
    
    if (MachNumber(i) < 0.3)             
        stringVar = Regimes(1);

    elseif(MachNumber(i) >= 0.3 && MachNumber(i) < 0.8)
       stringVar = Regimes(2); 
    
    elseif (MachNumber(i) >= 0.999 && MachNumber(i) <= 1.001)
        stringVar = Regimes(3); 
    
    elseif (MachNumber(i) >= 0.8 && MachNumber(i) < 1.2)
            stringVar = Regimes(4); 
   
    elseif (MachNumber(i) >= 1.2 && MachNumber(i) < 5)
        stringVar = Regimes(5);
    
    elseif(MachNumber(i) >= 5)
        stringVar = Regimes(6); 

    end
    fprintf("Vehicle %i has a Mach = %0.2g (%s)\n", i, MachNumber(i), stringVar)      % Print statement that prints out the vehicle number, mach number, and flight regime for each aircraft 
end

