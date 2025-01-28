close all; clear; clc; %clear all
%all the parameters
x0 = -1;
x1 = 0;
x2 = 2.718;
x3 = 3;

% x vector
x = linspace (x0,x3,100);

% making space for y with zeros
y = zeros(length(x),1);

%for loop that goes through x
for i = 1:length(x) %x0 + x1


    if (i >= x0) && (i < x1) % if x is between 2 numbers, then y = that
    y(i) = ( ((x(i).^2) + 1) ./ ((x(i).^2) + x) );
    end

    if (i >= x1) && (i < x2) % if x is between these then y = that
    y(i) = 15 .* log(x(i));    
    end

    if (i >= x2) && (i <= x3)
     y(i) = 12.386 - (x(i).^2);    
    end
end
% plotting
plot (x,y,'c'); 
grid on;
xlabel('x');
ylabel('y(x)');
title(" Problem 1");