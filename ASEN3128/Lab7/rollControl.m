function aileron_perturb = rollControl(phi_c, phi, p, ka, kp)

aileron_perturb = ka*(kp*(phi_c - phi) - p);