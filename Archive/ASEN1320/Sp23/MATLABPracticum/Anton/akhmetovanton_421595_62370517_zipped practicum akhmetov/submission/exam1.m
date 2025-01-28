clc, clear, close all;
acc = 0;
while acc < 0.001
    acc = input("Enter Accuracy:");
end

actual = 1/exp(1);
n=0;
estimate = (1-(1/n))^n;
while abs(actual-estimate) > acc
    n= n+1;
    estimate = (1 - (1/n))^n;
end
fprintf("n:%d Approximation:%.5f Actual:%.5f \n",n,estimate,actual)

