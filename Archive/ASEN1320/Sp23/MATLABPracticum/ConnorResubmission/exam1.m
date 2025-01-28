clc, clear, close all;

accuracy = input("Enter Accuracy:");

n = 1;
while (abs((1-(1/n))^n - (1/(exp(1))))) > accuracy  
    n = n+1;
end
a = (1-(1/n))^n;
b = 1/(exp(n));

fprintf("n: %f Approximation: %f Actual: %f\n", n, a, b);
