%% Coding Challenge 13
clc; clear; close all;
% Create Constants
R = 287;     % J/kg.K Specific Gas Constant of Air
gamma = 1.4; % Specific Heat Ratio of Air

Temp = [-56; 15; -24; -56; 17; -56];                       % Vector containing Temperature of all 6 Vehicles (degree celcius)
VehicleSpeed = [599.5; 340.3; 78.2; 212.3; 1743.5; 262.5]; % Vector containing Velocities of all 6 Vehicles (m/s)
SpeedOfSound = zeros(6, 1);                                % Vector containing Speed-Of-Sound of all 6 Vehicles (m/s)
Mach = zeros(6, 1);                                        % Vector containing Mach-Number of all 6 Vehicles



%% Read in calculation for Speed-Of-Sound
for i = 1:6
    SpeedOfSound(i) = sqrt( gamma*R*(Temp(i)+(273.15)) ); % m/s
end

%% Read in calculations for Mach-Number
for i = 1:6
    Mach(i) = VehicleSpeed(i)/SpeedOfSound(i); % m/s

    if Mach(i) < 0.3
        fprintf("Vechicle %d has a Mach Number of %2.4f and Flow Regime: 'Low-speed, incompressible'.\n", i, Mach(i))
    elseif Mach(i) >= 0.3 && Mach(i) < 0.8
        fprintf("Vechicle %d has a Mach Number of %2.4f and Flow Regime: 'Subsonic'.\n", i, Mach(i))
    elseif Mach(i) >= 0.8 && Mach(i) < 1.2 && Mach(i) ~= 1
        if Mach(i) > 0.9999 && Mach(i) < 1.2
            fprintf("Vechicle %d has a Mach Number of %2.4f and Flow Regime: 'Sonic'.\n", i, Mach(i))
        else
            fprintf("Vechicle %d has a Mach Number of %2.4f and Flow Regime: 'Transonic'.\n", i, Mach(i))
        end
    elseif Mach(i) == 1
        fprintf("Vechicle %d has a Mach Number of %2.4f and Flow Regime: 'Sonic'.\n", i, Mach(i))
    elseif Mach(i) >= 1.2 && Mach(i) < 5
        fprintf("Vechicle %d has a Mach Number of %2.4f and Flow Regime: 'Supersonic'.\n", i, Mach(i))
    elseif Mach(i) > 5
        fprintf("Vechicle %d has a Mach Number of %2.4f and Flow Regime: 'Hypersonic'.\n", i, Mach(i))
    end
end


