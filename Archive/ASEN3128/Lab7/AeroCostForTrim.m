% Eric W. Frew
% ASEN 3128
% AeroCostForTrim.m
% Created: 10/15/20

function cost = AeroCostForTrim(trim_variables, trim_definition, aircraft_parameters)
%
%
% INPUT:    trim_definition = [V0; rho0]
%
%           trim_variables = [alpha0; de0; dt0];
%
% OUTPUT:   cost = norm(total_force) + norm(total_moment)
%
% 
% METHOD:   Determines the total force acting on the aircraft from the
%           aerodynamics and weight. Then takes the norm of both to create 
%           a single cost function that can be minimized.


[aircraft_state0, control_surfaces_trim] = TrimStateAndInput(trim_variables, trim_definition);

theta = aircraft_state0(5,1);
rho0=stdatmo(trim_definition(2));

[aero_forces, aero_moments] = AeroForcesAndMoments_BodyState_WindCoeffs(aircraft_state0, control_surfaces_trim, [0;0;0], rho0, aircraft_parameters);

forces_trim = aero_forces + aircraft_parameters.W*[-sin(theta);0;cos(theta)];

cost = norm(forces_trim) + norm(aero_moments); 