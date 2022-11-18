f = @func2;

tspan = [0:3.5];
y0 = 1;

[t,y] = ode45(f,tspan,y0);

[t,y] = a*sin(y*t)+b*y;

filename= "output2.mat";
MATF = readable("output2.mat");


xticks(0:0.5:3.5);
yticks(1:0.5:6);
grid on;
LS = LineSpec('b-');
plot(y,t,LS)




