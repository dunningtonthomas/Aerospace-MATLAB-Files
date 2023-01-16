% Variable decleration
Temp = [-56, 15, -24, -56, 17, -56];
VehicleSpeed = [599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];
R = 287;
y = [1.4, 1.4, 1.4, 1.4, 1.4, 1.4]
% mat lab unlike c+++ doesnt need to state varuable type and arrays dont
% also need decleration
K = Temp + 273.15;
SoundSpeed = sqrt(y.*R.*(K))
MachNumber = VehicleSpeed./SoundSpeed;
disp(MachNumber)
%% This is where my if conditons and where it ocmpares
Regime =["Low-Speed" "Subsonic" "Transonic" "Supersonic" "HyperSonic"]
% this part of the code compares the different machspeeds and assigns it
% into an array , and then through for loops I can call that array 
for i =1;length(6)
    if(MachNumber(i)<.3)
        Regime2 = Regime(1)
    elseif(.3<=MachNumber(i)<.8)
        Regime2 = Regime(2)
    elseif(.8<=MachNumber(i)<= 1.2)
        Regime2 = Regime(3)
    elseif(MachNumber(i) == 1)
        Regime2 = Regime(4)
    elseif(1.2<=MachNumber<5)
        Regime2 = Regime(5)
    elseif(Machnumber>5)
        Regime2 = Regime(6)
        
    disp(Regime2)

    end


end