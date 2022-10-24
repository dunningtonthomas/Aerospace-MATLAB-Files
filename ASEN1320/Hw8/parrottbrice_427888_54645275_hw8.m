
%% Clean up
clear; close all; clc;


Temp = [-56,15,-24,-56,17,-56];%%6 elements;holds tempatures of vehicle respectively, in Calsius
VehicleSpeed = [599.5,340.3,78.2,212.3,1743.5,262.5];%%6 elements; hold the speed of each vehicle, in m/s

gamma = 1.4; %%specific heat ratio
R = 287; %%specific gas constant of ai, in J/(kg*K)

SoundSpeed = sqrt(gamma*R.*(Temp+273.15)); %%6 elements; calulates the speed of each sound using element wise operations on the respective temperature of each vehicle

MachNumber = VehicleSpeed ./ SoundSpeed;%%6 elements; calculates the Mach Number of each vehicle sing element wise operation on each vehicles respective vehicle and sound speed


Regimes = ["Low-speed, incompressible", "Subsonic", "Transonic","Sonic","Supersonic", "Hypersonic"];%%6 elements; holds the names of each classifacation of vehicle speed depending on mach (low mach to high mach)

%%checks the mach of each vehicle and prints the corresponding mach to the
%%command terminal along with the vehicle number and the numerical value of
%%the vehicles mach

for i=1:length(Regimes)
    fprintf("Vehicle %i has a Mach = %.2g ", i, MachNumber(i))
    
    if (MachNumber(i)>5)
        fprintf("(%s)\n", Regimes(6))
    elseif (MachNumber(i)>= 1.2 && MachNumber(i)<5)
        fprintf("(%s)\n", Regimes(5))
    elseif (MachNumber(i)==1)
        fprintf("(%s)\n", Regimes(4))
    elseif (MachNumber(i)>= 0.8 && MachNumber(i)<1.2)
        fprintf("(%s)\n", Regimes(3))
    elseif (MachNumber(i)>=0.3 && MachNumber(i)<0.8)
        fprintf("(%s)\n",Regimes(2))
    else
        fprintf("(%s)\n",Regimes(1)) 
    end


end