% Eric W. Frew
% ASEN 5128
% RunHW9.m
% Created: 4/8/23
%  
% This is a helper that students can use to complete HW 8. 
%
%

close all;% <========= Comment out this line and you can run this file multiple times and plot results together
clear all; 



%%% Define parameters for specifying control law
SLC = 2;
FEED = 1;
SIMPLE = 1;
SMOOTH = 2;

%%% Set flags
ANIMATE_FLAG = 0; % <========= Set to 1 to show animation after simulation
CONTROL_FLAG = FEED; % <========= Set to control law to use (SLC or FEED)
ESTIM_FLAG = SMOOTH; % <========= Set to estimator to use (SIMPLE or SMOOTH)
ESTIM_CONTROL_FLAG = 0;% <========= Set to 1 to control from estimated state (not true state)

%%% Aircraft parameters
ttwistor
sensor_params = SensorParametersTtwistor(aircraft_parameters);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Determine trim state and control inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V_trim = 18;
h_trim = 1805;
gamma_trim = 0;
trim_definition = [V_trim; gamma_trim; h_trim];


%%% STUDENTS REPLACE THESE TWO FUNCTIONS WITH YOUR VERSIONS FROM HW3/4 <============================================================================
[trim_variables, fval] = CalculateTrimVariables(trim_definition, aircraft_parameters);
[aircraft_state_trim, control_input_trim] = TrimConditionFromDefinitionAndVariables(trim_variables, trim_definition);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load control gains
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

gvf_speed = 18;
gvf_radius = 500;
gvf_center = [5000;5000;-1805];
gvf_flag=1;
gvf_gains.kr = .01;
gvf_gains.kz = .001;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Set aircraft and simulation initial conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_state0 = aircraft_state_trim;

aircraft_state0(3,1) = -1655; %<------- CLIMB mode starts when aircraft reaches h = 1675
aircraft_state0(4,1) = 0*pi/180;

control_input0 = control_input_trim;

wind_inertial = [0;10;0];



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

Ts = sensor_params.Ts_imu; % which should be 0.1 sec;

%sensor_params.Ts_gps = Ts; % <============================ Uncomment this line if you want GPS to run as fast as the IMU



Tfinal = 1000;
control_gain_struct.Ts=Ts;

%%% iterate at control sample time
n_ind = Tfinal/Ts;

aircraft_array(:,1) = aircraft_state0;
control_array(:,1) = control_input0;
time_iter(1) = 0;


for i=1:n_ind

    TSPAN = Ts*[i-1 i];

    wind_array(:,i) = wind_inertial;

    wind_body = TransformFromInertialToBody(wind_inertial, aircraft_array(4:6,i));
    air_rel_vel_body = aircraft_array(7:9,i) - wind_body;
    wind_angles(:,i) = WindAnglesFromVelocityBody(air_rel_vel_body);



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Sensor measurements
    %%%
    %%%   gps_sensors = [pn; pe; ph; Vg; chi];
    %%%   inertial_sensors = [y_accel; y_gyro; y_pressure; y_dyn_pressure];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    gps_sensor(:,i) = GPSSensor(aircraft_array(:,i), sensor_params);
    inertial_sensors(:,i) = InertialSensors(aircraft_array(:,i), control_array(:,i), wind_array(:,i), aircraft_parameters, sensor_params);



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Estimator
    %%%
    %%% The estimators assume two time scales:
    %%%   1. The main loop which runs at the simulation rate, which is also the IMU rate
    %%%   2. A slower update at the GPS rate of the position sensor information only
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(ESTIM_FLAG==SIMPLE)
        [aircraft_state_est(:,i), wind_inertial_est(:,i)] = SimpleEstimator(time_iter(i), gps_sensor(:,i), inertial_sensors(:,i), sensor_params);
    else
        [aircraft_state_est(:,i), wind_inertial_est(:,i)] = EstimatorAttitudeGPSSmoothing(time_iter(i), gps_sensor(:,i), inertial_sensors(:,i), sensor_params);
    end

    wind_body_est = TransformFromInertialToBody(wind_inertial_est(:,i), aircraft_state_est(4:6,i));
    air_rel_est = aircraft_state_est(7:9,i) - wind_body_est;
    wind_angles_est(:,i) = WindAnglesFromVelocityBody(air_rel_est);

    if(ESTIM_CONTROL_FLAG)
        aircraft_state_con(:,i) = aircraft_state_est(:,i);
        wind_angles_con(:,i) = wind_angles_est(:,i);
    else
        aircraft_state_con(:,i) = aircraft_array(:,i);
        wind_angles_con(:,i) = wind_angles(:,i);
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Guidance level commands
    %%%
    %%%   control_objectives(1) = h_c;
    %%%   control_objectives(2) = h_dot_c;
    %%%   control_objectives(3) = chi_c;
    %%%   control_objectives(4) = chi_dot_ff;
    %%%   control_objectives(5) = Va_c;
    %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% STUDENTS REPLACE WITH YOUR GUIDANCE ALGORITHM FROM HOMEWORK 6
    control_objectives = OrbitGuidance(aircraft_state_con(1:3,i), gvf_speed, gvf_radius, gvf_center, gvf_flag, gvf_gains);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Autopilot
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if (CONTROL_FLAG==FEED)
        [control_out, x_c_out] = SLCWithFeedForwardAutopilot(Ts*(i-1), aircraft_state_con(:,i), wind_angles_con(:,i), control_objectives, control_gain_struct);
    else
        [control_out, x_c_out] = SimpleSLCAutopilot(Ts*(i-1), aircraft_state_con(:,i), wind_angles_con(:,i), control_objectives, control_gain_struct);
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
    aircraft_state_est(:,i+1) = aircraft_state_est(:,i);
    wind_inertial_est(:,i+1) = wind_inertial_est(:,i);

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PlotSimulation(time_iter,aircraft_array,control_array, wind_array,'b')
PlotSimulationWithCommands(time_iter,aircraft_array,control_array, wind_array, x_command, 'b')

PlotSimulationWithCommands(time_iter,aircraft_state_est,control_array, wind_inertial_est, x_command, 'r--')

for c = 0:1:360;
    circ_orbit(:,c+1) = gvf_center + gvf_radius*[cosd(c); sind(c); 0];
end
figure(8);
plot3(circ_orbit(1,:),circ_orbit(2,:),-circ_orbit(3,:),'k:');


figure(11);
subplot(311)
plot(time_iter, wind_inertial_est(1,:),'b'); hold on;
plot(time_iter([1, end]), [wind_inertial(1) wind_inertial(1)], 'g--')
title('Wind Velocity vs. Time')
ylabel('wn [m/s]')
subplot(312)
plot(time_iter, wind_inertial_est(2,:)); hold on;
plot(time_iter([1, end]), [wind_inertial(2) wind_inertial(2)], 'g--')
ylabel('we [m/s]')
subplot(313)
plot(time_iter, wind_inertial_est(3,:)); hold on;
plot(time_iter([1, end]), [wind_inertial(3) wind_inertial(3)], 'g--')
ylabel('wd [m/s]')
xlabel('Time [sec]')

estimator_error = aircraft_state_est - aircraft_array;
figure(12);
subplot(311)
plot(time_iter, estimator_error(1,:),'b'); hold on;
title('Estimator Position Error')
ylabel('X Pos [m]')
subplot(312)
plot(time_iter, estimator_error(2,:)); hold on;
ylabel('Y Pos [m]')
subplot(313)
plot(time_iter, estimator_error(3,:)); hold on;
ylabel('Z Pos [m]')
xlabel('Time [sec]')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Animate aircraft flight
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (ANIMATE_FLAG)
    pause();
    %DefineDefaultAircraft
    DefineTTwistor

    for aa = 1:length(time_iter)
        DrawAircraft(time_iter(aa), aircraft_array(:,aa), pts);
    end

    AnimateSimulation(time_iter, aircraft_array')
end
