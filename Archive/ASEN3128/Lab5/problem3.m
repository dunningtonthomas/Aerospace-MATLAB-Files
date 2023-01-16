%% Clean up
close all; clear; clc;


%% Analysis
%Initial aircraft state
V = 19;
h = 600;
wind = [0;0;0];
aircraft_parameters = aircraftParamFunc();


%Getting the trim variables using fmincon
[trim_variables, fval] = CalculateTrimVariables([V; h], aircraft_parameters);

%Determine the aircraft state for this trim condition


%Approximating the trim variables using the static stability
[alphaStatic, elevatorStatic] = CalculateTrimFromStaticStability([V; h], aircraft_parameters);


%% Verifying with simulation

tfinal = 100;
TSPAN = [0 tfinal];


wind_inertial = [0;0;0];


%%% Initial Conditions for 3.a
alpha3a = trim_variables(1);
elevator3a = trim_variables(2);
throttle3a = trim_variables(3);

position_inertial0 = [0;0;-600];
euler_angles0 = [0;alpha3a;0];
velocity_body0 = [19*cos(alpha3a); 0; 19*sin(alpha3a)];
omega_body0 = [0;0;0];


aircraft_state0 = [position_inertial0; euler_angles0; velocity_body0; omega_body0];
control_input0 = [elevator3a; 0; 0; throttle3a];


%%% Full sim in ode45
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);

for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end
 

%%% plot results
PlotAircraftSim(TOUT,YOUT,UOUT,wind_inertial,'b')




%Initial Conditions for 3.b
alpha3b = alphaStatic;
elevator3b = elevatorStatic;
throttle3b = trim_variables(3); %Same throttle as the previous part

position_inertial0 = [0;0;-600];
euler_angles0 = [0;alpha3b;0];
velocity_body0 = [19*cos(alpha3b); 0; 19*sin(alpha3b)];
omega_body0 = [0;0;0];

aircraft_state0 = [position_inertial0; euler_angles0; velocity_body0; omega_body0];
control_input0 = [elevator3b; 0; 0; throttle3b];


%%% Full sim in ode45
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);

for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end
 

%%% plot results
PlotAircraftSim(TOUT,YOUT,UOUT,wind_inertial,'r')






