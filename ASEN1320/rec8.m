close all; clear all; clc;

% ========================= VARIABLE DECLARATION =========================
gamma = 1.4;        % [-] Specific heat ratio
R     = 287.0;      % [J/kg*K] specific gas constant of air
eps    = 0.001;
Regimes      = ["Incompressible","Subsonic","Sonic","Transonic","Supersonic","Hypersonic"];
Vehicles     = ["Concord","Bell X-1","UH-60","U-2","X-51","A380-800"];

% TEST CASE for students
Temp         = [-56,    15,   -24];
VehicleSpeed = [ 350, 180, 450];

% Homework Solution
%Temp         = [-56,    15,   -24,  -56,    17,    -56];
%VehicleSpeed = [ 599.5, 340.3, 78.2, 212.3, 1743.5, 262.5];
%FlowRegime  = ("");
% ============================== ANALYSIS ================================

% Convert Temperatures from [C] -> [K]
Temp = Temp + 273.15;

% Calculate Speed of Sound 
SoundSpeed = sqrt(gamma*R*Temp);

% Calculate Mach Number
MachNumber = VehicleSpeed ./ SoundSpeed;

% Loop through each vehicle to determine the Mach Number
for i = 1:length(Temp)
    % Determine the regime using an if-statement
    if (MachNumber(i) < 0.3)
    FlowRegime(i) = Regimes(1);        % Incompressible

    elseif (MachNumber(i) >= 0.3 && MachNumber(i) < 0.8)
        FlowRegime(i) = Regimes(2);       % Subsonic

    elseif (MachNumber(i) <= 1 + eps && MachNumber(i) >= 1 - eps)
        FlowRegime(i) = Regimes(3);

    elseif (MachNumber(i) >= 0.8 && MachNumber(i) < 1.2 && MachNumber(i) ~= 1)
        FlowRegime(i) = Regimes(4);       % Transonic

    elseif (MachNumber(i) >= 1.2 && MachNumber(i) < 5)
        FlowRegime(i) = Regimes(5);       % Supersonic

    else
        FlowRegime(i) = Regimes(6);       % Hypersonic
    end

    % Display results
    fprintf("Vehicle %g has a Mach = %0.2g (%s)\n" ,i, MachNumber(i), FlowRegime(i));

end

%% 
% Reference solution for Recitation #8 
gamma = 1.4;
R = 287;

%% --- Step 1 : vector Temp --- %%

Temp = [15 -24];                    

%% --- Step 2 : vector VehicleSpeed --- %%

VehicleSpeed = [100 200];           

%% --- Step 5 : vector Regimes --- %%

Regimes = ["Incompressible" "Subsonic" "Sonic" "Transonic" "Supersonic" "Hypersonic"];

% ===================ANALYSIS/SOLUTION=====================
%% --- Step 3 : Calculating SoundSpeed --- %% 
%% DO NOT USE FOR LOOP
Temp = Temp + 273.15;
SoundSpeed = sqrt(gamma*R*Temp);

%% --- Step 4 : Calculating vector MachNumber --- %%
%% DO NOT USE FOR LOOP

MachNumber = VehicleSpeed./SoundSpeed;


for i = 1:length(MachNumber)
    if MachNumber(i) < 0.3
        
        flow = Regimes(1);
        
    elseif MachNumber(i) >= 0.3 && MachNumber(i) < 0.8 
        
        flow = Regimes(2);
        
    end 
    
    fprintf("Vehicle %g has a Mach = %0.2g (%s)\n",i,MachNumber(i),flow);
end 