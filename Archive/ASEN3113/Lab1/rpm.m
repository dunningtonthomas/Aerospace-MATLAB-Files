%% Clean Up
clear; close all; clc;


%% Import Data

%Reading in the pressure data
data_d8 = readmatrix('test1_d8');
time_d8 = data_d8(:,1);
pressure_d8 = data_d8(:,2);
topTopTemp_d8 = data_d8(:,3);
topBottomTemp_d8 = data_d8(:,4);
bottomTopTemp_d8 = data_d8(:,5);
bottomBottomTemp_d8 = data_d8(:,6);
current_d8 = data_d8(:,7);
switch_d8 = data_d8(:,8);

data_d10 = readmatrix('test2_d10');
time_d10 = data_d10(:,1);
pressure_d10 = data_d10(:,2);
topTopTemp_d10 = data_d10(:,3);
topBottomTemp_d10 = data_d10(:,4);
bottomTopTemp_d10 = data_d10(:,5);
bottomBottomTemp_d10 = data_d10(:,6);
current_d10 = data_d10(:,7);
switch_d10 = data_d10(:,8);

data_d12 = readmatrix('test3_d12');
time_d12 = data_d12(:,1);
pressure_d12 = data_d12(:,2);
topTopTemp_d12 = data_d12(:,3);
topBottomTemp_d12 = data_d12(:,4);
bottomTopTemp_d12 = data_d12(:,5);
bottomBottomTemp_d12 = data_d12(:,6);
current_d12 = data_d12(:,7);
switch_d12 = data_d12(:,8);


%Reading in the volume data from solidworks
solidData_d8 = readmatrix('SmallPist89.csv');
solidTime_d8 = solidData_d8(:,1);
displacement_d8 = solidData_d8(:,2);

solidData_d10 = readmatrix('SmallPist92.9.csv');
solidTime_d10 = solidData_d10(:,1);
displacement_d10 = solidData_d10(:,2);

solidData_d12 = readmatrix('SmallPist120.8NEW.csv');
solidTime_d12 = solidData_d12(:,1);
displacement_d12 = solidData_d12(:,2);


%% RPM and TEMP DIff Analysis

%Average RPM
rpm_d8 = avgRpm(switch_d8, time_d8);
rpm_d10 = avgRpm(switch_d10, time_d10);
rpm_d12 = avgRpm(switch_d12, time_d12);

%Calculating the average temperature difference, using the bottom of the
%top plate and the top of the bottom plate
tempDiff_d8 = mean(bottomTopTemp_d8 - topBottomTemp_d8);
tempDiff_d10 = mean(bottomTopTemp_d10 - topBottomTemp_d10);
tempDiff_d12 = mean(bottomTopTemp_d12 - topBottomTemp_d12);

%Converting the pressure
%Converting pressure to pascal
pressure_d8 = pressure_d8 * 6894.76; %Pascals
pressure_d10 = pressure_d10 * 6894.76; %Pascals
pressure_d12 = pressure_d12 * 6894.76; %Pascals



%% Volume from solid works calculation
%Finding the total volume
totalVol_d8 = volCalcCAD(displacement_d8);
totalVol_d10 = volCalcCAD(displacement_d10);
totalVol_d12 = volCalcCAD(displacement_d12);


%% Converting the lab data to fit the sampling rate of the solidworks data
%Requirements: Both data sets must start at the same engine state, they
%must have the same sampling rate, and they must include one cycle


[finalPressure_d8, finalVolume_d8, finalTime_d8, finalSolidTime_d8] = syncData(switch_d8, pressure_d8, time_d8, rpm_d8, solidTime_d8, totalVol_d8);
[finalPressure_d10, finalVolume_d10, finalTime_d10, finalSolidTime_d10] = syncData(switch_d10, pressure_d10, time_d10, rpm_d10, solidTime_d10, totalVol_d10);
[finalPressure_d12, finalVolume_d12, finalTime_d12, finalSolidTime_d12] = syncData(switch_d12, pressure_d12, time_d12, rpm_d12, solidTime_d12, totalVol_d12);


%% Calculating the work
%The pressure starts increasing, find the first pressure value associated
%with the minimum volume and this will be the first pressure point to begin
%integration all the way until the next maximum volume pressure


%Calculating the heat in Qin
% The heater is at 48 volts




%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(finalVolume_d8 , finalPressure_d8 , 'linewidth', 2);

xlabel('Volume $$(m^{3})$$');
ylabel('Pressure $$(Pa)$$');
title('PV Diagram $$\Delta T = 8^{\circ} K$$');


figure();
plot([finalVolume_d10; finalVolume_d10(1)], [finalPressure_d10; finalPressure_d10(1)], 'linewidth', 2);

xlabel('Volume $$(m^{3})$$');
ylabel('Pressure $$(Pa)$$');
title('PV Diagram $$\Delta T = 10^{\circ} K$$');


figure();
plot([finalVolume_d12; finalVolume_d12(end)], [finalPressure_d12; finalPressure_d12(end)], 'linewidth', 2);

xlabel('Volume $$(m^{3})$$');
ylabel('Pressure $$(Pa)$$');
title('PV Diagram $$\Delta T = 12^{\circ} K$$');

%Plotting Volume over time, checking to see if it matches the rpm
% figure();
% plot(finalTime_d8, finalVolume_d8);
% 
% figure();
% plot(finalTime_d10, finalVolume_d10);
% 
% figure();
% plot(finalTime_d12, finalVolume_d12);

save('pvDiagrams', 'finalVolume_d8', 'finalPressure_d8', 'finalVolume_d10', 'finalPressure_d10', 'finalVolume_d12', 'finalPressure_d12');

%% Finding work out and work in

pressureAdd_d8 = finalPressure_d8 + 400;
pressureSub_d8 = finalPressure_d8 - 400;
pressureAdd_d10 = finalPressure_d10 + 400;
pressureAdd_d12 = finalPressure_d12 + 400;



%Work for d8
[vMax_d8, indMax_d8] = max(finalVolume_d8); 
[vMin_d8, indMin_d8] = min(finalVolume_d8);

Wout_d8 = trapz(finalVolume_d8(indMin_d8:indMax_d8), pressureAdd_d8(indMin_d8:indMax_d8));
WoutReal_d8 = trapz(finalVolume_d8(indMin_d8:indMax_d8), finalPressure_d8(indMin_d8:indMax_d8));

Win_d8 = trapz([finalVolume_d8(indMax_d8:end); finalVolume_d8(1:indMin_d8)], [pressureAdd_d8(indMax_d8:end); pressureAdd_d8(1:indMin_d8)]);
WinReal_d8 = trapz([finalVolume_d8(indMax_d8:end); finalVolume_d8(1:indMin_d8)], [finalPressure_d8(indMax_d8:end); finalPressure_d8(1:indMin_d8)]);

WnetOut_d8 = Wout_d8 + Win_d8;

%Trying to integrate the whole ellipse
WoutNet_d8 = trapz(finalVolume_d8, finalPressure_d8);

%Absolute Value for the Wout
WoutABS_d8 = trapz(finalVolume_d8(indMin_d8:indMax_d8), abs(finalPressure_d8(indMin_d8:indMax_d8)));



%Work for d10
[vMax_d10, indMax_d10] = max(finalVolume_d10); 
[vMin_d10, indMin_d10] = min(finalVolume_d10);

Wout_d10 = trapz(finalVolume_d10(indMin_d10:indMax_d10), pressureAdd_d10(indMin_d10:indMax_d10));
%Wout_d8 = Wout_d8 - 400*(finalVolume_d8(indMax_d8) - finalVolume_d8(indMin_d8));

Win_d10 = trapz([finalVolume_d10(indMax_d10:end); finalVolume_d10(1:indMin_d10)], [pressureAdd_d10(indMax_d10:end); pressureAdd_d10(1:indMin_d10)]);
WinReal_d10 = trapz([finalVolume_d10(indMax_d10:end); finalVolume_d10(1:indMin_d10)], [finalPressure_d10(indMax_d10:end); finalPressure_d10(1:indMin_d10)]);

WnetOut_d10 = Wout_d10 + Win_d10;

%Absolute Value for the Wout
WoutABS_d10 = trapz(finalVolume_d10(indMin_d10:indMax_d10), abs(finalPressure_d10(indMin_d10:indMax_d10)));

%Trying to integrate the whole ellipse
WoutNet_d10 = trapz(finalVolume_d10, finalPressure_d10);


%Work for d12
[vMax_d12, indMax_d12] = max(finalVolume_d12); 
[vMin_d12, indMin_d12] = min(finalVolume_d12);

Wout_d12 = trapz(finalVolume_d12(indMin_d12:indMax_d12), pressureAdd_d12(indMin_d12:indMax_d12));
%Wout_d8 = Wout_d8 - 400*(finalVolume_d8(indMax_d8) - finalVolume_d8(indMin_d8));

Win_d12 = trapz([finalVolume_d12(indMax_d12:end); finalVolume_d12(1:indMin_d12)], [pressureAdd_d12(indMax_d12:end); pressureAdd_d12(1:indMin_d12)]);
WinReal_d12 = trapz([finalVolume_d12(indMax_d12:end); finalVolume_d12(1:indMin_d12)], [finalPressure_d12(indMax_d12:end); finalPressure_d12(1:indMin_d12)]);

WnetOut_d12 = Wout_d12 + Win_d12;

%Absolute Value for the Wout
WoutABS_d12 = trapz(finalVolume_d12(indMin_d12:indMax_d12), abs(finalPressure_d12(indMin_d12:indMax_d12)));


%Trying to integrate the whole ellipse
WoutNet_d12 = trapz(finalVolume_d12, finalPressure_d12);



%% Caclulating the Qin from the current
power_d8 = current_d8 * 48; %constant voltage of 48V
timeOneRev_d8 = (1/rpm_d8) * 60;
logPower = time_d8 <= timeOneRev_d8;
power_d8 = power_d8(logPower);

%Fining the Qin
Qin_d8 = trapz(time_d8(logPower), power_d8);


%d10
power_d10 = current_d10 * 48; %constant voltage of 48V
timeOneRev_d10 = (1/rpm_d10) * 60;
logPower = time_d10 >= 7*timeOneRev_d10 & time_d10 <= 8*timeOneRev_d10;
power_d10 = power_d10(logPower);

%Fining the Qin
Qin_d10 = trapz(time_d10(logPower), power_d10);

%d10
power_d12 = current_d12 * 48; %constant voltage of 48V
timeOneRev_d12 = (1/rpm_d12) * 60;
logPower = time_d12 <= timeOneRev_d12;
power_d12 = power_d12(logPower);

%Fining the Qin
Qin_d12 = trapz(time_d12(logPower), power_d12);



%Calculating the Qout
Qout_d8 = Qin_d8 - WnetOut_d8;
Qout_d10 = Qin_d10 - WnetOut_d10;
Qout_d12 = Qin_d12 - WnetOut_d12;

%% Functions

%Function to calculate the average rpm
function [avgRpm_dx] = avgRpm(switch_dx, time_dx)
    %This function takes in the optical switch data and the time data and
    %calculates the average RPM
    
    %Getting it so there is only the first one in the optical switch array
    switchFinal_dx = zeros(length(switch_dx),1);

    for i = 2:(length(switch_dx))
        if(switch_dx(i) == 1 && switch_dx(i-1) ~= 1) %Condition for the first 1 
           switchFinal_dx(i) = 1; 
        end
    end

    %Calculating the average rpm
    logVec = switchFinal_dx == 1;
    timeSwitch_dx = time_dx(logVec);

    timeDiff_dx = diff(timeSwitch_dx);

    %Convert to rpm
    timeDiff_dx = (1 ./ (timeDiff_dx ./ 60));

    %RPM Average
    avgRpm_dx = mean(timeDiff_dx);
end


%Function to caculate the volume over time given the displacement vector
function [totalVol_dx] = volCalcCAD(displacement_dx)

    diameter = 15.5; %mm
    area = (diameter / 2)^2 * pi;

    %Volume of the displacer piston chamber
    displacerPistonVol = 342006 - 169312; %mm^3

    %Volume change of the power piston
    %MOST NEGATIVE corresponds to the power piston at the bottom
    test = displacement_dx;
    displacement_dx = displacement_dx - min(displacement_dx); %mm

    %Volume over time is the power piston volume change plus the displacer
    %piston volume
    volChange_dx = (displacement_dx * area) + displacerPistonVol;

    %Converting to meters cubed
    volChange_dx = volChange_dx / (1000^3);

    %Finding the total volume
    totalVol_dx = volChange_dx;
end

%Function to sync the data of the pressure and volume data
function [finalPressure_dx, finalVolume_dx, finalTime_dx, finalSolidTime_dx] = syncData(switch_dx, pressure_dx, time_dx, rpm_dx, solidTime_dx, totalVol_dx)  

    %Requirements: Both data sets must start at the same engine state, they
    %must have the same sampling rate, and they must include one cycle

    %Truncating the pressure data set so it starts with the optical sensor at
    %the on position
    %Getting the first 1 indicating the optical sensor is in line with the
    %flywheel, this is where the CAD simulation starts
    %Getting it so there is only the first one in the optical switch array
        switchFinal_dx = zeros(length(switch_dx),1);

        for i = 2:(length(switch_dx))
            if(switch_dx(i) == 1 && switch_dx(i-1) ~= 1) %Condition for the first 1 
               switchFinal_dx(i) = 1; 
            end
        end

    %Selecting the cycle
    indicesSwitch = find(switchFinal_dx);
    %IndicesSwitch now holds the indices that correspond to the start of a new
    %cycle for the presure data


    %Truncating so the pressure measurement starts with the optical sensor in
    %line, using the indicesSwitch variable
    finalPressure_dx = pressure_dx(indicesSwitch(1):end);
    finalTime_dx = time_dx(indicesSwitch(1):end);
    %Normalizing time so it starts at t=0
    finalTime_dx = finalTime_dx - finalTime_dx(1);

    %Finding seconds per revolution so we can look at one cycle
    secondsPerRev_dx = (1 / rpm_dx) * 60;

    %Getting the pressure data for the first cycle
    oneCycleLog = finalTime_dx <= secondsPerRev_dx; %Logical vector of time less than one cycle
    finalPressure_dx = finalPressure_dx(oneCycleLog);
    finalTime_dx = finalTime_dx(oneCycleLog);
    


    %Truncating the CAD data so it represents one cycle
    %It starts in the correct position, use the time logical vector to truncate
    %oneCycleLog = solidTime_dx <= secondsPerRev_dx;
    oneCycleLog = solidTime_dx >= 6*secondsPerRev_dx & solidTime_dx <= 7*secondsPerRev_dx;
    finalSolidTime_dx = solidTime_dx(oneCycleLog);
    finalSolidTime_dx = finalSolidTime_dx - finalSolidTime_dx(1);
    finalTotalVol_dx = totalVol_dx(oneCycleLog);


    %Now we match up the sampling rates
    indexVec = zeros(length(finalTime_dx),1); %Vector to store indices corresponding to the time in solidTime
    %SolidTime_d8 is the time for the CAD simulation, runs for about 14 seconds
    %time_d8 is the time for the collected pressure data, runs for about 7
    %seconds
    for i = 1:length(finalSolidTime_dx)
        [~,ind] = min(abs(finalSolidTime_dx(i) - finalTime_dx)); %Index for the closest time in the time_d8 vec
        indexVec(ind) = 1;    
    end

    %Converting to a logical vector
    indexVec = indexVec == 1;

    %Indexing into the time_d8 and pressure_d8 using the times for solidTime_d8
    finalPressure_dx = finalPressure_dx(indexVec);
    finalTime_dx = finalTime_dx(indexVec);
    finalVolume_dx = finalTotalVol_dx;
    finalSolidTime_dx = finalSolidTime_dx;
    
end



function [Win, Wout] = workCalc(volume, pressure)
    %This function calculates the work in and the work out given a PV diagram
    %with pressure and volume in their respective variables.
    %Outputs [Win, Wout] that is the work in and the work out


    %The pressure starts increasing, find the first pressure value associated
    %with the minimum volume and this will be the first pressure point to begin
    %integration all the way until the next maximum volume pressure

    %Add 400 pascals to the pressure for all pressures, will subtract this
    %out later
    pressure = pressure + 400;   


    [minVol, indMin] = min(volume); %These are the limits of integration
    [maxVol, indMax] = max(volume);

    pressureExpand = pressure(indMin:indMax); %The pressure data during the expansion, this is the work out pressure
    pressureContract = pressure(indMax:end); %The first part of the contraction and the second part

    volumeExpand = volume(indMin:indMax);
    volumeContract = volume(indMax:end);

    % 
    % figure();
    % plot(volumeExpand, pressureExpand);
    % 
    % figure();
    % plot(volumeContract, pressureContract)

    %Calculate the works

    Wout = trapz(volumeExpand, pressureExpand);
    Win = 1;


end


