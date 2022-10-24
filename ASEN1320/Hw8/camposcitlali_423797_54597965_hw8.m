%Temperature Variables
Temp = [-56 15 -24 -56 17 -56 -56 15 -24];
T = Temp + 273.15;

%Vehicles Speeds Variables
VehicleSpeed=[599.5 340.3 78.2 212.3 1743.5 262.5 350 180 450];

%Given variables
gamma = 1.4;
R = 287;

%Equation
SoundSpeed= sqrt(gamma.*R.*T);
MachNumber= VehicleSpeed./SoundSpeed;
Regimes = ["Incompressible","Subsonic","Sonic","Transonic","Supersonic","Hypersonic"];
Number = 1:9;

%For loop
for i=1:length(MachNumber)

    if(MachNumber(i)<0.3)
        Reg = Regimes(1);
    elseif(0.3<=MachNumber(i) && MachNumber(i)<0.8)
        Reg = Regimes(2);
    elseif(MachNumber(i)>= (1-0.001))&&(MachNumber(i)<=(1+0.001))
        Reg = Regimes(3);
    elseif(0.8<=MachNumber(i) &&MachNumber(i)<1.2)
        Reg = Regimes(4);
    elseif(1.2<=MachNumber(i)&&MachNumber(i)<5)
        Reg = Regimes(5);
    elseif(MachNumber(i)>5)
        Reg = Regimes(6);
    end

%Printing out 
fprintf("Vehicle %0.0f has a Mach = %0.02g (%s)\n",Number(i), MachNumber(i),Reg)

end
