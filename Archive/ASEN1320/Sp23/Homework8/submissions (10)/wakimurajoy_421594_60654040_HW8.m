% Author: Joy Wakimura
% Date: 3/15/2023

load('data.mat');

% Takes 1st column of data array and puts it in AltitudeVector
% and takes 3rd column of data array and puts it in SoundSpeedVector
AltitudeVector = [data(:,1)];
SoundSpeedVector = [data(:,3)];

Speed = input('Speed:');
Altitude = input('Altitude:');

% Calculates the difference between inputted altitude and numbers in array
% then finds where the difference is the least and assigns it to array
% spot X
difference = AltitudeVector - Altitude;
[~, X] = min(abs(difference));
isAltitude = X;

% Using index from closest altitude, finding coresponding speed
altitudeSpeed = SoundSpeedVector(isAltitude);

% Calculates MachNumber
MachNumber = Speed/altitudeSpeed;

% Outputs what type of sonic and MachNumber
if (MachNumber < 1)
    fprintf('Subsonic MachNumber: %.2f\n', MachNumber);
elseif MachNumber == 1
    fprintf('Sonic MachNumber: %.2f\n', MachNumber);
elseif MachNumber > 5
    fprintf('Hypersonic MachNumber: %.2f\n', MachNumber);
else 
    MachAngle = int16(asind(1/MachNumber));
    fprintf('Supersonic MachNumber: %.2f ',MachNumber);
    fprintf('MachAngle: %i\n', MachAngle);
end


