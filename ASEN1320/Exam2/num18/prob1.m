close all; clear all; clc;

x = linspace(-1, 3, 100); %setting up an evenly spaced x and initial y vector
y = ones(1,100);


for i = 1:length(x) %for loop iterating through each index in x

    if (x(i) >= -1) && (x(i) < 0) %piecewise function reassigning y values depending on x
        
        y(i) = (x(i).^2 + 1)/(x(i).^2 + x(i));
    
    elseif ((x(i) >= 0) && (x(i) < 2.718))
    
        y(i) = 15*log(x(i));
    
    else
        
        y(i) = 12.386 - x(i).^2;
    
    end

end

plot(x,y,"cy") %plotting with labels in cyan
grid on
xlabel("x")
ylabel("y(x)")
title("Problem 1")