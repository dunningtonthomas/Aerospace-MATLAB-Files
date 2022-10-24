%% Comparing Simulation with actual data


%% Import Data
load('RSdata-10-48.mat');
%load('RSdata-sample (1).mat');


%% Analysis

time = rt_estim.time;
logVec = time >= 6;
truncTime = time(logVec);

var = rt_estim.signals.values;
truncVar = zeros(sum(logVec), 12);
var(:,2) = var(:,2)*-1;
var(:,8) = var(:,8)*-1;
for i = 1:length(var(1,:))
    tempVar = var(:,i);
    tempVar = tempVar(logVec);
   truncVar(:,i) = tempVar; 
end

%Calling the plot function
d = 0.06;
km = 0.0024;
mat = [-1,-1,-1,-1;
    -d/sqrt(2), -d/sqrt(2), d/sqrt(2), d/sqrt(2);
    d/sqrt(2), -d/sqrt(2), -d/sqrt(2), d/sqrt(2);
    km, -km, km, -km];


control = zeros(length(truncTime), 4);
for i = 1:length(control(:,1))
   control(i,:) = mat * rt_motor.signals.values(i,:)';
end


truncVar(:,1) = truncVar(:,1) - truncVar(1,1);
truncVar(:,2) = truncVar(:,2) - truncVar(1,2);
truncVar(:,3) = truncVar(:,3) - truncVar(1,3);

truncTime = truncTime - truncTime(1);
PlotAircraftSim(truncTime, truncVar, control, 1:6, 'r');

motorForces = rt_motor.signals.values;
motorForces = motorForces(logVec, :) / 1000;
%Plotting the motor forces
plotMotorForces(truncTime, motorForces, 7, 'r');



