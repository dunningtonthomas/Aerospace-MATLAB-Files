function sensor_params = SensorParametersTtwistor(aircraft_parameters)

sensor_params.Ts_imu = 0.1;
sensor_params.Ts_gps = 1;

sensor_params.g = aircraft_parameters.g;
sensor_params.m = aircraft_parameters.m;


%%% accelerometer
sensor_params.sig_accel = 0.0025*sensor_params.g; %ADXL325 results in ?accel,? = 0.0025g

%%% rate gyro
sensor_params.sig_gyro = 0.13*pi/180; %[rad/s] ADXRS540 results in ?gyro,? = 0.13 deg/s.

%%% absolute pressure
sensor_params.h_ground = 1655;
sensor_params.bias_abs_press = 0.125; % [kPa]Freescale Semiconductor MP3H6115A
sensor_params.sig_abs_press = 0.01; % [kPa] Freescale Semiconductor MP3H6115A

%%% dynamic pressure
sensor_params.bias_dyn_press = 0.02; % [kPa]Freescale Semiconductor MPXV5004G
sensor_params.sig_dyn_press = 0.002; % [kPa] Freescale Semiconductor MPXV5004G

%%% gsp sensor
sensor_params.sig_gps = [0.21; 0.21; 0.4]; % [m]
sensor_params.k_gps = 1/1100;
sensor_params.k_gps_exp = exp(-sensor_params.Ts_gps*sensor_params.k_gps);
sensor_params.sig_gps_v = 0.01; % [m/s]