close all; clear all; clc; 
% Make an x vector containing 100 evenly spaced values between -1 and 3
x = linspace(-1, 3, 100); 

% Initializing all values to be zero before the loop 
y = zeros(100);

%Control statement has the length of vector x
for i = 1:length(x) 
    if (x>=-1) && (x<0)
        y = (x^2+1)/(x^2+x);
    elseif (x>= 0) && (x<=2.718)
        y = (15*log(x));

    elseif (x>= 2.718) && (x<=3)
        y = 12.386-x^2; 
    end
end

%Plotting Specifications 
LineSpec = 'c-';
plot(y(x), x, LineSpec);