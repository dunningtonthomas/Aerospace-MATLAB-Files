clc;
clear;
close all;

X = linspace(-1,3,100);
y(1,:) = zeros(1,100);

% For loop not changing Y at all, says no negative integers
for i = length(X)
    while(i<0)
        y(1,i) = ((i^2) + 1)/((i^2) + i);
    end
    
    while((0 <= i) && (i < 2.718))
        y(1,i) = 15*log(i);
    end

    while((2.718 <= i) && (i <= 3))
        y(1,i) = 12.386 - i^2;
    end
end

plot(X, y, 'C');
title('Problem 1');
xlabel('x');
ylabel('y(x)');
grid on
