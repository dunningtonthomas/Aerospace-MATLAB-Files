close all; clear all; clc; 


x = linspace(-1, 3, 100);
y = zeros(1, 100) ; 




for i = 1:length(x)
    if (x(i) >= -1 && x(i) < 0)
        y(i) = (x(i)^2 +1)/(x(i)^2 + x(i)); 
    elseif (x(i) >= 0 && x(i) < 2.718)
        y(i) = 15*log(x(i));
    else
        y(i) = 12.386 - x(i)^2; 
    end 

end

plot(x, y,'c','linewidth', 2);
xlabel('x');
ylabel('y(x)'); 
title('Problem 1'); 




