%% Clean
close all; clear; clc;
ttwistor;

%% Test fmincon
h = 1655;
Va = 18;
gamma0 = 0;
trim_definition = [Va; gamma0; h];

% Test
% init_state = [0; 0; -1800; 15*pi/180; -12*pi/180; 270*pi/180; 19; 3; -2; 0.08*pi/180; -0.2*pi/180; 0];
% aircraft_surfaces = [5*pi/180; 2*pi/180; -13*pi/180; 0.3];
% wind_inertial = [0;0;0];
% density = stdatmo(1800);
% [aero_force, aero_moment] = AeroForcesAndMoments_BodyState_WindCoeffs(init_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);

[trim_state,trim_control] = TrimCalculator(trim_definition,aircraft_parameters);


%% Simulate
tspan = [0 100];
init_state = trim_state;
aircraft_surfaces = trim_control;
wind_inertial = [0;0;0];

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['g', '-']);

