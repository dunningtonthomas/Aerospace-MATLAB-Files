%% Clean
close all; clear; clc;
ttwistor;

%% Problem 1
trim_definition = [18; 0; 1800];

[Alon, Blon, Alat, Blat] = AircraftLinearModel(trim_definition, aircraft_parameters);


% Calculate the eignvalues and vectors of the modes
[lon_vec, lon_val] = eig(Alon);
[lat_vec, lat_val] = eig(Alat);

% Longitudinal analysis
phugoid = lon_val(5,5);
phugoid_freq = sqrt(real(phugoid)^2 + imag(phugoid)^2);
phugoid_damp = -real(phugoid) / phugoid_freq;

short_period = lon_val(5,5);
short_period_freq = sqrt(real(short_period)^2 + imag(short_period)^2);
short_period_damp = -real(short_period) / short_period_freq;


% Lateral analysis
dutch = lat_val(3,3);
dutch_freq = sqrt(real(dutch)^2 + imag(dutch)^2);
dutch_damp = -real(dutch) / dutch_freq;


% Time constants of the roll and spiral
roll = lat_val(2,2);
spiral = lat_val(5,5);
roll_t = -1 / real(roll);
spiral_t = -1 / real(spiral);


%% Problem 2


