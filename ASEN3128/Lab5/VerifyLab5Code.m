

clear all;
close all;

%%% aircrat parameter file
recuv_tempest;

tfinal = 100;
TSPAN = [0 tfinal];


wind_inertial = [0;0;0];


%%% set initial conditions
position_inertial0 = [0;0;-600];
euler_angles0 = [0;0;0];
velocity_body0 = [20; 0; 5];
omega_body0 = [0;0;0];


aircraft_state0 = [position_inertial0; euler_angles0; velocity_body0; omega_body0];
control_input0 = [20*pi/180; 0; 0; .75];


%%% Full sim in ode45
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);

for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end

%%% plot results
PlotAircraftSim(TOUT,YOUT,UOUT,'b')