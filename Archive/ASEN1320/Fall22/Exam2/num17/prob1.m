close all; clear all; clc;

x = linspace(-1,3,100); %sets the x vector from -1,3 with 100 evelnly spaced values
yvect = zeros(1,length(x)); %sets a y vector with all zeros in it from 1 to the length of x

for i = 1:length(x) %starts a for loop from 1 to length of x
    if (x(i) >= -1) && (x(i) <= 0) %sets a condition between -1 and 0
        yvect(i) = (x(i)^2 + 1)/(x(i)^2 +x(i));  %if condition is true store this function in y vect

    elseif (x(i) >= 0) && (x(i) <= 2.718) %sets a condition between 0 and 2.718
        yvect(i) = 15*log(x(i)); %if condition is true store this function in y vect

    elseif (x(i) >= 2.718) && (x(i) <= 3) %sets a condtion between 2.718 and 3
        yvect(i) = 12.386 - x(i)^2;  %if condition is true store this function in y vect

    end %ends the if and elseif statements
end %ends the for loop

plot(x,yvect,'c') %plots x vs yvect and makes the line cyan
title('Problem 1') %titles the plot Problem 1
xlabel('x') %labels the x axis x
ylabel('y(x)') %labels the y axis y(x)
grid on; %turns the grid on