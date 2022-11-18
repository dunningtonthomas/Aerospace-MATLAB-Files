a = 9.9;
b = 1.25;

odefun = @(t, y) func2(t, y, a, b);

tspan = [0 3.5];
y0 = 1;
[tout, yout] = ode45(odefun, tspan, y0);

save('output.mat', 'tout', 'yout');

% Plot

plot(tout, yout, 'LineWidth',2);
grid on;