%clearing command window
close all;clear all;clc

%declaring the x vector and inidializing the y values to be zero
x = linspace(-1,3,100);
y= zeros(1,length(x));

%creating a for loop to loop through the vector x
for i = 1: length(x)

%creating an if statement for when x is greater than or equal to -1 and
%less than 0, solve this y
    if (x(i) >= -1 ) && (x(i) < 0)

        y(i) = (x(i).^2 + 1) / (x(i).^2 + x(i));

    end
%creating an if statement for when x is greater than or equal to 0 and
%less than 2.718, solve this y
    if (x(i) >= 0) && (x(i) < 2.718)

    y(i) = 15*log(x(i));

    end
 %creating an if statement for when x is greater than or equal to 2.7178 and
%less than or equal to 3, solve this y
    if (x(i) >= 2.7178) && ( x(i) <= 3)

        y(i) = 12.386 - x(i).^2;
    end

%plotting the x and y and coloring the lind cyan
    plot(x,y,'c');
    
%turning the grid on
    grid ON;
end
