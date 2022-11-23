close all;clear all;clc


tstep = linspace(0, 86400, 1440);%creates vector that will iterate every minute of a day

options = odeset('RelTol',1e-12,'AbsTol',1e-12);% sets relative and absolute error to 1X10^-12

EOM = @OrbitEOM;%function handle used in ode

%Sat1 (ISS) Initial Conditions
Sat1init(1) = 1986.2; %Xs1
Sat1init(2) = 6388.2; %Ys1
Sat1init(3) = -1237.2; %Zs1
Sat1init(4) = -4.93; %VXs1
Sat1init(5) = 0.40; %VYs1
Sat1init(6) = -5.83; %VZs1

%Sat2 (Hubble) Initial Conditions
Sat2init(1) = 6480.8; %Xs2
Sat2init(2) = 1108.2; %Ys2
Sat2init(3) = -2145.5; %Zs2
Sat2init(4) = -4.93; %VXs2
Sat2init(5) = 0.40; %VYs2
Sat2init(6) = -5.83; %VZs2

%creates matrix with 6 columns with X Y Z Vx Vy Vz data every minute of day
%using initial conditions inputted
[timesat1, Sat1Position] = ode45(EOM,tstep,Sat1init);
[timesat2, Sat2Position] = ode45(EOM,tstep,Sat2init);

% outputs position data into csv file
writematrix(Sat1Position,"Sat1Position.csv")
writematrix(Sat2Position,"Sat2Position.csv")


figure('Name',"Part1") %creates name for figure

plot3(Sat1Position(:,1),Sat1Position(:,2),Sat1Position(:,3))%creates 3d plot for sat1
hold on %keeps sat 2 on the same plot
plot3(Sat2Position(:,1),Sat2Position(:,2),Sat2Position(:,3))%adds sat2 to the plot

grid on

xlabel("X","FontSize",14) %FontSize option set to 14 to improve visibility and clarity
ylabel("Y","FontSize",14)
zlabel("Z","FontSize",14)
title("Orbits of ISS and Hubble Telescope during 1 day","FontSize",14)
legend({'ISS','Hubble Telescope'},'FontSize',14,'Location','southeast')%creates legend and moves it to a better position(bottom right)
savefig("part1.fig")%saves the plot as a .fig file 
