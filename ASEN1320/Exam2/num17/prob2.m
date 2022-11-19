close all; clear all; clc;

a = 9.9; %declares a equal to 9.9
b = 1.25; %declares b equal to 1.25
tspan = [0 3.5]; %sets tspan equal to between 0 and 3.5
y0 = 1; %sets the intial value of y equal to 1

f = @(t,y)func2(t,y,a,b); %declares a function handle f which calls func2 and allows t and y to change but holds a and b as constants

[y,t] = ode45(f,tspan,y0); %calls ode45 and outputs y and t

plot(y,t,'linewidth',2) %plots y vs t and sets the linewidth to 2
grid on; %turns the grid on

save('output2.mat',"t","y") %saves the variables from ode45 to an output file 
