clc; clear; close all;
a=11.2;
b=1.2;
dy= @(t,y)func2(t, y, a ,b);
tspan= linspace(0,6.5);
y0=0;

[odetspan, integratedy]= ode45(dy, tspan, y0);
roc= dy(odetspan,integratedy);


figure(1)
plot(tspan, integratedy, 'b') %plot of num integration
title('Numerical Integration')
ylabel('y')
xlabel('t')

figure(2)
plot(odetspan, roc) %plot rate of change
title('Rate of Change')
ylabel('dy/dt')
xlabel('t')

output= zeros(100,3);
output(:,1)= odetspan;
output(:,2)= roc;
output(:,3)= integratedy;

writematrix(output, "output.csv")