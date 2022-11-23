close all; clear all; clc;

R_s1 = [1986.2 6388.2 -1237.2 -4.93 0.40 -5.83];
R_s2 = [6480.8 1108.2 -2145.5 -0.29 7.07 2.75];

t = zeros(1,round(86400 /60));

for i = 2:length(t)+1

    t(i) = t(i-1) + 60;
end

ode_settings = odeset("RelTol", 1*10^(-12) , "AbsTol", 1 * 10^(-12));

[t1 , Sat1] = ode45(@OrbitEOM , t , R_s1, ode_settings);
[t2 , Sat2] = ode45(@OrbitEOM , t , R_s2, ode_settings);

Sat1Position = Sat1(: , [1 2 3]);
Sat2Position = Sat2(: , [1 2 3]);

writematrix(Sat1Position , "Sat1Position.csv");
writematrix(Sat2Position , "Sat2Position.csv");

plot3(Sat1Position(:, 1) , Sat1Position(:, 2), Sat1Position(:, 3), "-k" , Sat2Position(:, 1) , Sat2Position(:, 2), Sat2Position(:, 3), "-r"  )
xlabel("X (kilometers)");
ylabel("Y (kilometers)");
zlabel("Z (kilometers)");
title("Orbits or Satilights 1 and 2");
savefig( 'part1.fig');
