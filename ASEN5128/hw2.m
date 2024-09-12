%% Problem 3 Code Appendix
close all; clear; clc;
ttwistor;


%% Problem 2/3
% Problem 3
V = WindAnglesToAirRelativeVelocityVector([18; 0; 0]);
VE = TransformFromBodyToInertial(V, [0; 0; 0]);
wind_inertial = [0; 0; 0];
h = 1655;
init_state = [0; 0; -h; 0; 0; 0; VE(1); VE(2); VE(3); 0; 0; 0];
aircraft_surfaces = [0; 0; 0; 0];
rho = stdatmo(h);

% Problem 2
xDot_problem2 = AircraftEOM(0, init_state, aircraft_surfaces, wind_inertial, aircraft_parameters);

% Aircraft Simulation
tspan = [0 150];
odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, 'r');


%%  Problem 3.2
V = WindAnglesToAirRelativeVelocityVector([18; 0; 0]);
wind_inertial = [10; 10; 0];
VE = TransformFromBodyToInertial(V, [0; 0; 0]);
h = 1655;
init_state = [0; 0; -h; 0; 0; 0; VE(1); VE(2); VE(3); 0; 0; 0];
aircraft_surfaces = [0; 0; 0; 0];

odeFunc = @(time, aircraft_state)AircraftEOM_key(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['b', '-']);


%% Problem 3.3
h = 1800;
init_state = [0; 0; -h; 15*pi/180; -12*pi/180; 270*pi/180; 19; 3; -2; 0.08*pi/180; -0.2*pi/180; 0];
aircraft_surfaces = [5*pi/180; 2*pi/180; -13*pi/180; 0.3];
wind_inertial = [0;0;0];
rho = stdatmo(h);

odeFunc = @(time, aircraft_state)AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

Uout = zeros(length(Tout),4);
for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotSimulation(Tout, Xout, Uout, 1:6, ['g', '-']);




