clc, clear, close all;
tspan= 0:6.5;
y0=0;
y = [-0.2 -0.1 0 0.1 0.2 0.3 0.4];
for t= 0:100:6.5
    f= @(t,y)func2(t,y);
    [x,dydt] = ode45(f, tspan, y0);
    m(:,1)=t;
    m(:,2)=dydt(t);
    m(:,3)=y(t);
end

figure(1);
plot(x,dydt);
xlabel('t');
ylabel('dy/dt');
title('Rate of Change');

figure(2);
plot(t,func2(t,y));
xlabel('t');
ylabel('y');
title('Numerical Integration');

save('output.csv',m);
