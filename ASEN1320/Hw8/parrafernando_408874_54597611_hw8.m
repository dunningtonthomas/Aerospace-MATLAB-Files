%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%                      ASEN 1320: Homework 8                           %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% =======Close all files, clear workspace, clear command window.==========
close all; clear all; clc;

% ========================= VARIABLE DECLARATION =========================
R = 287;                        %Specific gas constant of air (R) J/(kg*K).
gamma = 1.4;                    %Specific heat ratio of air (γ, gamma).
VehicleNumber = 1:6; 
Temp = [-56 15 24 -56 17 -56];  %Vector for Temp.[T1:T6]in ⁰C
VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5]; %[VS1:VS6] in m/s

% ============================== ANALYSIS ================================
TempK = Temp + 273.15;                  %Vector for Temp.[T1:T6]in Kelvin
SoundSpeed = sqrt(gamma .* R .* TempK);   %Equation for speed of sound 
MachNumber = VehicleSpeed ./ SoundSpeed; %Ratio of the speed of an aircraft 
                                        % to the speed of sound
Regimes = ["Incompressible" "Subsonic" "Sonic" ...  
          "Transonic" "Supersonic" "Hypersonic"];  
        %-------------------------------------------------
        %       Mach Number     ||      Regime
        %-------------------------------------------------
        %       M < 0.3         ||      Incompressible
        %       0.3 ≤ M < 0.8   ||      Subsonic
        %       0.8 ≤ M < 1.2   ||      Transonic
        %       M = 1           ||      Sonic 
        %       1.2 ≤ M < 5     ||      Supersonic
        %       M > 5           ||      Hypersonic

        % **Note: Sonic Regime ~(1 − 𝜀) ≤ 𝑀 ≤ (1 + 𝜀); 𝜀 = 0.001**
%-------------------------------------------------------------------------

for i = 1 : length(MachNumber)

    if (MachNumber(i) < 0.3)
        stringVar = Regimes(1);
    elseif (MachNumber(i) >= 0.3) && (MachNumber(i) < 0.8)
        stringVar = Regimes(2);
    elseif (MachNumber(i) >= (1-0.001)) && (MachNumber(i) <= (1+0.001))
        stringVar = Regimes(3);
    elseif (MachNumber(i) >= 0.8) && (MachNumber(i) < 1.2)
        stringVar = Regimes(4);
    elseif (MachNumber(i) >= 1.2) && (MachNumber(i) < 5)
        stringVar = Regimes(5); 
    elseif (MachNumber(i) > 5)
        stringVar = Regimes(6);
    else 
        disp("Error: N/A")
    end
%-----------------------Print Command-------------------------------------
    fprintf("Vehicle %0.0f has a Mach = %.02g (%s)\n", VehicleNumber(i),...
            MachNumber(i), stringVar)
end
%-------------------------------------------------------------------------


