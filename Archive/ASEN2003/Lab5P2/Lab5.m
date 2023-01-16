clc; clear all; close all;

%Declare constants
Kg = 33.3; % Total Gear Ratio
Km = .0401; %[Nm/amp] Motor Constant
Rm = 19.2; %[Ohms]

J_hub = .00051; %[Kgm^2] Base Inertia
J_extra = .2 * .2794^2; %[Kgm^2]
J_load = .0015; %[Kgm^2] Load inertia of bar
J = J_hub + J_extra + J_load; %[Kgm^2] Total Inertia

Ts = 1; %[s] Settling time

figure()
% xline(Ts);
xlabel('Time (s)')
ylabel('Displacement')
yline(1.05, 'HandleVisibility', 'off')
yline(.95, 'DisplayName', '5% Settling Time')
legend()
hold on
i=1;
ff = -6.314;
n = .2; %Step size
%Calculate laplace function
for Kp0 = 8%-2:n:12 %[rad] Proportional Gain 
   for Kd0 = 1.3%0:n:1.5 %[rad] Derivative Gain
        n1_ff = (Kp0 * Kg * Km / (J * Rm)) + ff; %Numerator with friction
        n1 = (Kp0 * Kg * Km / (J * Rm)); %Num without friction 
        d2 = 1;
        d1 = (Kg^2 * Km^2 / (J * Rm)) + (Kd0 * Kg * Km / (J * Rm));
        d0 = (Kp0 * Kg * Km / (J * Rm));
        %%% Closed Loop System
        num = n1;
        den = [d2 d1 d0];
        sysTF = tf(num,den);
        sysTF_ff = tf(n1_ff,den);
        %%% Step Response
        [x,t] = step(sysTF);
        [x_ff,t] = step(sysTF_ff);
        
        damp = (Kg^2 * Km^2) + (Kd0 * Kg * Km) / (2 * sqrt(Kp0 * Kg * Km * J * Rm));
        Mp = exp(-(damp * pi) / (sqrt(1 - damp^2))); %Maximum overshoot
        S = stepinfo(sysTF, 'SettlingTimeThreshold', .05); %Gather system properties such as overshoot and settling time
        if S.Overshoot < .2 && S.SettlingTime < Ts
            plot(t,x, 'DisplayName', sprintf('Kp = %d, Kd = %d ', Kp0, Kd0)) %Plot results
            hold on
            plot(t,x_ff, 'DisplayName', sprintf('Kp = %d, Kd = %d w/ Friction', Kp0, Kd0))
            hold on
%             xline(S.SettlingTime, 'DisplayName', 'Settling Time')
%             yline(1 + S.Overshoot, 'DisplayName', 'Overshoot')
            
            Overshoot(i) = S.Overshoot;
            KP(i) = Kp0;
            KD(i) = Kd0;
        end
        i = i+1;
   end
end
save('modelFric', 'x_ff');
index = find(KP);
KP = KP(index);
KD = KD(index);
Overshoot = Overshoot(index);