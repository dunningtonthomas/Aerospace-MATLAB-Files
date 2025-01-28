clc, clear, close all;

a = 11.2;
b = 1.2;
y0 = 0;
tspan = [0,6.5];
f = @(t,y)func2(t,y,a,b);

[tout,yout] = ode45(f,tspan,y0);

l = length(yout);
rate = zeros(l,1);
for c = 1:l
    rate(c) = f(tout(c),yout(c));
end

output = [tout rate yout];
writematrix(output,"output.csv")

figure()
subplot(2,2,[1 2])
plot(tout,rate)
title('Rate of Change')
ylabel('dy/dt')
xlabel('t')

subplot(2,2,[3 4])
plot(tout,yout)
title('Numerical Integration')
ylabel('y')
xlabel('t')
