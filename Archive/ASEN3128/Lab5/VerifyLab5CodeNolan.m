

clear all;
close all;

%% aircrat parameter file
recuv_tempest;

tfinal = 150;
TSPAN = [0 tfinal];

%% Problem 4a:
wind_inertial = [0;0;0];
airSpeed = 21; % m/s
h = 2000; % m

[trimDef, ~] = CalculateTrimVariables([airSpeed; h], aircraft_parameters);
trimAlpha = trimDef(1);
trimBeta = 0;
trimElev = trimDef(2);
trimThrot = trimDef(3);
% set initial conditions
position_inertial0 = [0;0;-h];
euler_angles0 = [0;trimAlpha;0];
velocity_body0 = airSpeed*[cos(trimAlpha)*cos(trimBeta); sin(trimBeta); sin(trimAlpha)*cos(trimBeta)];
omega_body0 = [0;0;0];

aircraft_state0 = [position_inertial0; euler_angles0; velocity_body0; omega_body0];
control_input0 = [trimElev; 0; 0; trimThrot];

%%% Full sim in ode45
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);

UOUT = zeros(length(TOUT),4);
for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end

%%% plot results
PlotAircraftSim(TOUT,YOUT,UOUT, wind_inertial,'b')

%% 4b

wind_inertial = [10;10;0];
airSpeed = 21; % m/s
h = 2000; % m

[trimDef, ~] = CalculateTrimVariables([airSpeed; h], aircraft_parameters);
trimAlpha = trimDef(1);
trimBeta = 0;
trimElev = trimDef(2);
trimThrot = trimDef(3);
% set initial conditions
position_inertial0 = [0;0;-h];
euler_angles0 = [0;trimAlpha;0];
velocity_body0 = airSpeed*[cos(trimAlpha)*cos(trimBeta); sin(trimBeta); sin(trimAlpha)*cos(trimBeta)];
omega_body0 = [0;0;0];

aircraft_state0 = [position_inertial0; euler_angles0; velocity_body0; omega_body0];
control_input0 = [trimElev; 0; 0; trimThrot];

%%% Full sim in ode45
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);

UOUT = zeros(length(TOUT),4);
for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end

%%% plot results
PlotAircraftSim(TOUT,YOUT,UOUT, wind_inertial,'k')

%% 4c

wind_inertial = [10;10;0];
airSpeed = 21; % m/s
h = 2000; % m

[trimDef, ~] = CalculateTrimVariables([airSpeed; h], aircraft_parameters);
trimAlpha = trimDef(1);
trimBeta = 0;
trimElev = trimDef(2);
trimThrot = trimDef(3);

wind_body = TransformFromInertialToBody(wind_inertial, [0; trimAlpha; 0]);
% set initial conditions
position_inertial0 = [0;0;-h];
euler_angles0 = [0;trimAlpha;0];
velocity_body0 = airSpeed*[cos(trimAlpha)*cos(trimBeta); sin(trimBeta); sin(trimAlpha)*cos(trimBeta)] + wind_body;
omega_body0 = [0;0;0];

aircraft_state0 = [position_inertial0; euler_angles0; velocity_body0; omega_body0];
control_input0 = [trimElev; 0; 0; trimThrot];


%%% Full sim in ode45
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);

UOUT = zeros(length(TOUT),4);
for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end

%%% plot results
PlotAircraftSim(TOUT,YOUT,UOUT, wind_inertial,'r')
% 
%% 4d

wind_inertial = [10;10;0];
airSpeed = 21; % m/s
h = 2000; % m

trimBeta = asin(norm(wind_inertial)*(sin(15*(pi/180))/airSpeed)); % in rad

trimYaw = trimBeta + 60*(pi/180);

[trimDef, ~] = CalculateTrimVariables([airSpeed; h], aircraft_parameters);
trimAlpha = trimDef(1);
trimElev = trimDef(2);
trimThrot = trimDef(3);

wind_body = TransformFromInertialToBody(wind_inertial, [0; trimAlpha; trimYaw]);
% set initial conditions
position_inertial0 = [0;0;-h];
euler_angles0 = [0;trimAlpha;trimYaw];
velocity_body0 = airSpeed*[cos(trimAlpha)*cos(trimBeta); sin(trimBeta); sin(trimAlpha)*cos(trimBeta)] + wind_body;
omega_body0 = [0;0;0];

aircraft_state0 = [position_inertial0; euler_angles0; velocity_body0; omega_body0];
control_input0 = [trimElev; 0; 0; trimThrot];


%%% Full sim in ode45
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);

UOUT = zeros(length(TOUT),4);
for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end

%%% plot results
PlotAircraftSim(TOUT,YOUT,UOUT,wind_inertial,'r')
