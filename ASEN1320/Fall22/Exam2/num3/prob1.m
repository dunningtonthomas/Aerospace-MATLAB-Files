close all;clear all;clc

x = linspace(-1,3,100);
y = zeros(1,length(x));

for i = 1:length(x)
    if -1<=x(i) && x(i)<0
        y(i)=(x(i).^2+1)/(x(i).^2+x(i));
    end
    if 0<=x(i)&&x(i)<2.718
        y(i) = 15.*log(x(i));
    end
    if 2.718<=x(i) && x(i)<=3
       y(i) = 12.386-(x(i).^2) ;
    end
end

plot(x,y,'c')
grid on
title('Problem 1')
xlabel('x')
ylabel('y(x)')