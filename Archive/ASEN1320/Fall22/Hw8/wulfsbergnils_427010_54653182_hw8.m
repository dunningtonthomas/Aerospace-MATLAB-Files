

gamma = 1.4;                     % [-] Specific heat ratio
R =     287;                     % [J/kg*K] specific gas constant air 

%% --- Step 1 : vector Temp --- %%

Temp = [-56 15 -24 -56 17 -56];  % [Celsius] 
KTemp = Temp + 273.15;
%% --- Step 2 : vector VehicleSpeed --- %%

VehicleSpeed = [599.5 340.3 78.2 212.3 1743.5 262.5];              % [m/s]

%% --- Step 5 : vector Regimes --- %%

Regimes = ["Incompressible" "Subsonic" "Sonic" "Transonic" "Supersonic" "Hypersonic"];

% ===================ANALYSIS/SOLUTION=====================
%% --- Step 3 : Calculating SoundSpeed --- %% 
%% DO NOT USE FOR LOOP

SoundSpeed = sqrt(gamma.*R.*KTemp);

%% --- Step 4 : Calculating vector MachNumber --- %%
%% DO NOT USE FOR LOOP

MachNumber = VehicleSpeed ./ SoundSpeed;

%% --- Step 6 : Printing "Vehicle X has a Mach = X.XX (<regime>)" --- %%

for i = 1:length(MachNumber)
    if(MachNumber(i) < 0.3)
        Regime = Regimes(1);
    elseif(MachNumber(i) >= 0.3 && MachNumber(i) < 0.8)
        Regime = Regimes(2);
    elseif(MachNumber(i) >= (1 - 0.001) && MachNumber(i) <= (1 + 0.001))
        Regime = Regimes(4);
    elseif(MachNumber(i) >= 0.8 && MachNumber(i) < 1.2)
        Regime = Regimes(3);
    elseif(MachNumber(i) >= 1.2 && MachNumber(i) < 5)
        Regime = Regimes(5);
    elseif(MachNumber(i) > 5)
        Regime = Regimes(6);
    end
    text = 'Vehicle %0.0u has a Mach = %g (%s)\n';
    fprintf(text, i, MachNumber(i), Regime)
end




