close all; clear all; clc;

% Create x vector
x = linspace(-1 , 3 , 100);

% Create placeholder y
y = zeros(1, 100);

% Loop over all x
for i = 1:length(x)
    % Piecewise y(x)
    if((-1 <= x(i)) && (x(i) < 0))
        y(i) = (x(i)^2 + 1)/(x(i)^2 + x(i));

    elseif ((0 <= x(i)) && (x(i) < 2.718));
        y(i) = 15 * log(x(i));

    else
        y(i) = 12.386 - x(i)^2;
    end

end

% Plot data
plot(x ,y, '-c');
grid on;
title("Problem 1");
xlabel("x");
ylabel("y(x)");

