% Eric W. Frew
% ASEN 3128
% AeroForcesAndMoments_BodyState_WindCoeffs.m
% Created: 10/15/20


function [aero_forces, aero_moments, wind_angles] = AeroForcesAndMoments_BodyState_WindCoeffs(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters)
%
% 
% aircraft_state = [xe, ye, ze, roll, pitch, yaw, ue, ve, we, p, q, r]
%   NOTE: The function assumes the veolcity is the air relative velocity
%   vector. When used with simulink the wrapper function makes the
%   conversion.
%
% aircraft_surfaces = [de da dr dt];
%
% Lift and Drag are calculated in Wind Frame then rotated to body frame
% Thrust is given in Body Frame
% Sideforce calculated in Body Frame


%%% redefine states and inputs for ease of use
ap = aircraft_parameters;

wind_body = TransformFromInertialToBody(wind_inertial, aircraft_state(4:6,1));
air_rel_vel_body = aircraft_state(7:9,1) - wind_body;

[wind_angles] = WindAnglesFromVelocityBody(air_rel_vel_body);
V = wind_angles(1,1);
beta = wind_angles(2,1);
alpha = wind_angles(3,1);

p = aircraft_state(10,1);
q = aircraft_state(11,1);
r = aircraft_state(12,1);

de = aircraft_surfaces(1,1);
da = aircraft_surfaces(2,1);
dr = aircraft_surfaces(3,1);
dt = aircraft_surfaces(4,1);

alpha_dot = 0;

Q = 0.5*density*V*V;

sa = sin(alpha);
ca = cos(alpha);

%%% determine aero force coefficients
CL = ap.CL0 + ap.CLalpha*alpha + ap.CLq*q*ap.c/(2*ap.u0) + ap.CLde*de;
CD = ap.CDmin + ap.K*(CL-ap.CLmin)^2;


CX = -CD*ca + CL*sa;
CZ = -CD*sa - CL*ca;

CY = ap.CY0 + ap.CYbeta*beta + ap.CYp*p*ap.b/(2*ap.u0) + ap.CYr*r*ap.b/(2*ap.u0) + ap.CYda*da + ap.CYdr*dr;

Thrust = density*ap.Sprop*ap.Cprop*(V + dt*(ap.kmotor - V))*dt*(ap.kmotor-V); %% Small UAS model as described in http://uavbook.byu.edu/lib/exe/fetch.php?media=shared:propeller_model.pdf


%%% determine aero forces from coeffficients 
X = Q*ap.S*CX + Thrust;
Y = Q*ap.S*CY;
Z = Q*ap.S*CZ;

aero_forces = [X;Y;Z];

%%% determine aero moment coefficients
Cl = [ap.Cl0 + ap.Clbeta*beta + ap.Clp*p*ap.b/(2*ap.u0) + ap.Clr*r*ap.b/(2*ap.u0) + ap.Clda*da + ap.Cldr*dr];
Cm = [ap.Cm0 + ap.Cmalpha*alpha + ap.Cmq*q*ap.c/(2*ap.u0) + ap.Cmde*de];
Cn = [ap.Cn0 + ap.Cnbeta*beta + ap.Cnp*p*ap.b/(2*ap.u0) + ap.Cnr*r*ap.b/(2*ap.u0) + ap.Cnda*da + ap.Cndr*dr];

%%% determine aero moments from coeffficients
aero_moments = Q*ap.S*[ap.b*Cl; ap.c*Cm; ap.b*Cn];%[l;m;n];

