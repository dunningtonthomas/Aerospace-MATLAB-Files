% clean up
close all; clear all; clc;

% using linspace to create a vector of even spacing 
x = linspace(-1,3,100);
y = [zeros(length(x))];
% creating a for loop with if statements to evaluate the function 
for i=-1:length(x)

    if(i >= -1 && i < 0)

    y = (x.^2 + 1) / (x.^2 + x);

    elseif(i >= 0 && i < 2.718)

    y = 15 * log(x);

    elseif(i >= 2.718 && i <= 3)

    y = 12.386 - x.^2;

    end

end

% plotting the function and setting its features
Linspec1 = 'c-';
plot(x,y,Linspec1);
title('Problem 1');
xlabel('x');
ylabel('y(x)');
grid on
