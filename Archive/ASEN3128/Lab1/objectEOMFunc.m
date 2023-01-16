function xdot = objectEOM(t, x, rho, Cd, A, m, g, wind)    
%     Inputs:     x = column vector of the state of the golf ball with its position and velocity
%                   = [xPosition; yPosition; zPosition; xVelocity; yVelocity; zVelocity];
%                Cd = coefficient of drag
%                 A = cross sectional area
%                 m = mass of the golf ball
%                 g = acceleration due to gravity
%              wind = wind velocity vector
%              
%     Outputs: xdot = rates of change of the state vector
%                   = [xVelocity; yVelocity; zVelocity; xAcceleration; yAcceleration; zAcceleration]
%                   
%     This function calculates the rate of change of the position vector and
%     the velocity vector for a golf ball projectile
    
        %Finding the air relative velocity
        airRelVel = x(4:6) - wind;
        
        %Normalizing the air relative velocity into a unit vector
        headingVec = airRelVel / norm(airRelVel);

        %Calculating Drag
        drag = 1/2 * (rho * norm(airRelVel)^2) * A * Cd;

        %Summing the forces (drag and gravity)
        forceVec = -drag*headingVec + [0; 0; m * g];
        
        %Finding the acceleration
        accelVec = forceVec ./ m;

        %Calculating the rate of change
        xdot = [x(4); x(5); x(6); accelVec(1); accelVec(2); accelVec(3)];    
end