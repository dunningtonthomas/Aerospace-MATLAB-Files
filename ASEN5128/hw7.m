%% Clean
close all; clear; clc;

%% Problem 1
%%% Define parameters for specifying control law
SLC = 2;
FEED = 1;

%%% Set flags
CONTROL_FLAG = SLC; % <========= Set to control law to use (SLC or FEED)

%%% Aircraft parameter file
ttwistor;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Determine trim state and control inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V_trim = 18;
h_trim = 1805;
gamma_trim = 0;
trim_definition = [V_trim; gamma_trim; h_trim];

%%% STUDENTS REPLACE THESE TWO FUNCTIONS WITH YOUR VERSIONS FROM HW3/4
% [trim_variables, fval] = CalculateTrimVariables(trim_definition, aircraft_parameters);
% [aircraft_state_trim, control_input_trim] = TrimConditionFromDefinitionAndVariables(trim_variables, trim_definition);
[aircraft_state_trim, control_input_trim, trim_variables] = TrimCalculator(trim_definition, aircraft_parameters);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Determine control gains
%%% See 'RunGVF.m for how gain files were created
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (CONTROL_FLAG==FEED)
    gains_file = 'ttwistor_gains_feed';
    fprintf(1, '\n==================================== \nAUTOPILOT: SLC with Feedforward\n \n')
else
    gains_file = 'ttwistor_gains_slc';
    fprintf(1, '\n ==================================== \nAUTOPILOT: Simple SLC\n \n')
end

load(gains_file)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set input commands for autopilot.
%%%
%%% Note, STUDENTS may need to change these while tuning the autopilot.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h_c         = h_trim;  % commanded altitude (m)
h_dot_c     = 0;  % commanded altitude rate (m)
chi_c       = 40*pi/180;  % commanded course (rad)
chi_dot_ff  = 0;  % commanded course rate (rad)   
Va_c        = V_trim;  % commanded airspeed (m/s)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set aircraft and simulation initial conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_state0 = aircraft_state_trim;
control_input0 = control_input_trim;
wind_inertial = [0;0;0];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set simulation and control parameters
%%%
%%% Note, the simulation runs on two separate times scales. The variable Ts
%%% specifies the "sample time" of the control system. The control law
%%% calculates a new control input every Ts seconds, and then holds that
%%% control input constant for a short simulation of duration Ts. Then, a
%%% new control input is calculated and a new simulation is run using the
%%% output of the previous iteration as initial condition of the next
%%% iteration. The end result of each short simulation is stored as the
%%% state and control output. Hence, the final result is a simulation with
%%% state and control input at every Ts seconds.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = .1;
Tfinal = 300;
control_gain_struct.Ts=Ts;

%%% iterate at control sample time
n_ind = Tfinal/Ts;

aircraft_array(:,1) = aircraft_state0;
control_array(:,1) = control_input0;
time_iter(1) = 0;

% Simulate
for i=1:n_ind

    TSPAN = Ts*[i-1 i];

    wind_array(:,i) = wind_inertial;

    wind_body = TransformFromInertialToBody(wind_inertial, aircraft_array(4:6,i));
    air_rel_vel_body = aircraft_array(7:9,i) - wind_body;
    wind_angles(:,i) = AirRelativeVelocityVectorToWindAngles(air_rel_vel_body);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Guidance level commands
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    control_objectives(1) = h_c;
    control_objectives(2) = h_dot_c;
    control_objectives(3) = chi_c;
    control_objectives(4) = chi_dot_ff;
    control_objectives(5) = Va_c;

    % STUDENTS WRITE THIS FUNCTION
    %control_objectives = OrbitGuidance(aircraft_array(:,i), orbit_speed, orbit_radius, orbit_center, orbit_flag, orbit_gains);
    %control_objectives = [1800; 0; 45*pi/180; 0; V_trim]; %<============== Comment out when OrbitGuidance is complete


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Autopilot
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if (CONTROL_FLAG==FEED)
        orbit_radius = 200;
        control_objectives = OrbitGuidance(aircraft_array(:,i), orbit_speed, orbit_radius, orbit_center, orbit_flag, orbit_gains);
        control_gain_struct.Kp_course_rate = 0.4;
        control_gain_struct.Kff_course_rate = 1;
        [control_out, x_c_out] = SLCWithFeedForwardAutopilot(Ts*(i-1), aircraft_array(:,i), wind_angles(:,i), control_objectives, control_gain_struct);
    else
        [control_out, x_c_out] = SimpleSLCAutopilot(Ts*(i-1), aircraft_array(:,i), wind_angles(:,i), control_objectives, control_gain_struct);
    end
    
    control_array(:,i) = control_out;
    x_command(:,i) = x_c_out;
    x_command(5,i) = trim_variables(1);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Aircraft dynamics
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [TOUT2,YOUT2] = ode45(@(t,y) AircraftEOM(t,y,control_array(:,i),wind_inertial,aircraft_parameters),TSPAN,aircraft_array(:,i),[]);


    aircraft_array(:,i+1) = YOUT2(end,:)';
    time_iter(i+1) = TOUT2(end);
    wind_array(:,i+1) = wind_inertial;
    control_array(:,i+1) = control_array(:,i);
    x_command(:,i+1) = x_command(:,i);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PlotSimulation(time_iter,aircraft_array,control_array, wind_array,'b')
% if (CONTROL_FLAG == SLC)
%     PlotSimulationWithCommands(time_iter,aircraft_array,control_array, wind_array, x_command, 'b')
% else
%     PlotSimulationWithCommands(time_iter,aircraft_array,control_array, wind_array, x_command, 'm')
% end


%% Determine Guidance Model Parameters
% Course angle
wnx = sqrt(9.81*control_gain_struct.Ki_course / (V_trim));
dampx = control_gain_struct.Kp_course * 9.81 / (2*wnx*V_trim);

params.bx = wnx^2;
params.bx_dot = 2*wnx*dampx;

% Tune parameters to match the curves
% params.bx = params.bx * 50;
% params.bx_dot = params.bx_dot * 2.2;
params.bx = params.bx * 90;
params.bx_dot = params.bx_dot * 4;

% Height hold
params.ah_dot = 1;
params.bh_dot = 1;
params.bh = 0.1;

% Airspeed hold
params.bva = 1;


%% Nonlinear guidance simulation
% Course angle
xc = [chi_c; chi_dot_ff];
courseFunc = @(t, x)courseEOM(t, x, xc, params);

% Simulate with ode
tspan = [0 Tfinal];
[TOUT_course, YOUT_course] = ode45(courseFunc, tspan, [0;0]);


% Height
xc = [h_c; h_dot_c];
heightFunc = @(t, x)heightEOM(t, x, xc, params);

% Simulate with ode
height_init = [h_trim; 0];
tspan = [0 Tfinal];
[TOUT_height, YOUT_height] = ode45(heightFunc, tspan, height_init);


% Airspeed
xc = [Va_c];
velFunc = @(t, x)velocityEOM(t, x, xc, params);

% Simulate with ode
vel_init = [V_trim];
tspan = [0 Tfinal];
[TOUT_vel, YOUT_vel] = ode45(velFunc, tspan, vel_init);


%% Plot Course Angle
ind_f = length(aircraft_array(1,:));

%%% Replicate the plot from PlotStateVariables
for i=1:ind_f
    wind_inertial = wind_array(1:3,i);
    wind_body = TransformFromInertialToBody(wind_inertial, aircraft_array(4:6,i));
    air_rel_body = aircraft_array(7:9,i) - wind_body;
    wind_angles = AirRelativeVelocityVectorToWindAngles(air_rel_body);
    [flight_angles] = FlightPathAnglesFromState(aircraft_array(1:12,i));
    
    % Get the air relative velocity over time
    Va(i) = wind_angles(1);
    
    % Get the course angle over time
    chi(i) = 180/pi*flight_angles(2);
end

% Course angle plot
figure();
plot(time_iter, chi, 'linewidth', 2, 'color', 'r');
hold on;
plot(TOUT_course, 180/pi .* YOUT_course(:,1), 'linewidth', 2, 'color', 'b');
yline(chi_c*180/pi, '--', 'color', 'g')

xlabel('Time (s)');
ylabel('\chi_c (deg)')
title('Course Angle Response')
legend('Autopilot', 'Guidance Model')

% Height plot
figure();
plot(time_iter, -aircraft_array(3,:), 'linewidth', 2, 'color', 'r');
hold on;
plot(TOUT_height,YOUT_height(:,1), 'linewidth', 2, 'color', 'b');
yline(h_c, '--', 'color', 'g')

xlabel('Time (s)');
ylabel('h_c (deg)')
title('Height Response')
legend('Autopilot', 'Guidance Model')


% Velocity plot
figure();
plot(time_iter, Va, 'linewidth', 2, 'color', 'r');
hold on;
plot(TOUT_vel,YOUT_vel(:,1), 'linewidth', 2, 'color', 'b');
yline(Va_c, '--', 'color', 'g')

xlabel('Time (s)');
ylabel('h_c (deg)')
title('Velocity Response')
legend('Autopilot', 'Guidance Model')

%% EOM Functions
% Course angle EOM of nonlinear guidance model
function dxdt = courseEOM(t, x, xc, params)
    % Current state
    chi = x(1);
    chi_dot = x(2);

    % Desired state
    chi_c = xc(1);
    chi_c_dot = xc(2);

    % ROC
    dxdt = [chi_dot; params.bx_dot*(chi_c_dot - chi_dot) + params.bx*(chi_c - chi)];    
end

% Height EOM of nonlinear guidance model
function dxdt = heightEOM(t, x, xc, params)
    % Current state
    h = x(1);
    h_dot = x(2);

    % Desired state
    h_c = xc(1);
    h_c_dot = xc(2);

    % ROC
    dxdt = [h_dot; -params.ah_dot * h_c_dot - params.bh_dot * h_dot + params.bh*(h_c - h)];    
end

% Velocity EOM for guidance model
function dvdt = velocityEOM(y, x, xc, params)
    % Current state
    Va = x(1);

    % Desired state
    Va_c = xc(1);

    % ROC
    dvdt = params.bva * (Va_c - Va);
end