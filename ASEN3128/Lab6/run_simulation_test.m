

clear all;
close all;


recuv_tempest;

Va_trim = 22;
h_trim = 2438.5;

wind_inertial = [0;0;0];

trim_definition = [Va_trim; h_trim];


%%% Determine trim
[trim_variables, fval] = CalculateTrimVariables(trim_definition, aircraft_parameters);
[trim_state, trim_input]= TrimStateAndInput(trim_variables, trim_definition);

%%% Set initial condition

alpha = trim_variables(1)
aircraft_state0 = [0; 0; -h_trim; 0; alpha; 0; Va_trim*cos(alpha); 0; Va_trim*sin(alpha); 0; 0; 0]
control_input0 = [trim_variables(2); 0; 0; trim_variables(3)]

%%% Full sim in ode45
tfinal = 150;
TSPAN = [0 tfinal];
[TOUT,YOUT] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);


for i=1:length(TOUT)
    UOUT(i,:) = control_input0';
end

PlotAircraftSim(TOUT,YOUT,UOUT,'b')
