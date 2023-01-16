function elev_perturb = PitchAttitudeControl(theta_c, theta, q, kth, kq)

elev_perturb = (theta_c - theta)*kth - q*kq;