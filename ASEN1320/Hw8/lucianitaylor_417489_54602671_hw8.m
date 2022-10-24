% Clean up
clear; close all; clc;

% some variable declarations 
heat_ratio = 1.4;
gas_constant = 287;
vehicle_number = [1,2,3,4,5,6];
% STEP 1 Temperature vector
Temp = [-56, 15, -24, -56, 17, -56];

% STEP 2 Vehicle speed vector
VehicleSpeed = [599.5, 340.3, 78.2 212.3, 1743.5, 262.5];

% STEP 3 Converting from celsius to Kelvin and computing speed of sound
Temp_Kelvin = Temp + 273.15;

SoundSpeed = sqrt(heat_ratio * gas_constant * Temp_Kelvin);

% STEP 4 Calculate Mach Number
MachNumber = VehicleSpeed ./ SoundSpeed;

% STEP 5 Generate a String Array
Regimes = ["Low-speed/incompressible", "Subsonic", "Transonic", "Sonic", "Supersonic", "Hypersonic"];

% STEP 6 Print out the mach number and the correspondng flow regime 
for i = 1: length(MachNumber)
    if (MachNumber(i) < 0.3 )
        fprintf ("Vehicle %.0f has a Mach %#.2g (%s) \n",i ,MachNumber(i), Regimes(1) );
        % if mach number is less that 0.3 than print out the mach number
        % and regime type Incompressible
    elseif ((MachNumber(i) < 0.8) && (MachNumber(i) >= 0.3))
        fprintf( "Vehicle %.0f has a Mach %#.2g (%s) \n",i, MachNumber(i), Regimes(2) );
        %if mach number is between 0.3 and 0.8 then print out the mach
        %number and regime type Subsonic
    elseif ((MachNumber(i) < 1.2) && (MachNumber(i) >= 0.8))
        fprintf( "Vehicle %.0f has a Mach %#.2g (%s) \n",i, MachNumber(i), Regimes(3) );
        %if mach number is between 0.8 and 1.2 then print out the mach
        %number and regime type Transonic
    elseif (MachNumber(i) == 1)
        fprintf( "Vehicle %.0f has a Mach %#.2g (%s) \n",i, MachNumber(i), Regimes(4) );
        %if mach number is equal 1 then print out the mach number and
        %regime type Sonic
    elseif ((MachNumber(i) < 5) && (MachNumber(i) >= 1.2))
        fprintf( "Vehicle %.0f has a Mach %#.2g (%s) \n",i, MachNumber(i), Regimes(5) ); 
        %if mach number is between 1.2 and 5 then print out the mach number
        %and regime type Supersonic
    elseif (MachNumber(i) > 5 )
        fprintf( "Vehicle %.0f has a Mach %#.2g (%s) \n",i, MachNumber(i), Regimes(6) );
        %if mach number is greater than 5 then print out the mach number
        %and regime type Hypersonic
    end
end
