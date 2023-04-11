%% Project Part 1
clear; close all; clc;

load('all_init_conditions.mat');

init_1 = all_init_conditions(:,1);



dt = 0.2;
endTime = 0.2;

while true
    tspan = 0:dt:endTime;
    [tout, yout] = ode45(funcHandle, tspan, init_1);
    h = yout(:,3);
    hf = h(end);
    if(hf < 0.1)
        break;
    else
        endTime = endTime + 0.2;
    end
end






