clear; close all; clc;             %clears console and workspace


Temp = [-56, 15, -24, -56, 17, -56];                         %setting array values
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];

Temp = Temp + 273.15;       %K conversion

SoundSpeed = sqrt(1.4 * 287 * Temp);   %sound speed equation

Mach = VehicleSpeed ./ SoundSpeed;     %mach equation


Regimes = ["Incompressible", "Subsonic", "Sonic", "Transonic", "Supersonic", "Hypersonic"]; %setting string array for regimes

for i = 1:6         %for loop iterates 6 times

    if (Mach(i) >= 0.999 && Mach(i) <= 1.001)      %if and else if statements which display different values for the regime based on mach value

        fprintf("Vehicle %i has a mach = %.2f (%s) \n" ,i,Mach(i),Regimes(3));

        else if (Mach(i) < 0.3)
        
             fprintf("Vehicle %i has a mach = %.2f (%s) \n" ,i,Mach(i),Regimes(1));

        else if (Mach(i) < 0.8)

             fprintf("Vehicle %i has a mach = %.2f (%s) \n" ,i,Mach(i),Regimes(2));

        else if (Mach(i) < 1.2)

             fprintf("Vehicle %i has a mach = %.2f (%s) \n" ,i,Mach(i),Regimes(4));

        else if (Mach(i) < 5)

             fprintf("Vehicle %i has a mach = %.2f (%s) \n" ,i,Mach(i),Regimes(5));

        else

             fprintf("Vehicle %i has a mach = %.2f (%s) \n" ,i,Mach(i),Regimes(6));
        end
        end
        end    %for some reason my code errors out without all these "ends"
        end
       
    end


end



