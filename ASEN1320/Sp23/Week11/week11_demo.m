%% Clean Up
close all; clear; clc;

%% Function Handles
out1 = odeFun1(3,10);

%Function handle
funcHandle = @odeFun1;

out2 = funcHandle(3,10);

%Default inputs
t = 3;
y = 10;
funcHandle2 = @()odeFun1(t,y);
out3 = funcHandle2();

%% Ode45

tspan = [0 5];
y0 = 0;

%Call ode45
[TOUT, YOUT] = ode45(funcHandle, tspan, y0);

%Plot results
figure();
plot(TOUT, YOUT);

xlabel('Time (s)');
ylabel('Y');

%% 3D plotting
%3D line plot
z = 0:0.1:2*pi;
x1 = sin(z);
y1 = cos(z);

figure();
plot3(x1,y1,z);
grid on

title('3D plot');
xlabel('X');
ylabel('Y');
zlabel('Z');


%% Colorbar plotting
[X,Y]= meshgrid(1:0.5:10, 1:20);

Z = sin(X) + cos(Y);

figure();
surf(X,Y,Z);
colorbar

%Change colorbar plot
C = X .* Y;
figure();
surf(X,Y,Z,C);
colorbar

%Contour plot
figure();
contourf(X,Y,Z);
colorbar

%Contour plot 2
figure();
contourf(X,Y,C);
colorbar








