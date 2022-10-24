n = 6;

specificGasConstantAir = 287;
specificHeatRatioAir = 1.4;

temperaturesC = [-56 15 -24 -56 17 -56];
velocities = [599.5 340.3 78.2 212.3 1743.5 262.5];

temperaturesK = temperaturesC + 273.15;

speedOfSounds = sqrt(specificHeatRatioAir .* specificGasConstantAir .* temperaturesK);

machNumber = velocities ./ speedOfSounds;

for i = 1:n
    m = machNumber(i);

    if m < 0.3
        regimes(i) = "Incompressible";
    elseif m < 0.8
        regimes(i) = "Subsonic";
    elseif m <= 1.001 && m >= 0.999
        regimes(i) = "Sonic";
    elseif m <= 1.2
        regimes(i) = "Transonic";
    elseif m < 5
        regimes(i) = "Supersonic";
    else
        regimes(i) = "Hypersonic";
    end
end

for i = 1:n
    fprintf("Vehicle %d has a Mach = %.2g (%s)\n", i, machNumber(i), regimes(i));
end