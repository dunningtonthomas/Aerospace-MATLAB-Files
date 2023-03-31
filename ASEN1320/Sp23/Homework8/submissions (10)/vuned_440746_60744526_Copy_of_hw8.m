%% Load Data
load data.mat
%load data first so we can work with arrays and values

%% Vector Creation
altitudeVector = data(:,1);
% creating a column vector containing only the altitude data

soundSpeedVector = data(:,3);
% creating a column vector containing only the speed of sound data


%% User input
Speed = input("Speed: ");
Altitude = input("Altitude: ");
% prompting the user to input the values for altitude and speed

%% Finding Closest value
alt = interp1(altitudeVector,altitudeVector, Altitude, "nearest");
isAltitude = find(altitudeVector == alt);
% make a new variable which is equal to the nearest value of altitude using
% interp1
%Make a new variable called isAltitude which is the index of the nearest
%altitude and use it to find the speed of sound at that altitude

MachNumber = Speed/soundSpeedVector(isAltitude);
%Calculate mach number by dividing speed by the speed of sound at the
%nearest altitude

%% Conditional Statements
if (MachNumber < 1)
    fprintf("Subsonic MachNumber: %.2f \n",MachNumber)
    % vehicle is subsonic if MachNumber is less than 1
elseif(MachNumber == 1)
    fprintf("Sonic MachNumber: %.2f \n", MachNumber)
    % vehicle is sonic if MachNumber = 1
elseif(MachNumber < 5)
    MachAngle = asind(1/MachNumber);
    MachAngle = round(MachAngle);
    fprintf("Supersonic MachNumber: %.2f MachAngle: %i \n", MachNumber, MachAngle)
    % vehicle is supersonic if MachNumber is between 1 and 5
    % Calculate MachAngle using asin(1/MachNumber) in degrees
    % Round MachAngle to the nearest integer
elseif(Machnumber > 5)
    fprintf("Hypersonic MachNumber: %.2f \n", Machnumber)
    % vehicle is hyper sonic if MachNumber is greater than 5
end
