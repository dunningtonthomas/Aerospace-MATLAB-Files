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


%Number of subpanels
n = 2*N;
h = (interval(2) - interval(1)) / n;

%X values
xVals = linspace(interval(1), interval(2), n + 1);

outputSum = 0;
for i = 1:N
    outputSum = outputSum + func(xVals(2*i - 1)) + 4*func(xVals(2*i)) + func(xVals(2*i + 1));
    
end

outputInt = (h / 3) * outputSum;    


end

