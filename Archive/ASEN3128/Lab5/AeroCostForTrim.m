% Eric W. Frew
% ASEN 3128
% AeroCostForTrim.m
% Created: 10/15/20
% STUDENTS COMPLETE THIS FUNCTION

function cost = AeroCostForTrim(trim_variables, trim_definition, aircraft_parameters)
%
%
% INPUT:    trim_definition = [V0; h0]
%
%           trim_variables = [alpha0; de0; dt0];
%
% OUTPUT:   cost = norm(total_force) + norm(total_moment)
%
% 
% METHOD:   Determines the total force acting on the aircraft from the
%           aerodynamics and weight. Then takes the norm of both to create 
%           a single cost function that can be minimized.


alpha0 = trim_variables(1);
de0 = trim_variables(2);
dt0 = trim_variables(3);

V0 = trim_definition(1);
h0 = trim_definition(2);
theta0 = alpha0;
rho0=stdatmo(h0);


%%% Determine the TOTAL force `forces` and TOTAL moment `moments`
%%% acting on the aircraft based on the `trim_variables` and
%%% `trim definition` arguments. You should use the
%%% `AeroForcesAndMoments_BodyState_WindCoeffs` function

% aircraft_state = [xe, ye, ze, roll, pitch, yaw, ue, ve, we, p, q, r]
% 
% aircraft_surfaces = [de da dr dt];

ue = V0 * cos(alpha0);
ve = 0;
we = V0 * sin(alpha0);

aircraft_state = [0; 0; -h0; 0; theta0; 0; ue; ve; we; 0; 0; 0];
aircraft_surfaces = [de0; 0; 0; dt0];
wind_inertial = [0; 0; 0];
[aero_forces, moments, wind_angles] = AeroForcesAndMoments_BodyState_WindCoeffs(aircraft_state, aircraft_surfaces, wind_inertial ,rho0, aircraft_parameters);

weightForce = aircraft_parameters.W * [-sin(alpha0); 0; cos(alpha0)];
forces = aero_forces + weightForce;

%%% Final cost is calculated from total force and moment vectors
cost = norm(forces) + norm(moments); 
