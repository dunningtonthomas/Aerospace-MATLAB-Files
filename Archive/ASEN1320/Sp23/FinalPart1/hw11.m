%% House Keeping
clear all;
clc;
close all;

load("all_init_conditions.mat")

%% Config

isp = 255;                                  % Specific Impulse of the Lander's engine
gMoon = 1.6;                                % Moon's Gravity (m/s^2)

dt = 0.2;                                   % Dt (secs)

nInit = length(all_init_conditions(1,:));   % Number of initial conditions
odeOptions = odeset('RelTol', 1E-10);       % Ode45 setting, set rel Tol to 1e-10       

EOMGravityTurn  = @(t,z) GravityTurnEOM(t,z,gMoon,isp);

%% we can test these to make sure students did the runs
EndTime = dt*ones(1,nInit);
AltitudeScore = zeros(1,nInit);
VelocityScore = zeros(1,nInit);
GammaScore = zeros(1,nInit);
TotalScore = zeros(1,nInit);

%% Run all Initial Conditions. Calculate the scores. (Zero if hard constraint is violated)
for i  = 1:nInit
    
    disp(sprintf("Running %d initial conditions",i));
    curr_init_condition = all_init_conditions(:,i);
    while true

        [time,y] = ode45(EOMGravityTurn,0:dt:EndTime(i),curr_init_condition,odeOptions);
    
        curr_h = y(:,3);
        
        % Break if lander touches ground, else increment by dt
        if curr_h(end) < 0.1
            break;
        else
            EndTime(i)  = EndTime(i) + dt;
        end
     
    end

    curr_final_states = y(end,:);         % Final States
    vf = curr_final_states(1);            % Final Velocity         
    gf = curr_final_states(2);            % Final Gamma
    hf = curr_final_states(3);            % Final Altitude
        
    if vf > 1
        disp(sprintf("%d Intial Condition is not valid. V >1\n",i))
        continue;
    elseif ( abs(90+rad2deg(gf)) > 5 )
        disp(sprintf("%d Intial Condition is not valid. Gamma not between -85 and -95 deg\n",i))
        continue;
    end

    AltitudeScore(i) = (1-hf)*100;
    VelocityScore(i) = (1 - abs(vf/2))*200;
    GammaScore(i) = (1 - abs(pi/2+gf))*200;

    TotalScore(i) = AltitudeScore(i) + VelocityScore(i) + GammaScore(i);

    disp(sprintf("Total Gravity turn time for %d initial conditions = %f sec",i,EndTime(i)));
    disp(sprintf("Altitude Score = %f; Velocity Score = %f; Gamma Score = %f; Total Score = %f\n", ...
         AltitudeScore(i),VelocityScore(i),GammaScore(i),TotalScore(i)));

end

%% Choose the Initial Condition with the best score

% We can test these?

[max_score, idx] = max(TotalScore);
BestAltitudeScore = AltitudeScore(idx);
BestVelocityScore = VelocityScore(idx);
BestGammaScore = GammaScore(idx);
BestTotalScore = TotalScore(idx);

%% Simulate the best Gravity turn condition
% we can test best test

[time,BestStates] = ode45(EOMGravityTurn,0:dt:EndTime(idx),all_init_conditions(:,idx),odeOptions);

disp(sprintf("Best Altitude Score = %f; Best Velocity Score = %f; Best Gamma Score = %f; Best Total Score = %f\n", ...
         BestAltitudeScore,BestVelocityScore,BestGammaScore,BestTotalScore));

%% Plot

figure

subplot(1,3,1)
plot(time,BestStates(:,1))
title("Velocity vs Time")
xlabel("Time (sec)")
ylabel("Velocity (m/s)")

subplot(1,3,2)
plot(time,BestStates(:,2))
title("Flight Path Angle vs Time")
xlabel("Time (sec)")
ylabel("Flight Path Angle (rad)")

subplot(1,3,3)
plot(time,BestStates(:,3))
title("Altitude vs Time")
xlabel("Time (sec)")
ylabel("Altitude (m)")