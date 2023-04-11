function dydt = GravityTurnEOM(t,y,g,isp)

    %% States
    % y(1) -> velocity
    % y(2) -> flight path angle 
    % y(3) -> altitude
    % y(4) -> x, Horizontal distance (m)
    % y(5) -> mass of the lander

    %%
    % g -> Gravitational Acceleration of moon
    % isp -> Specific Impulse of the lander engine
    
    v = y(1); Gamma = y(2); h = y(3); x = y(4); m = y(5);
    
    R = -h/sin(Gamma);
    Thrust = m * (g + v^2/(2*R));
    
    dydt = zeros(5,1);

    dydt(1) = -g * (Thrust/(m*g)+sin(Gamma));
    dydt(2) = (-g/v) * cos(Gamma);
    dydt(3) = v * sin(Gamma);
    dydt(4) = v * cos(Gamma);
    dydt(5) = -Thrust / (g*isp);

end

