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

wind_inertial = [0;0;0];
[trim_state_1,trim_control_1] = TrimCalculator(trim_definition, wind_inertial, aircraft_parameters);

% Problem 3.2
wind_inertial = [10; 10; 0];
[trim_state_2,trim_control_2] = TrimCalculator(trim_definition, wind_inertial, aircraft_parameters);

%% Simulate
tspan = [0 100];
init_state = trim_state_1;
aircraft_surfaces = trim_control_1;
wind_inertial = [0;0;0];

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['g', '-']);

%%%%%%
% 3.2
init_state = trim_state_2;
aircraft_surfaces = trim_control_2;
wind_inertial = [10; 10; 0];

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['r', '-']);


%% Coordinated Turn
% Trim definition
h = 200;
Va = 20;
gamma0 = 0;
R0 = 500;
tspan = [0 300];
trim_definition = [Va; gamma0; h; R0];
wind_inertial = [0;0;0];

% Calculate coordinated turn conditions
[coord_state, coord_control] = CoordinatedTurnCalculator(trim_definition, wind_inertial, aircraft_parameters);

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, coord_control, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, coord_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = coord_control';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['b', '-']);



