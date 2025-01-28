
                    %=======clear commend window each time I run=========
close all ; clear all; clc;

                              %========VECTORS=========
Temp = [-56, 15, -24, -56, 17, -56];           
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];


                            %=========VARIABLE DECLARATION========
y = 1.4;                        %Specific heat ratio
R = 287;
VehicleNum = 1:6;               %Specific gas constant air

                            %=========EQUATIONS STEPS 3-5=========
Temp = Temp + 273.15;                   %converting Celcius to Kelvin
SoundSpeed = sqrt(y.*R.*Temp);          %calculating vector sound speed
MachNumber = VehicleSpeed./SoundSpeed;  %calculating vector MachNumber


                            %===========STRING VECTOR=========
Regimes = ["Incompressible", "Subsonic", "Sonic", "Transonic", "Supersonic", "Hypersonic"];
                                    

                               %=======FOR LOOP========

for i = 1 : length(MachNumber)

 if(MachNumber(i) < 0.3)
    TempVar = Regimes(1);

 elseif(MachNumber(i) >= 0.3 && MachNumber(i)< 0.8)
     TempVar = Regimes(2);

 elseif( MachNumber(i)>= 0.001 && MachNumber(i) <= 1.001)
     TempVar = Regimes(3);

elseif(MachNumber(i) >= 0.8 && MachNumber(i)< 1.2)
     TempVar = Regimes(4);

 elseif(MachNumber(i) >= 1.2  && MachNumber(i)< 5) 
     TempVar = Regimes(5);
 
 elseif(MachNumber(i) > 5)
     TempVar = Regimes(6);

 end

                                %========PRINTING OUT VALUES========
 fprintf("Vehicle %0.0f has a Mach = %.02g (%s)\n", VehicleNum(i), MachNumber(i), Regimes(i))
end














 








