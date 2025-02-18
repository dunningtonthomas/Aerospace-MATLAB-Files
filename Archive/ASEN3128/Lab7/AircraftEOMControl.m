function xdot = AircraftEOMControl(t,aircraft_state,aircraft_surfaces0,wind_inertial,aircraft_parameters)


pos_inertial = aircraft_state(1:3,1);
euler_angles = aircraft_state(4:6,1);
vel_body = aircraft_state(7:9,1);
omega_body = aircraft_state(10:12,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Control law
%%% [This shows implementation of the pitch control. STUDENTS EDIT for
%%% other controllers]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta_c = 3*pi/180;
kq = -8; 
kth = -7.5; 

elev_perturb = PitchAttitudeControl(theta_c, aircraft_state(5), aircraft_state(11), kth, kq); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% YAW DAMPER
rc = 0;
kr = -6.38;

rudder_perturb = yawDamper(rc, aircraft_state(12), kr);
rudder_perturb = -kr*aircraft_state(12);

%%%% Roll Control
phi_c = atan2(21^2, 1000*9.81*cos(aircraft_state(5)));
ka = -7;
kp = 0.5;

phi = aircraft_state(4);
p = aircraft_state(10);


aileron_perturb = ka*(kp*(phi_c - phi) - p);


%Final Surfaces
% aircraft_surfaces = [elev_perturb; aileron_perturb; rudder_perturb; 0];
aircraft_surfaces = aircraft_surfaces0 + [0; aileron_perturb; rudder_perturb; 0];

%%%%%%%%%%%%%%%%%%%%%%
%%% Kinematics
vel_inertial = TransformFromBodyToInertial(vel_body, euler_angles);
euler_rates = EulerRatesFromOmegaBody(omega_body, euler_angles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% State derivative
xdot = [vel_inertial; euler_rates; vel_body_dot; omega_body_dot];

end

