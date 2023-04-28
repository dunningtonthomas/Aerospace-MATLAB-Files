clc, clear, close all;

x = input("Enter Accuracy:");

n = 0;
error = 1;
actual = 1/(exp(1));


while error >  x


n = n + 1;

e = (1 - (1/n))^n;

error = abs(e - actual);


end


fprintf("n:%.0f Approximation:%.5f Actual%.5f\n", n, e, actual);