clear; close all; clc;

%Variable declaration:
R = 287; %Specific gas constant of air in J/(kg*k)
gamma = 1.4; %Specific heat ratio of air
Temp = [-56 15 -24 -56 17 -56]; %Vehicle's operating temperature in ⁰C
VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5]; %Vehicle's operating velocity in m/s
TempK = Temp + 273.15; %Operation to obtain the vehicle's operating temperature in K
Number = [1:1:6]; %When pritning the output each vehicle needs to be numbered so I created an array with the numbers.


%Equations to generate SoundSpeed and MachNumber
SoundSpeed = sqrt(R*gamma*TempK); %Scaler operation so no need for the dot operator.
MachNumber = VehicleSpeed./SoundSpeed; %Element-wise operation the dot operator is necenecessary.


%String array
Regimes = ["Incompressible", "Subsonic", "Transonic", "Sonic", "Supersonic", "Hypersonic"];


%If-elseif statement to obtain the correct flow regime for each MachNumber
for i=1:length(MachNumber)
    if (MachNumber(i) < 0.3);
       flowregime = Regimes(1);

    elseif (0.3 <= MachNumber(i) && MachNumber(i) < 0.8);
       flowregime = Regimes(2);

    elseif (0.999 <= MachNumber(i) && MachNumber(i) <= 1.001);
       flowregime = Regimes(4);

    elseif (0.8 <= MachNumber(i) && MachNumber(i) < 1.2);
       flowregime = Regimes(3);

    elseif (1.2 <= MachNumber(i) && MachNumber(i) < 5);
       flowregime = Regimes(5);

    else (MachNumber(i) > 5);
       flowregime = Regimes(6);
    end

  fprintf("Vehicle %.0f has a Mach = %.2g (%s)\n", Number(i), MachNumber(i), flowregime) %Printing the output with the conversion character %f and assiging it to 0 significant digits and second conversion character %g with 2 significant digits and the last conversion character is a %s which is a string array. 

    end

