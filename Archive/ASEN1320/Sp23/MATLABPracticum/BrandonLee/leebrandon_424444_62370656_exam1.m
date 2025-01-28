clc, clear, close all;


accuracy = input("Enter Accuracy:");
n = input('n:');

approximation = (1-(1/n)).^n;
actual = (1/(1*exp(1)));

fprintf('Approximation:%.5f',approximation);
fprintf(' Actual:%.5f \n',actual);