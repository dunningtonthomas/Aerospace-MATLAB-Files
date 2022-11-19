close all; clear all; clc;

%================Initialize x vector================
x = [-1:2:3];


%================For loop an nested Conditional Equations================
for i=1:length(x)
    if x(i) >= -1 && x(i) < 0
         y = (x(i)^2 + 1) / (x(i)^2 + x(i));
    
    elseif x(i) >= 0 && x(i) < 2.718
        y = 15*log(x(i));
    
    elseif x(i) >= 2.178 && x(i) <= 3
        y = 12.386 - x(i)^2;
    end
end


%================Plotting Parameters================
plot(x,y, 'c-');
title('Problem 1');
xlabel('x');
ylabel('y(x)');
xticks([-1 -0.5 0 0.5 1 1.5 2 2.5 3]);
yticks([-70 -60 -50 -40 -30 -20 -10 0 10 20]);
grid on;