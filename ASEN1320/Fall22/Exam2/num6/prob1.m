close all; clear all; clc;

linspace(-1,3,100)

%if and then for loop 
if -1<=x<0;
    for i = length(x)
    i = (x^2 + 1)/(x^2 + x);
    end

    %else if and then nested for loop 
elseif 0 <= x <2.718;
    for j = length(x)
        j = 15*log(x);
    end

    %else for loop for the rest 
else 2.718 <= x <= 3;
     for ij = 2.718<3
         ij = 12.386 - x^2;
     end

%plotting
plot(i,j,ij,'c')
xlabel('x')
ylabel('y(x)')
title('Problem 1')
grid on 


