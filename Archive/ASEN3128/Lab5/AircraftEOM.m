% Eric W. Frew
% ASEN 3128
% AircraftEOM.m
% Created: 10/15/20

function xdot = AircraftEOM(t,aircraft_state,aircraft_surfaces,wind_inertial,aircraft_parameters)
%
% Inputs:	t                   = time
%           aircraft_state      = 12x1 aircraft state vector
%           aircraft_surfaces   = 4x1 control surface vector
%           wind_inertial       = 3x1 inertial wind velocity in inertial coordinates
%           aircraft_parameters = aircraft parameter structure
%
% Outputs:	xdot                = time rate of chnge of the state vector;
%
%
% Methodology: Determine the aerodynamic forces and moments from the
% aircraft state, control surfaces, and wind vector, and then derive state
% vector derivative from the kinematics and dynamics



pos_inertial = aircraft_state(1:3,1);
euler_angles = aircraft_state(4:6,1);
vel_body = aircraft_state(7:9,1);
omega_body = aircraft_state(10:12,1);




%%% Kinematics
vel_inertial = TransformFromBodyToInertial(vel_body, euler_angles);
euler_rates = EulerRatesFromOmegaBody(omega_body, euler_angles);



%%% Aerodynamic force and moment
density = stdatmo(-pos_inertial(3,1));

[fa_body, ma_body, wind_angles] = AeroForcesAndMoments_BodyState_WindCoeffs(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);


%%% Gravity
fg_body = (aircraft_parameters.g*aircraft_parameters.m)*[-sin(euler_angles(2));sin(euler_angles(1))*cos(euler_angles(2));cos(euler_angles(1))*cos(euler_angles(2))];


%%% Dynamics
vel_body_dot = -cross(omega_body, vel_body) + (fg_body + fa_body)/aircraft_parameters.m;


inertia_matrix = [aircraft_parameters.Ix 0 -aircraft_parameters.Ixz;...
                    0 aircraft_parameters.Iy 0;...
                    -aircraft_parameters.Ixz 0 aircraft_parameters.Iz];

omega_body_dot = inv(inertia_matrix)*(-cross(omega_body, inertia_matrix*omega_body) + ma_body);


%%% State derivative
xdot = [vel_inertial; euler_rates; vel_body_dot; omega_body_dot];

end

