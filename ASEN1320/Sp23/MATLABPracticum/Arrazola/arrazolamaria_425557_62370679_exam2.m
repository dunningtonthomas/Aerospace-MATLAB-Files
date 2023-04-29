clc, clear, close all;
a=11.2;
b=1.2;
y0=0;
t=[0, 6.5];
dydt=@(t,y,a,b)func2(t,y,a,b);
% f1= dydt(t,y,a,b);

[t1,y1]= ode45(dydt,t,y0);
[t2,y2]=ode45(dydt,t,y0(2));

plot(t1, y1,'LineWidth',2)
title('Rate of change')
xlable('t')
ylabel('dy/dt')

plot(t2, y2,'LineWidth',2)
title('Numerical Integration')
xlable('t')
ylabel('y')
