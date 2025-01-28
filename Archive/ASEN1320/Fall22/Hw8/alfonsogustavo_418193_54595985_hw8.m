%variable declearations
R = 287;%Specific gas constant of air 
y = 1.4;%Specific heat ratio of air

Temp = [-56, 15, -24, -56, 17, -56];
VehicleSpeed = [599.5, 340.3, 78.2, 212.2, 1743.5, 262.5];
Regimes = ["Incompressible" "Subsonic" "Transonic" "Sonic" "Supersonic" "Hypersonic"];

%caclulations
SoundSpeed = sqrt(y*R*(Temp+273.15)); %c to k conversion imbeded into the formula
MachNumber = VehicleSpeed./SoundSpeed;


for i=1:length(MachNumber) %iterates for each element of arrays

    fprintf("Vehilcle %i has a Mach = %#4.2f ", i,round(MachNumber(i), 2) ) 
    %i is also the number of the train. 
    %Uses #.2g to set the amount of significant figures 
    %round to round to two places to the right of the decimal

    %If statements for regime
    if MachNumber(i)<0.3
        fprintf("(%s)\n",Regimes(1))
    end
    %If the condition is true it calls the type of speed from index of
    %regime array and finishes the line that was previously started
    if MachNumber(i)>=0.3 && MachNumber(i)<0.8
        fprintf("(%s)\n",Regimes(2))
    end
    if MachNumber(i)>=0.8 && MachNumber(i)<1 || MachNumber(i)>1 && MachNumber(i)<1.2 
        fprintf("(%s)\n",Regimes(3))
    end
    %can be in a range under 1 or over 1
    if MachNumber(i)==1
        fprintf("(%s)\n",Regimes(4))
    end
    if MachNumber(i)>=1.2 && MachNumber(i)<5
        fprintf("(%s)\n",Regimes(5))
    end
    if MachNumber(i)>=5
        fprintf("(%s)\n",Regimes(6))
    end




end