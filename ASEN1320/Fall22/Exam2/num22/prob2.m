%clearing comand window
close all;clear all;clc
%declaring my variables given
a = 9.9;
b = 1.25;
tspan = [0 3.5];
y0 = 1;

%creating function handel
f = @(t, y)funct2(t , y , a , b);

%calling ode function

[t,y] = ode45(f, tspan, y0);
dydt = [t, y];
%saving an output matrix to output my variables of the ode45 (t and y).
save('output2.mat', 't','y');
%plotting the function
plot (t,y, 'linewidth', 2);
%turning the grid on 
grid ON;

