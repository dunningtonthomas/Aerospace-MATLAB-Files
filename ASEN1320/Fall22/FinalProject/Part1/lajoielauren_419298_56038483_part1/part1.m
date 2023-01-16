%Final Project Part 1
clear; close all; clc

%creating the time vector 
%times between 1 and 86400 with increment by 60
tspan = 0:60:86400;

%creating Sat1 and Sat2 initial vectors
Sat1_init = [1986.2; 6388.2; -1237.2; -4.93; 0.40; -5.83];
            %Xs1      Ys1     Zs1     VXs1    VYs1   VZs1
Sat2_init = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];
            %Xs2      Ys2     Zs2     VXs2    VYs2   VZs2

%creating function handle for the orbitEOM function
orbit = @OrbitEOM;

%setting the absolute and relative tolerance
options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12);

%calling ode45 and passing in function handle, time vector, intial vector
%and the tolerance 
[tsol1, ysol1] = ode45(orbit, tspan, Sat1_init, options);
[tsol2, ysol2] = ode45(orbit, tspan, Sat2_init, options);

%assigning the calues calculated in ode45 to a new matrix
sat1 = ysol1(:,(1:6));
sat2 = ysol2(:,(1:6));

%assigning the position values (columns 1 to 3) to a position vector
Sat1Position = sat1(:,(1:3));
Sat2Position = sat2(:,(1:3));

%writing the position vector of Sat1 and Sat2 to csv files
writematrix(Sat1Position, 'Sat1Position.csv');
writematrix(Sat2Position, 'Sat2Position.csv');

%declaring the x y and z values of the position vectors
x1 = Sat1Position(:,1);
y1 = Sat1Position(:,2);
z1 = Sat1Position(:,3);

x2 = Sat2Position(:,1);
y2 = Sat2Position(:,2);
z2 = Sat2Position(:,3);

%plotting the satelites' positions on a 3d plot
plot3(x1,y1,z1,"b-",x2,y2,z2,"m-")
%labeling the axises and adding a title
xlabel('X Position(km)')
ylabel('Y position(km)')
zlabel('Z Position(km)')
title('Position of ISS and Hubble Over 1 Day')
%adding a legend
legend("ISS", "Hubble", 'location', 'best')
%turning grid on
grid on