%% Clean Up
clear; close all; clc;

%% Problem 1
y0 = 1;
tSpan = [0 5];
g = 9.81;

odeFunc1 = @(t,y)diffEq1(t,y);

[TOUT1, YOUT1] = ode45(odeFunc1, tSpan, y0);

figure();
plot(TOUT1, YOUT1);


%% Problem 2
x1_0 = 3;
x2_0 = -1;
initState = [x1_0; x2_0];
m = 2;
tSpan = [0 5];

odeFunc2 = @(t, stateVec)diffEq2(t, stateVec, m);

[TOUT2, YOUT2] = ode45(odeFunc2, tSpan, initState);

figure();
plot(TOUT2, YOUT2(:,1));
hold on
plot(TOUT2, YOUT2(:,2));

legend('X1', 'X2');

figure();
plot(YOUT2(:,1), YOUT2(:,2));


