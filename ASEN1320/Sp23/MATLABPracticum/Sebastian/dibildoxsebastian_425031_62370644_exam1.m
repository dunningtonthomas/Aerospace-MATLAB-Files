clc, clear, close all;
%% New line



accuracy=input("Enter Accuracy:");

difference = 0;

while accuracy <0.001
   accuracy=input("Enter Accuracy:");
end

while accuracy>difference
n=1;
difference = (1/exp(1))-(1-(1/n))^n;
n+1;
end


