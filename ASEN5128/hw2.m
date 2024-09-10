%% Clean
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

% Test forces and moments
[aero_force, aero_moment] = AeroForcesAndMoments_BodyState_WindCoeffs(init_state, aircraft_surfaces, wind_inertial, rho, aircraft_parameters);

% Aircraft Simulation
tspan = [0 100];
odeFunc = @(time, aircraft_state)AircraftEOM(time,aircraft_state,aircraft_surfaces,wind_inertial,aircraft_parameters);
[Tout, Xout] = ode45(odeFunc, tspan, init_state);

for i=1:length(Tout)
    Uout(i,:) = aircraft_surfaces';
end

PlotAircraftSim(Tout, Xout, Uout, 1:6, 'r');


