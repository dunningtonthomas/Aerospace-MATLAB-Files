close all; clear all; clc

x = linspace(-1,3,100);

yx = zeros(1,100);

for i=1:length(x)
    if(x(i)>=-1 && x(i)<0)
    yx(i) = (x(i)^2+1)/((x(i)^2)+x(i));
    elseif(x(i)>=0 && x(i)<2.718)
    yx(i) = 15*log(x(i));
    else
    yx(i) = 12.386 - x(i);
    end
end    

plot(x, yx, 'c-')
grid on
xlabel('x')
ylabel('y(x)')
title('Problem 1')