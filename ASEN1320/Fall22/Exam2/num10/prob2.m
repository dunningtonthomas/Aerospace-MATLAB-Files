close all; clear all; clc; 
%Function handle 
f = @func2; 

%Time span for integration 
tspan = [0 3.5]; 

%Initial value 
y0 = 1; 

%Ode45 integrating the rate of change 
[TOUT, ZOUT] = ode45(f, tspan, y0); 

%reating a vector that has each column of data from the ode45 vector
V = [TOUT, ZOUT]; 

%I didn't remember how to write the data out to a MAT file so I instead
%wrote the data out to a CSV file 
writematrix(V, "output2.csv"); 

%Here I plotted the Y output of the ode45 integration vs time =
plot(TOUT,ZOUT); 
grid on
