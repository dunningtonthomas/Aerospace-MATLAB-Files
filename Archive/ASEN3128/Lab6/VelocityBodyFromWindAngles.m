function vel_body = VelocityBodyFromWindAngles(wind_angles)

va = wind_angles(1);
beta = wind_angles(2);
alpha = wind_angles(3);

vel_body = va*[cos(beta)*cos(alpha); sin(beta); cos(beta)*sin(alpha)]; 