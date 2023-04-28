close all, clear all ,clc;

p=  input("Enter Accuracy:");

while (p < 0.001)
p = input("Enter Accuracy:");
end
n = 1;
l = 1/exp(1);
m = 0;
while ( l > m )
    f = 1 - (1/n);
    m = f^n;
    n = n + 1:
end

fprintf("n: %d Approximation: %d Actual %d", n, m, l);

    