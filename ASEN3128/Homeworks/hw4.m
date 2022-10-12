%% Clean
close all; clear; clc;


%% Plotting it vs h

itFunc = @(x)(-8.0667834*x + 4.3339);

hVals = linspace(0,1,100);



%% Plotting
figure();
set(0,'defaulttextinterpreter', 'latex');
plot(hVals, itFunc(hVals), 'linewidth', 2);

xline(0.561, '-', 'color', 'r', 'linewidth', 2, 'label', 'Max CG Location Limit');
yline(-0.176, '-', 'color', 'r', 'linewidth', 2, 'label', 'Min Tail Incidence Angle Limit');

xlabel('CG Location (m/m)');
ylabel('Tail Incidence Angle ($$^\circ$$)');

legend('Tail Angle Incidence vs CG Location', 'location', 'NW');
title('$$i_{t}$$ vs $$h$$');

