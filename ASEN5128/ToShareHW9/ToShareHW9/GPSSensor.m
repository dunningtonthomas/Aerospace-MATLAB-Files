function gps_sensor = GPSSensor(aircraft_state, sensor_params)
%
% u = [aircraft_state; density; wind_inertial; total_force_body]
%
% gps_sensors = [pn; pe; ph; Vg; chi];
%
persistent gps_noise;

if(isempty(gps_noise))
    gps_noise = [0;0;0];
end

%%% position
gps_noise = sensor_params.k_gps_exp*gps_noise + [sensor_params.sig_gps(1)*randn(1);sensor_params.sig_gps(2)*randn(1);sensor_params.sig_gps(3)*randn(1)];

pn = aircraft_state(1,1) + gps_noise(1);
pe = aircraft_state(2,1) + gps_noise(2);
ph = -aircraft_state(3,1) + gps_noise(3);

%%% velocity
flight_path_angles = FlightPathAnglesFromState(aircraft_state);

Vg = flight_path_angles(1) + sensor_params.sig_gps_v*randn(1);
chi = flight_path_angles(2) + sensor_params.sig_gps_v*randn(1)/Vg;

gps_sensor = [pn; pe; ph; Vg; chi];

