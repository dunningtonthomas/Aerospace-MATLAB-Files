clear; close all; clc;

% Initialize Values
Temp = [-56 15 -24 -56 17 -56 ];
VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5 ];

R = 287;
gamma = 1.4;

% Calculate Speed of Sound
SoundSpeed =  sqrt((R * gamma) .* (Temp + 273.15));

% Calculate Mach
MachNumber = VehicleSpeed ./ SoundSpeed;

% Initialize Mach Regimes
Regimes = [ "Incompressible" "Subsonic"  "Transonic" "Sonic" "Supersonic" "Hypersonic" ];

% Label Vehicle Regimes
for i = 1:length(MachNumber)
    regime = "";
    
    % Label vehicle based on mach numbers
    if  MachNumber(i) < 0.3 
        regime = Regimes(1);
        
    elseif ((MachNumber(i) >= 0.3) & (MachNumber(i) < 0.8))
        regime = Regimes(2);

    elseif ((MachNumber(i) >= 0.999) & (MachNumber(i) <= 1.001))
        regime = Regimes(4);
        
    elseif ((MachNumber(i) >= 0.8) & (MachNumber(i) < 1.2))
        regime = Regimes(3);
        
    elseif ((MachNumber(i) >= 1.2) & (MachNumber(i) < 5))
        regime = Regimes(5);
        
    elseif ((MachNumber(i) > 5))
        regime = Regimes(6);
        
    end
    
    % Format and log data
    fprintf( "Vehicle %i has a Mach = %g (%s)\n" , i , round(MachNumber(i), 2, "significant") , regime); 
end
