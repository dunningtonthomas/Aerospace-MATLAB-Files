clear %clear workspace
clc   %clear command prompt

load data.mat %loading data
AltitudeVector = data(:,1); %assigning vector to first column 
SoundSpeedVector = data(:,3); %vector to third column
Speed = input('Speed: ');
Altitude = input('Altitude: '); %Asking for input for speed and altitude
[~,isAltitude] = min(abs(AltitudeVector-Altitude));
 %finding the nearest value
SoundSpeed = SoundSpeedVector(isAltitude);
MachNumber = rdivide(Speed,SoundSpeed);
MachAngle= asind(1 ./ MachNumber); 
if(MachNumber < 1)
    fprintf("Subsonic MachNumber: %.2f",MachNumber);
elseif(MachNumber==1)
    fprintf("Sonic MachNumber: %.2f",MachNumber);
elseif(MachNumber > 1 && MachNumber < 5)
    fprintf("Supersonic MachNumber: %.2f MachAngle: %d", MachNumber,round(MachAngle))
else
    fprintf("Hypersonic MachNumber: %.2f", MachNumber)
end %find the sonic type 












