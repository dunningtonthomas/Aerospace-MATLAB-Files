close all; clear; clc;
t0 = input('t0 = ');            %inputing variables
vx = input('vx = ');
vy = input('vy = ');
x = input('x = ');
y = input('y = ');
g = 9.81;
f = @quadratic;                 %creating function handle

tg = calcImpact(t0,y,vy,f,g);                       %calling calcimpact function
[xt,yt] = calcTrajectory(t0,tg,x,y,vx,vy,g);        %calling calcTrajectory function

plot(xt,yt,'blue-')                             %plotting 
xlabel('Horizontal Position (m)')
ylabel('Vertical Position (m)')
title('Objects Trajectory during Free Fall')
grid on