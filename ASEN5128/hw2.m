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
init_control = [0; 0; 0; 0];
rho = stdatmo(h);

% Test forces and moments
[aero_force, aero_moment] = AeroForcesAndMoments_BodyState_WindCoeffs(init_state, init_control, wind_inertial, rho, aircraft_parameters);