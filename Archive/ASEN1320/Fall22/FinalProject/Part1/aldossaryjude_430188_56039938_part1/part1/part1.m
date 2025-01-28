clear;clc;close all;

%Declaring Variables
Sat0i_1 = [1986.2;6388.2;-1237.2;-4.93;0.40;-5.83];
Sat0i_2 = [6480.8;1108.2;-2145.5;-0.29;7.07;2.75];
tspan = 0:60:86400;
option = odeset('RelTol',1e-12,'AbsTol',1e-12); 

%Creating Function Handles
f=@OrbitEOM;

%Computing Ode45 twice for both orbits
[~,Sat0_1] = ode45(f,tspan,Sat0i_1,option);
[~,Sat0_2] = ode45(f,tspan,Sat0i_2,option);

%Saving Ode45 outputs in a matrix
Sat_1=Sat0_1(:,1:3);
Sat_2=Sat0_2(:,1:3);

%Exporting Ode45 output into a csv file
writematrix(Sat_1,'Sat1Position.csv')
writematrix(Sat_2,'Sat2Position.csv')

%Plotting the orbits
plot3(Sat_1(:,1),Sat_1(:,2),Sat_1(:,3));
hold on
plot3(Sat_2(:,1),Sat_2(:,2),Sat_2(:,3));
axis equal;
xlabel('x_s')
ylabel('y_s')
zlabel('z_s')
legend('Sat_1',"Sat_2")
grid on;