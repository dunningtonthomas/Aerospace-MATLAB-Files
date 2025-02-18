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

short_period = lon_val(3,3);
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

% Use damp
lon_sys = ss(Alon, Blon, eye(5), zeros(5,2));
lat_sys = ss(Alat, Blat, eye(5), zeros(5,2));




%% Problem 2
% Apply an impulse on the elevator when in trim to excite the phugoid and
% short period modes

% Excite the lateral modes by applying a doublet to the aileron. Two short
% pulses, one positive and then one negative and then zero.

% Excite the lateral modes by applying a doublet to the rudder

% Initial state and surfaces
trim_definition = [18; 0; 1800];
[trim_state, trim_control] = TrimCalculator(trim_definition, aircraft_parameters);
wind_inertial = [0; 0; 0];

% Elevator impulse
t_pulse = 0.2;
del_pulse = 10*pi/180;
pulse_vec = [del_pulse; 0; 0; 0];


% Integrate
odeFunc = @(t, aircraft_state)AircraftEOMPulse(t, aircraft_state, trim_control, pulse_vec, t_pulse, wind_inertial, aircraft_parameters);
tspan = [0 150];

[TOUT, XOUT] = ode45(odeFunc, tspan, trim_state);

% Control Surfaces
UOUT = zeros(length(TOUT),4);
for i=1:length(TOUT)
    UOUT(i,:) = trim_control' + ControlSurfacePulse(TOUT(i), t_pulse, pulse_vec)';
end

% Plotting
%PlotSimulation(TOUT, XOUT, UOUT, 1:6, ['r', '-']);



%%%% Lateral Excitation AILERON
t_pulse = [0.2; 0.2];
del_pulse = 10*pi/180;
pulse_vec = [0; del_pulse; 0; 0];

% Integrate
odeFunc = @(t, aircraft_state)AircraftEOMPulse(t, aircraft_state, trim_control, pulse_vec, t_pulse, wind_inertial, aircraft_parameters);
tspan = [0 150];

[TOUT, XOUT] = ode45(odeFunc, tspan, trim_state);

% Control Surfaces
UOUT = zeros(length(TOUT),4);
for i=1:length(TOUT)
    UOUT(i,:) = trim_control' + ControlSurfacePulse(TOUT(i), t_pulse, pulse_vec)';
end

% Plotting
%PlotSimulation(TOUT, XOUT, UOUT, 7:12, ['b', '-']);


%%%% Lateral Excitation RUDDER
t_pulse = [0.2; 0.2];
del_pulse = 10*pi/180;
pulse_vec = [0; 0; del_pulse; 0];

% Integrate
odeFunc = @(t, aircraft_state)AircraftEOMPulse(t, aircraft_state, trim_control, pulse_vec, t_pulse, wind_inertial, aircraft_parameters);
tspan = [0 150];

[TOUT, XOUT] = ode45(odeFunc, tspan, trim_state);

% Control Surfaces
UOUT = zeros(length(TOUT),4);
for i=1:length(TOUT)
    UOUT(i,:) = trim_control' + ControlSurfacePulse(TOUT(i), t_pulse, pulse_vec)';
end

% Plotting
PlotSimulation(TOUT, XOUT, UOUT, 13:18, ['m', '-']);



