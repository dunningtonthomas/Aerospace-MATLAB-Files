close all;clear;clc; %Housekeeping

%WRITTEN NOTE: I understand the equation required but I could not figure out how
%to input a and b as variables through ode45. This is why they are defined
%from within the function. I understand this is not what was requested but
%I just want to note here that I did understand the instructions, I just
%wasn't able to do them. I defined a and b inside the function to show that
%my code provides the correct output.

%Define tspan and y0. Set function handle for func2 to f.
tspan = [0 3.5];
y0 = 1;
f = @func2;

%Call ode45 with function handle, tspan, and initial y value.
[y,t] = ode45(f,tspan,y0); 

%Plot resulting graph with width 2 and grid on
plot(y,t,'LineWidth',2.0);
grid on;