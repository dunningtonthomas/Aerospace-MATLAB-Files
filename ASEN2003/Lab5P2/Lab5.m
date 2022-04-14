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
xline(Ts);
xlabel('Time (s)')
ylabel('Displacement')
legend()
hold on
i=1;
n = .7; %Step size
%Calculate laplace function
for Kp0 = -2:n:50 %[rad] Proportional Gain 
   for Kd0 = -1.5:n:1.5 %[rad] Derivative Gain
        n1 = Kp0 * Kg * Km / (J * Rm); %Numerator
        d2 = 1;
        d1 = (Kg^2 * Km^2 / (J * Rm)) + (Kd0 * Kg * Km / (J * Rm));
        d0 = (Kp0 * Kg * Km / (J * Rm));
        %%% Closed Loop System
        num = n1;
        den = [d2 d1 d0];
        sysTF = tf(num,den);
        %%% Step Response
        [x,t] = step(sysTF);
        S = stepinfo(sysTF);
        
        damp = (Kg^2 * Km^2) + (Kd0 * Kg * Km) / (2 * sqrt(Kp0 * Kg * Km * J * Rm));
        Mp = exp(-(damp * pi) / (sqrt(1 - damp^2))); %Maximum overshoot
        if Mp < .2 && max(t) < Ts
            plot(t,x, 'DisplayName', sprintf('Kp = %d, Kd = %d', Kp0, Kd0)) %Plot results
            hold on
            
            KP(i) = Kp0;
            KD(i) = Kd0;
        end
        i = i+1;
   end
end

index = find(KP);
KP = KP(index);
KD = KD(index);