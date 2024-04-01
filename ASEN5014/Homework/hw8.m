%% Clean
close all; clear; clc;


%% Problem 2
objFunc = @(x1,x2) 4*x1^2 + 5*x2^2 -5*x1*x2;
funHand = @lagrangeEq;
x0 = [0.6;-0.7;0.5];
x = fsolve(funHand, x0);

% Get optimal values
x1 = x(1);
x2 = x(2);


maxVal = objFunc(x1, x2);



function F = lagrangeEq(x)
    x1 = x(1); x2 = x(2); lambda = x(3);
    F = [8*x1 - 5*x2 + lambda*x1 / sqrt(x1^2 + x2^2);
        10*x2 - 5*x1 + lambda*x2 / sqrt(x1^2 + x2^2);
        sqrt(x1^2 + x2^2) - 1];
end