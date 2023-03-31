%load data.mat to this m-file
load data.mat

%assign altitudevector and soundspeedvector from data loaded
AltitudeVector = data(:,1);
SoundSpeedVector = data(:,3);

%asks user to input the altitude and speed of the object
Speed = input('Speed:');
Altitude = input('Altitude:');

%subtract altitude from altitudevector and put absolute value on that vector. Then find its minimum value and index for minimum value use that index to find the sound of speed on that altitude
%minimum value will be the value that has nearest value to input altitude
NewAltitudeVector = abs(AltitudeVector - Altitude);
[NearAltitude, isAltitude] = min(NewAltitudeVector);

%find speed of sound at altitude using the index figured out
SoundSpeed = SoundSpeedVector(isAltitude);
 %calculate match speed by dividing sound of speed from speed of object
MachNumber = Speed/SoundSpeed;

%calculate mach angle and cast it to int from double
MachAngle = asind(1/MachNumber);
MachAngle = cast(MachAngle,"int8");

%Depending on its MachNumber, it will display its flight regime and its Mach Number
%If the flight regime is supersonic, it will also display machangle
if MachNumber < 1
    fprintf('Subsonic MachNumber: %.2f',MachNumber)
elseif MachNumber == 1
    fprintf('Sonic MachNumber: %.2f', MachNumber)
elseif 1 < MachNumber && MachNumber<=5
    fprintf('Supersonic MachNumber: %.2f MachAngle: %d', MachNumber, MachAngle)
elseif 5 < MachNumber
    fprintf('Hypersonic MachNumber: %.2f', MachNumber)
end