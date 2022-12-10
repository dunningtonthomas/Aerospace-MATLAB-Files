clear; close all; clc;


sat1init = [1986.2; 6388.2; -1237.2; -4.93; 0.4; -5.83];
sat2init = [6840.8; 1108.2; -2145.5; -0.29; 7.07; 2.75];

tspan = 0:60:86400;

f = @OrbitEOM;

options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t1, sat1] = ode45(f, tspan, sat1init, options);
[t2, sat2] = ode45(f, tspan, sat2init, options);

sat1Position = [sat1(:, 1), sat1(:,2), sat1(:, 3)]; %iss position
sat2Position = [sat2(:, 1), sat2(:,2), sat2(:, 3)]; %hubble position

writematrix(sat1Position, "Sat1Position.csv");
writematrix(sat2Position, "Sat2Position.csv");

sat1Viss = readmatrix("Sat1Visibility.csv");
sat2Viss = readmatrix("Sat2Visibility.csv");


sat1Vis(:,1) = sat1Viss .* sat1Position(:,1);
sat1Vis(:,2) = sat1Viss .* sat1Position(:,2);
sat1Vis(:,3) = sat1Viss .* sat1Position(:,3);

sat2Vis(:,1) = sat2Viss .* sat2Position(:,1);
sat2Vis(:,2) = sat2Viss .* sat2Position(:,2);
sat2Vis(:,3) = sat2Viss .* sat2Position(:,3);

GSPosition = readmatrix( "GSPosition.csv");

plot3(sat1Position(:,1), sat1Position(:,2), sat1Position(:,3), "k-");
hold on
plot3(sat2Position(:,1), sat2Position(:,2), sat2Position(:,3), "b-");
plot3(GSPosition(:,1), GSPosition(:,2), GSPosition(:,3), "g-");
plot3(sat1Vis(:,1), sat1Vis(:,2), sat1Vis(:,3), "g*");
fig = plot3(sat2Vis(:,1), sat2Vis(:,2), sat2Vis(:,3), "g*");
xlabel("x")
ylabel("y")
zlabel("z")
title("ISS and Hubble Orbit")
legend("ISS", "Hubble", "Ground Station", "Visibility points")
saveas(fig, "part3.fig")
% 
% F(1441) = struct('cdata',[],'colormap',[]);
% 
% h.Visible = 'off';
% for i = 1:1441   
%     plot3(sat1Position(i,1), sat1Position(i,2), sat1Position(i,3), "k.");
%     hold on
%     plot3(sat2Position(i,1), sat2Position(i,2), sat2Position(i,3), "b.");
%     plot3(GSPosition(i,1), GSPosition(i,2), GSPosition(i,3), "g.");
%     plot3(sat1Vis(i,1), sat1Vis(i,2), sat1Vis(i,3), "g*");
%     plot3(sat2Vis(i,1), sat2Vis(i,2), sat2Vis(i,3), "g*");
%     xlabel("x")
%     ylabel("y")
%     zlabel("z")
%     title("ISS and Hubble Orbit")
%     legend("ISS", "Hubble", "Ground Station", "Visibility points")
%     F(i) = getframe;
% end
% M = movie(F, 1, 100)
% saveas(M, "FinalMovie.")
