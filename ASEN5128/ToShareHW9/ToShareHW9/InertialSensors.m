function inertial_sensors = InertialSensors(aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters, sensor_params)
%
% u = [aircraft_state; density; wind_inertial; total_force_body]
%
% inertial_sensors = [y_accel; y_gyro; y_pressure; y_dyn_pressure];
%

omega_body = aircraft_state(10:12,1);
%euler_angles = u(4:6,1);
roll = aircraft_state(4,1);
pitch = aircraft_state(5,1);

height = -aircraft_state(3,1);
density = stdatmo(height);

wind_body = TransformFromInertialToBody(wind_inertial, aircraft_state(4:6,1));
air_rel_body = aircraft_state(7:9,1) - wind_body;
wind_angles = AirRelativeVelocityVectorToWindAngles(air_rel_body);


[fa_body, ma_body] = AeroForcesAndMoments_BodyState_WindCoeffs(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);
Va = wind_angles(1);

%%% accelerometers
y_accel = fa_body/sensor_params.m + sensor_params.sig_accel*randn(3,1);

%%% rate gyros
y_gyro = omega_body + sensor_params.sig_gyro*randn(3,1);

%%% pressure
y_abs_pressure = density*sensor_params.g*(height-sensor_params.h_ground) + sensor_params.bias_abs_press + sensor_params.sig_abs_press*randn(1);

y_dyn_pressure = 0.5*density*Va*Va + sensor_params.bias_dyn_press + sensor_params.sig_dyn_press*randn(1);

inertial_sensors = [y_accel; y_gyro; y_abs_pressure; y_dyn_pressure];