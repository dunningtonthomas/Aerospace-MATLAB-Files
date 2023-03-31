%% Clean Up
close all; clear; clc;

%% Integration

%Declaring function handles
func1 = @EOM1;
func2 = @EOM2;

%Time span
tspan = [0 5];

%Initial Conditions
y0 = 1;
initState = [3; -1];

%Calling ode45
[tOut1, yOut] = ode45(func1, tspan, y0);
[tOut2, stateOut] = ode45(func2, tspan, initState);

%% Plotting
%Problem 1
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot(tOut1, yOut, 'linewidth', 2);

xlabel('Time (s)');
ylabel('Output');
title('Problem 1');

%Problem 2
figure();
plot(tOut2, stateOut(:,1), 'linewidth', 2);
hold on
plot(tOut2, stateOut(:,2), 'linewidth', 2);

xlabel('Time (s)');
ylabel('Output');
legend('x1', 'x2', 'location', 'nw');
title('Problem 2');


%% Functions

function dydt = EOM1(t, y)
    dydt = -t*y / sqrt(2 - y^2);
end

function outVec = EOM2(t, state)
    x1 = state(1);
    x2 = state(2);
    
    dx1dt = x2;
    dx2dt = 0.5*(5 + x1^2 - x2*exp(x1));
    
    outVec = [dx1dt; dx2dt];
end