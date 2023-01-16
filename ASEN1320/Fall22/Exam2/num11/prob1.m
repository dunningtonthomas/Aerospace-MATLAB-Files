close all; clear all; clc;

N = 100;

xVec = linspace(-1, 3, N);
yVec = zeros(1, N);

for i = 1:N
    x = xVec(i);

    if x < 0
        yVec(i) = (x^2 + 1) / (x^2 + x);
    elseif x < 2.718
        yVec(i) = 15 * log(x);
    else
        yVec(i) = 12.386 - x^2;
    end
end

% Plot

plot(xVec, yVec, 'c');
grid on;
xlabel('x');
ylabel('y(x)');
title('Problem 1');