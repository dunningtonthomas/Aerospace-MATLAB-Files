close all; clear all; clc;


x = linspace(-1, 3, 100);
y = length(x);
y = zeros(y);


for i = -1:length(x)
    for j = lenght(x)
        if (i == -1)
            y(j) = (x^2+1)/(x^2+x);
        elseif (i == 0<=2.717)
            y(j) = (15*log(x));
        elseif (i == 2.718<=3)
            y(j) = 12.386 - x^2;

        end
    end
end

plot(y,x, "-c");