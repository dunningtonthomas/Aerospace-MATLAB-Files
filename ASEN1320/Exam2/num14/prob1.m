close all; clear all; clc;

x = [-1:100:3];

y = zeros(20);

for i= 1:length(x)
    if (i >= -1) & (i < 0)
    y = (i^2+1) / (i^2+i);
    else if (i >= 0) & (i < 2.718)
            y = 15 * log(i);
    else if (i >= 2.718) & (i <= 3)
             y = 12.386 - i^2;
    end 
    end 
    end
end 


 LineSpec1 = 'c-';

plot(x,y,LineSpec1);
title('Problem 1');
xlabel('x');
ylabel('y(x)');

xticks(-1:0.5:3);
yticks(-70:10:20);

grid on

