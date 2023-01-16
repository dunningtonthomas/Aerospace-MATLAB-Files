% Eric W. Frew
% ASEN 3128
% TrimStateAndInput.m
% Created: 10/15/20

function [trim_state, trim_input] = TrimStateAndInput(trim_variables, trim_definition)

alpha0 = trim_variables(1);
theta0 = alpha0;

%%% Set initial state components
position_inertial = [0;0;-trim_definition(2)];
euler_angles = [0;theta0;0];

velocity_air_body = VelocityBodyFromWindAngles([trim_definition(1); 0; alpha0]);
velocity_body = velocity_air_body;

omega_body = [0;0;0];

trim_state = [position_inertial; euler_angles; velocity_body; omega_body];
trim_input = [trim_variables(2); 0; 0; trim_variables(3)];