%% Clean Up
close all; clear; clc;

%% Predator Prey model

%Initial Conditions
x0 = 4;
y0 = 1;
i = 1;
j = 1;
m = 2;
startVec = [x0; y0; i; j; m];

%Create function handle
funcHandle = @(t, inVec)EOMfunc(t, inVec);

%Integrate with ode45
tspan = [0 10];
[tOut, yOut] = ode45(funcHandle, tspan, startVec);

%Rabbits and foxes
rabbits = yOut(:,1);
foxes = yOut(:,2);
iTot = yOut(:,3);
jTot = yOut(:,4);
mTot = yOut(:,5);

%Finding the time of maximum infant rabbits
[~, indTemp] = max(iTot);
timeMax = tOut(indTemp);

%New function handle
funcHand2 = @(t,inVec)EOMfuncRabbitDeath(t, inVec, timeMax);
[tOut2, yOut2] = ode45(funcHand2, tspan, startVec);

%Set infants to zero once the time is greater than the max time
%Rabbits and foxes
rabbits2 = yOut2(:,1);
foxes2 = yOut2(:,2);
iTot2 = yOut2(:,3);
jTot2 = yOut2(:,4);
mTot2 = yOut2(:,5);

tempLogVec = tOut2 >= timeMax;
iTot2(tempLogVec) = 0;



%% Plotting
figure();
set(0, 'defaulttextinterpreter', 'latex')
plot(rabbits, foxes, 'linewidth', 2', 'color', [0.5 0 0.5]);
grid on

xlabel('Rabbits');
ylabel('Foxes');
title('Foxes vs Rabbits');

figure();
plot(tOut, rabbits, 'linewidth', 2', 'color', 'b');
grid on

xlabel('Time (months)');
ylabel('Rabbits');
title('Rabbits vs Time');

figure();
plot(tOut, foxes, 'linewidth', 2', 'color', 'r');
grid on

xlabel('Time (months)');
ylabel('Foxes');
title('Foxes vs Time');


%% Plotting part 2
figure();
plot(tOut, iTot, 'linewidth', 2', 'color', rgb('light pink'));
hold on
grid on
plot(tOut, jTot, 'linewidth', 2', 'color', rgb('lavender'));
plot(tOut, mTot, 'linewidth', 2', 'color', rgb('baby blue'));

xlabel('Time (months)');
ylabel('Rabbits');
title('Rabbits vs Time');
legend('Infants', 'Juvenile', 'Mature');

%% Plotting part 3
figure();
plot(tOut2, iTot2, 'linewidth', 2', 'color', rgb('light pink'));
hold on
grid on
plot(tOut2, jTot2, 'linewidth', 2', 'color', rgb('lavender'));
plot(tOut2, mTot2, 'linewidth', 2', 'color', rgb('baby blue'));

xlabel('Time (months)');
ylabel('Rabbits');
title('Rabbits vs Time (Infant Death)');
legend('Infants', 'Juvenile', 'Mature');


%% Functions

function outVec = EOMfunc(t, inVec)

    %Constants
    a = 1;
    alpha = 0.5;
    c = 0.75;
    gamma = 0.25;

    %Get Variables
    x = inVec(1);
    y = inVec(2);
    i = inVec(3);
    j = inVec(4);
    m = inVec(5);

    %Define EOM
    dxdt = a*x - alpha*x*y;
    dydt = -c*y + gamma*x*y;
    didt = a*m - 0.4*log(2) / 0.5 * i - 0.6*log(2) / 0.5 * i;
    djdt = 0.6*log(2)/0.5 * i - 4*alpha*y*j - log(2)*j;
    dmdt = log(2)*j - alpha*y*m;

    %Vector
    outVec = [dxdt; dydt; didt; djdt; dmdt];
end


function outVec = EOMfuncRabbitDeath(t, inVec, maxTime)

    %Constants
    a = 1;
    alpha = 0.5;
    c = 0.75;
    gamma = 0.25;

    %Get Variables
    x = inVec(1);
    y = inVec(2);
    i = inVec(3);
    j = inVec(4);
    m = inVec(5);

    if(t >= maxTime) %Condition for rabbit death
        i = 0;
    end

    %Define EOM
    dxdt = a*x - alpha*x*y;
    dydt = -c*y + gamma*x*y;
    didt = a*m - 0.4*log(2) / 0.5 * i - 0.6*log(2) / 0.5 * i;
    djdt = 0.6*log(2)/0.5 * i - 4*alpha*y*j - log(2)*j;
    dmdt = log(2)*j - alpha*y*m;

    %Vector
    outVec = [dxdt; dydt; didt; djdt; dmdt];
end


