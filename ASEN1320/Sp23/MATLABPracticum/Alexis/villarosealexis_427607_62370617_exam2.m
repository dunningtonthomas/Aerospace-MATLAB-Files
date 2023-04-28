clc, clear, clear all;
a = 11.2;
b = 1.2;
tspan = [0 6.5]; 
y0 = 0; 
F = @(t,y)func2(t,y,a,b);
[tyout, yout] = ode45(F,tspan,y0);

figure();
plot(yout,tspan);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');

figure();
plot(tout,tspan);
xlabel('t');
ylable('y');
title('Numerical Intergation');

matrix = [tspan; tyout;yout ];
writematrix(matirx , "output.csv");
