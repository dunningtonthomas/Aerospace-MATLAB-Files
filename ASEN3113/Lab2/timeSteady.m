%% Clean up
clear; close all; clc;

%% Import Data

%Elimnate the T0 thermocouple location, use extrapolation instead to find
%the T0 value
alum26 = readmatrix('Aluminum_26V_250mA');
alum28 = readmatrix('Aluminum_28V_269mA');
brass26 = readmatrix('Brass_26V_245mA');
brass29 = readmatrix('Brass_29V_273mA');
steel = readmatrix('Steel_21V_192mA');

%Getting rid of the T0 experimental values
alum28(:,2) = [];
brass26(:,2) = [];
brass29(:,2) = [];
steel(:,2) = [];

%Getting the time
expTime_alum26 = alum26(:,1);
expTime_alum28 = alum28(:,1);
expTime_brass26 = brass26(:,1);
expTime_brass29 = brass29(:,1);
expTime_steel = steel(:,1);


%% Analysis
%Get the time to reach steady state for each data set, use one thermocouple
%Pick the first thermocouple as it would be the most accurate
firstTC_alum26 = alum26(:,9);
firstTC_alum28 = alum28(:,9);
firstTC_brass26 = brass26(:,9);
firstTC_brass29 = brass29(:,9);
firstTC_steel = steel(:,9);

%Finding when it gets to 95% These values are the steady state
finalVal_alum26 = .975*(firstTC_alum26(end) - firstTC_alum26(1));
finalVal_alum28 = .975*(firstTC_alum28(end) - firstTC_alum28(1));
finalVal_brass26 = .975*(firstTC_brass26(end) - firstTC_brass26(1));
finalVal_brass29 = .975*(firstTC_brass29(end) - firstTC_brass29(1));
finalVal_steel = .975*(firstTC_steel(end) - firstTC_steel(1));


%Finding the time when it reaches this value
log_alum26 = firstTC_alum26 >= (finalVal_alum26 + firstTC_alum26(1));
log_alum28 = firstTC_alum28 >= (finalVal_alum28 + firstTC_alum28(1));
log_brass26 = firstTC_brass26 >= (finalVal_brass26 + firstTC_brass26(1));
log_brass29 = firstTC_brass29 >= (finalVal_brass29 + firstTC_brass29(1));
log_steel = firstTC_steel >= (finalVal_steel + firstTC_steel(1));

%Getting the first time where the condition is met
timeFinal_alum26 = expTime_alum26(log_alum26);
timeFinal_alum26 = timeFinal_alum26(1);

timeFinal_alum28 = expTime_alum28(log_alum28);
timeFinal_alum28 = timeFinal_alum28(1);

timeFinal_brass26 = expTime_brass26(log_brass26);
timeFinal_brass26 = timeFinal_brass26(1);

timeFinal_brass29 = expTime_brass29(log_brass29);
timeFinal_brass29 = timeFinal_brass29(1);

timeFinal_steel = expTime_steel(log_steel);
timeFinal_steel = timeFinal_steel(1);


%% Calculate F0 values
load('alphaAdj.mat');
L = 5.875 * 0.0254; %in meters

%F0 values

Fo_alum26 = (alpha_alum26Final * timeFinal_alum26) / L^2;
Fo_alum28 = (alpha_alum28Final * timeFinal_alum28) / L^2;
Fo_brass26 = (alpha_brass26Final * timeFinal_brass26) / L^2;
Fo_brass29 = (alpha_brass29Final * timeFinal_brass29) / L^2;
Fo_steel = (alpha_steelFinal * timeFinal_steel) / L^2;









