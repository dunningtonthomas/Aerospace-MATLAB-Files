close all; clear all; clc;

a = pi /4;

x0 = 0;
x1 = x0 + 1;
x2 = x0 + 3;
x3 = x0 - 0.6; 

f = @(x)func2(x, a);

z1 = fzero(f, x1); 
z2 = fzero(f, x2); 
z3 = fzero(f, x3); 

fplot(f, [-5 5]); 
hold on;
plot(z1, 0, 'r*');
plot(z2, 0, 'r*');
plot(z3, 0, 'r*');
ylim([-20 30]);
xlim([-2 5])
grid on; 
hold off; 
