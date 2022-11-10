% Explain to students each step of using ode45 to solve 
% first order ODEs 

%%-------- Problem 1 ---------%%
% Initial state and time vector for integration
y0 = 1;
tspan = [0 5];

% Function handle for the equations of motion
EOM1 = @EOMprob1;

% Caaling ode45 function to solve our ODE
[timevector1, yvector] = ode45(EOM1,tspan,y0); % Spend some time here
                                               %explaining the required inputs 
                                               %and outputs for ode45

% Plotting results
figure(1)
subplot 211
plot(timevector1,yvector)
grid on 
title("Problem 1")

%%-------- Problem 2 ---------%%
% Initial state and time vector for integration
m = 2;
tspan = [0 5];
xstate_o = [3;-1];

% Function handle for the equations of motion
EOM2 = @(t,xstate)EOMprob2(t,xstate,m); % Explain which variables are considered as "default" and which are changing

% Caaling ode45 function to solve our ODE
[timevector2, xvector] = ode45(EOM2,tspan,xstate_o);

% Plotting results
subplot 212
plot(timevector2,xvector)
grid on 
title("Problem 2")
legend("x(1)","x(2)")


