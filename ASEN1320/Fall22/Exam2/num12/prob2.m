close all; clear all; clc; 

a = 9.9;
b = 1.25;  
tspan = [0 3.5]; 
y0 = 1; 

f = @(t, y)func2(t, y, a, b);

[t, y] = ode45(f, tspan, y0);


save output2.mat


plot(t,y, 'LineWidth', 2);
grid on; 




  

 