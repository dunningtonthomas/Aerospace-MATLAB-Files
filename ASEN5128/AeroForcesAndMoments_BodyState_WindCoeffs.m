function [aero_force, aero_moment] = AeroForcesAndMoments_BodyState_WindCoeffs(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters)
% Takes as input the aircraft state, the control input vector,
% the inertial wind velocity in inertial coordinates, the air density, and the aircraft parameters 
% structure and returns the aerodynamic force and moment acting on the aircraft expressed in body coordinates
% 
% Inputs: 
%   aircraft_state -> full 12x1 aircraft state
%   aircraft_surfaces -> control input vector [de, da, dr, dt]
%   wind_inertial -> inertial wind velocity in inertial coordinates
%   density -> air density
%   aircraft_parameters -> aircraft parameter structure
% Output:
%   aero_force -> aerodynamic force in body coordinates, includes
%   propulsion
%   aero_moment -> aerodynamic moment in body coordinates
% 
% Author: Thomas Dunnington
% Date Modified: 9/10/2024

% State parameters
position = aircraft_state(1:3);
euler_angles = aircraft_state(4:6);
velocity_inertial = aircraft_state(7:9);
angular_velocity = aircraft_state(10:12);

% Input parameters
de = aircraft_surfaces(1);
da = aircraft_surfaces(2);
dr = aircraft_surfaces(3);
dt = aircraft_surfaces(4);

% Wind angles
velocity_air_relative = velocity_inertial - TransformFromInertialToBody(wind_inertial, euler_angles);
wind_angles = AirRelativeVelocityVectorToWindAngles(velocity_air_relative);
airspeed = wind_angles(1);
beta = wind_angles(2);
alpha = wind_angles(3);

% Dynamic Pressure
Q = 0.5*density*airspeed^2;

% Nondimensional rates
phat = (angular_velocity(1)*aircraft_parameters.b)/(2*airspeed);
qhat = (angular_velocity(2)*aircraft_parameters.c)/(2*airspeed);
rhat = (angular_velocity(3)*aircraft_parameters.b)/(2*airspeed);

% Lift and Drag calculations
CL = aircraft_parameters.CL0 + aircraft_parameters.CLalpha*alpha + aircraft_parameters.CLq*qhat + aircraft_parameters.CLde*de;
CD = aircraft_parameters.CDmin + aircraft_parameters.K*(CL - aircraft_parameters.CLmin)^2;

% Aerodynamic Force Coefficients
CX = -CD*cos(alpha) + CL*sin(alpha);
CY = aircraft_parameters.CY0 + aircraft_parameters.CYbeta*beta + aircraft_parameters.CYp*phat + aircraft_parameters.CYr*rhat + aircraft_parameters.CYda*da + aircraft_parameters.CYdr*dr;
CZ = -CD*sin(alpha) - CL*cos(alpha);

% Propulsive Force Coefficient
CT = 2*aircraft_parameters.Sprop/aircraft_parameters.S * aircraft_parameters.Cprop * ...
    dt/(airspeed^2) * (airspeed + dt*(aircraft_parameters.kmotor - airspeed))*(aircraft_parameters.kmotor - airspeed);

% Moment Coefficients
Cl = aircraft_parameters.Cl0 + aircraft_parameters.Clbeta*beta + aircraft_parameters.Clp*phat + aircraft_parameters.Clr*rhat + aircraft_parameters.Clda*da + aircraft_parameters.Cldr*dr;
Cm = aircraft_parameters.Cm0 + aircraft_parameters.Cmalpha*alpha + aircraft_parameters.Cmq*qhat + aircraft_parameters.Cmde*de;
Cn = aircraft_parameters.Cn0 + aircraft_parameters.Cnbeta*beta + aircraft_parameters.Cnp*phat + aircraft_parameters.Cnr*rhat + aircraft_parameters.Cnda*da + aircraft_parameters.Cndr*dr;

% Aero Forces
X = aircraft_parameters.S*Q*CX;
Y = aircraft_parameters.S*Q*CY;
Z = aircraft_parameters.S*Q*CZ;

% Propulsive Force
T = aircraft_parameters.S*Q*CT;

% Aero Moments
L = aircraft_parameters.b*aircraft_parameters.S*Q*Cl;
M = aircraft_parameters.c*aircraft_parameters.S*Q*Cm;
N = aircraft_parameters.b*aircraft_parameters.S*Q*Cn;

% Return force and moments
aero_force = [X + T; Y; Z];
aero_moment = [L; M; N];
end

