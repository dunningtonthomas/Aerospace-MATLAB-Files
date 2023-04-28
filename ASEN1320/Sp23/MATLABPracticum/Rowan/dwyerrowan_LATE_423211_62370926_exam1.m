clear all; close all; clc;
accvalue= input("Enter Accuracy:");
if accvalue<0.001
    accvalue= input("Accuracy must be >= 0.001. New accuracy:");
end
n=2;
for i= 1:n
    D= (1/exp(1))-(1-(1/n))^n;
    diff= abs(D);

if diff<accvalue
   break
else
    n=n+1;

end
end

approx= (1-(1/n))^n;
actual= (1/exp(1));
n=n
approx=approx
actual=actual