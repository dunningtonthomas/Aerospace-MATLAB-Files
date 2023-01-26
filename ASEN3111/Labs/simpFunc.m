function outputInt = simpFunc(func,interval,N)
%SIMPFUNC Performs a simpson's numerical integration on a provided
%interval using N number of panels in the discretization
%INPUTS: 
%   func is an anonymous single variable function to be integrated
%   interval is a 2x1 interval to be integrated over
%   N is the number of panels in the discretization
%over
%OUTPUTS: outputInt is the value of the integration over the interval
% Author: Thomas Dunnington
% Collaborators: Nolan Stevenson
% Date: 1/24/2023

xVals = linspace(interval(1), interval(2), N+1); %Creating N+1 grid points to integrate over

h = (func(xVals(end)) - func(xVals(1))) / (2*N);

%Performing the trapezoidal integration
outputInt = 0;
for i = 1:N
    
end


end

