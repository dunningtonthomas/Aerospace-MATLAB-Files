function outVec = EOM(t, state, mu, area, mass)
    %Two body problem EOM
    %State is [x;y;z;vx;vy;vz]
    %outVec is [vx;vy;vz;ax;ay;az] where a is acceleration
    %t is time
    %mu is gravitational constant
    
    %Getting states
    r = state(1:3);
    rDot = state(4:end);
    
    %Two Body Problem
    dr = rDot;
    rDotDot = -1*mu*r ./ (norm(r))^3;
    
    %Calculate rDotDot due to SRP, SRP is in the negative x direction, is
    %constant
    rSat = [-1; 0; 0];
    pSR = 4.57e-6;
    CR = 1.2;
    
    %Solar radiation pressure
    aSR = -((pSR * CR * area) ./ mass) .* rSat / 1000; %km/s^2
    
    %Final rate of change
    outVec = [dr; rDotDot + aSR];
end
