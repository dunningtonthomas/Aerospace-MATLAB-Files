%% Clean Up
close all; clear; clc;

%% Function Handles

% Calling odeFun1
out1 = odeFun1(3,10);

% Now let's make a function handle for it
% Notice the value in the workspace
% This is function the equivalent of saying that variable a = b, but you use
% the @ symbol for functions
funcHandle = @odeFun1;

% Same output! Notice how in the workspace out1 and out2 are identical
out2 = funcHandle(3,10);

% You can define default inputs
t = 3;
y = 10;
funcHandle_2 = @()odeFun1(t,y);
out3 = funcHandle_2();
%Notice how out3 is the same as out1 and out2 but includes the 
%default inputs and no inputs in the function call


%% Ode45
% function should have the format (t,z)
% the initial values need to be a COLUMN vector

%Declare time span and initial conditions
tspan = [0 5];
init = 0;

%Calling ode45
[TOUT,YOUT] = ode45(funcHandle,tspan,init);

%Plot results versus time
figure();
plot(TOUT, YOUT);

xlabel('Time (s)');
ylabel('Y');

%Create function handle for EOM function with a state vector
funcHandle_3 = @odeFun2;

%Time span and initial conditions
tspan = [0 5];
initState = [2; 4];

%Calling ode45
[TOUT2,STATEOUT] = ode45(funcHandle_3,tspan,initState);
%The first column of STATEOUT is x1 and the second is x2

%Plotting results
figure();
plot(TOUT2, STATEOUT(:,1)); %First column is x1
hold on
plot(TOUT2, STATEOUT(:,2)); %Second column is x2

xlabel('Time (s)');
ylabel('Output');
legend('x1', 'x2');


%% 3D Plotting
z = 0:0.1:2*pi;
x1 = sin(z);
y1 = cos(z);

figure();
plot3(x1,y1,z)
grid on

title('3D Plot')
xlabel('x values')
ylabel('y values')
zlabel('z values') % new axis - same labeling strategy


%% Colorbar plotting
%Surface plot
%Creating meshgrid
[X,Y] = meshgrid(1:0.5:10,1:20);

%Defining function z = f(x,y)
Z = sin(X) + cos(Y);
figure();
surf(X,Y,Z)
colorbar

%Change the colorbar plot
C = X .* Y;
figure();
surf(X,Y,Z,C);
colorbar

%Contour plot
figure();
contourf(X,Y,Z);
colorbar

%Other contour plot
figure();
contourf(X,Y,C);
colorbar;





