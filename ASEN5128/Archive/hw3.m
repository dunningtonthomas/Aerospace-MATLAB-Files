%% Clean
close all; clear; clc;
ttwistor;

%% Trim Conditions
h = 1655;
Va = 18;
gamma0 = 0;
trim_definition = [Va; gamma0; h];

% Problem 3.1
[trim_state_1,trim_control_1] = TrimCalculator(trim_definition, aircraft_parameters);

% Problem 3.2
[trim_state_2,trim_control_2] = TrimCalculator(trim_definition, aircraft_parameters);

% Problem 3.3
trim_definition_3 = [Va; 10*pi/180; h];
[trim_state_3,trim_control_3] = TrimCalculator(trim_definition_3, aircraft_parameters);

%% Simulate
%%%%
% 3.1
tspan = [0 300];
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

% Add wind 
init_state(7:9) = init_state(7:9) + TransformFromInertialToBody(wind_inertial, init_state(4:6));

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['r', '-']);

%%%%%
% 3.3
init_state = trim_state_3;
aircraft_surfaces = trim_control_3;
wind_inertial = [0; 0; 0];

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['m', '-']);


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
[coord_state, coord_control] = CoordinatedTurnCalculator(trim_definition, aircraft_parameters);

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, coord_control, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, coord_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = coord_control';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['b', '-']);



