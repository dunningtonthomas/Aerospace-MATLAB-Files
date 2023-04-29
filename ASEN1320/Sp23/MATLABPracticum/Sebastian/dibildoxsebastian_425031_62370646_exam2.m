clc, clear, close all;

%% new line
a=11.2;
b=1.2;
t=0:6.5;
time=linspace(0,6.5,100);
y=0;

tvec=linspace(0,6.5,100);




f2 = @(t,y)func2(t,y,a,b);
[tout,yout] = ode45(f2,time,0);

[dyres]=f2(time,y);


plot(time,dyres)
title("Rate of Change")
xlabel("t")
ylabel("dy/dt")

%make a new graph

plot(tout,yout)
title("Numerical Integration")
xlabel("t")
ylabel("y")

m=[tout, dyres',yout]

dlmwrite("output",m)

