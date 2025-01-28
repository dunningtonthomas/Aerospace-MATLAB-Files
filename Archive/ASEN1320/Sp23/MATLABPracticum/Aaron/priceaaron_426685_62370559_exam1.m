clear; close all; clc;

a = input('Enter Accuracy:');

n = 1:200;
b = (1-(1./n)).^n;
e = 1/exp(1);
logVec = (e - b) < a;
I = find(logVec, 1, "first");
fprintf('n:%d Approximation:%.5f Actual:%.5f', I, b(I), e);
