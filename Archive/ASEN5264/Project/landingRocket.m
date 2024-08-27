%% Clean
close all; clear; clc;

%% 
func = @(x)(9.81/2 * x^2 + 50*x - 5000);
timpact = fzero(func, 2);

m = 3000.0;
h = 50.0;
I = (1.0/12.0)*m*(h^2);

mat = [1/I, -1/(50*I), -1/50^2; 1/I, -1/(5*I), -1/25];






%% Functions
function stateDot = EOM(t, state, u)
    % Control variables
    thrust = u(1); 
    torque = u(2);

    % States
    x = state(1);
    y = state(2);
    xDot = state(3);
    yDot = state(4);
    theta = state(5);
    thetaDot = state(6);


    % State = [x,y,xd,yd,theta,thetad]
    stateDot(1:2) = stateDot(3:4);
end