
load data.mat
AltitudeVector = data(:,1);
%Taking just the first column of data for altitude
SoundSpeedVector = data(:,3);
%Taking just the third column of data for altitude/speedofsound relation

Speed = input('Speed:');
%taking speed input
Altitude = input('Altitude:');
%Taking altitude input

[Val,isAltitude] = min(abs(AltitudeVector-Altitude));
minVal=AltitudeVector(isAltitude);
%Calculating the closest value in the Altitude vector to the entered
%altitude

Speedofsound = SoundSpeedVector(isAltitude);
%locating the row vector that is used in isAltitude

MachNumber = Speed/Speedofsound;
%round(MachNumber,2);
%calculating and rounding the speed of sound

Angle = asind(1/MachNumber);
%calculating angle of the Machnumber

if (MachNumber < 1)
    fprintf('Subsonic MachNumber: %.2f \n',MachNumber)  
    %If statement that checks if Mach Number is below 1 making it subsonic
elseif (MachNumber == 1)
    frpintf('Sonic MachNumber: %.2f \n' ,MachNumber)
    %If statement that checks if Mach Number is equal to 1 making it sonic
elseif (1 < MachNumber) && (MachNumber <= 5)
    fprintf('Supersonic MachNumber: %.2f Mach Angle: %.2g \n' ,MachNumber,Angle)
    %If statement that checks if Mach Number is in between 1 and 5 making it supersonic
elseif (MachNumber > 5)
    fprintf('Hypersonic MachNumber: %.2f \n', MachNumber)
    %If statement that checks if Mach Number is above 5 making it hypersonic
else
end