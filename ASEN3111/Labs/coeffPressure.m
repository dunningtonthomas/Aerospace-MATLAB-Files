function Cp = coeffPressure(theta,gamma,radius,velocity)
%COEFFPRESSURE Calculates the coefficient of pressure given a circulation
%and angle
%INPUTS: 
%OUTPUTS: 
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson
% Date: 1/17/2023

Cp = 1 - (4*(sin(theta).^2) + (2*gamma*sin(theta))./(pi*radius*velocity) + (gamma ./ (2*pi*radius*velocity)).^2);

end

