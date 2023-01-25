function outputInt = trapzFuncy(func,interval,N)
%TRAPZFUNC Performs a trapezoidal numerical integration on a provided
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

%Performing the trapezoidal integration
outputInt = 0;
for i = 1:length(N)
    %Getting the left and right y values of the trapezoid
    leftY = func(xVals(i)); 
    rightY = func(xVals(i+1));
    
    %Length of the base of the trapezoid
    base = xVals(i+1) - xVals(i); 
    
    %Area of the trapezoid
    area = ((leftY + rightY) / 2) * base;
    
    outputInt = outputInt + area; %Adding area to the sum        
end


end

