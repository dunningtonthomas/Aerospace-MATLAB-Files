%% ODE function Handle for Satellite States
% Function is used by ODE45 to generate the Satellite States.
% Inputs: t    -> time  s -> States (size 6x1) [x;y;z;vx;vy;vz];
% Output: dsdt -> Rate of change of States (size 6x1)

function dsdt = OrbitEOM(t,s)

    mu = 3.986e5;               % GM of Earth
    
    r(:,1) = s(1:3);            % Position Vector
    v(:,1) = s(4:6);            % Velocity Vector
    
    normR = norm(r);            % Magnitude of position
    dsdt = [v;-mu*r/normR^3];   % Rate of change of States  
    
end