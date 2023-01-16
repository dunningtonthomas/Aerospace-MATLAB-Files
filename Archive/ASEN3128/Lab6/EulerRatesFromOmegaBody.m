function euler_rates = EulerRatesFromOmegaBody(omega_body, euler_angles)

transform_matrix = [1, sin(euler_angles(1))*tan(euler_angles(2)), cos(euler_angles(1))*tan(euler_angles(2));...
                    0, cos(euler_angles(1)), -sin(euler_angles(1));...
                    0, sin(euler_angles(1))*sec(euler_angles(2)), cos(euler_angles(1))*sec(euler_angles(2))];
                
euler_rates = transform_matrix * omega_body;