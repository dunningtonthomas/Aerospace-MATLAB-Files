clc,clear,close all;

x= input('Enter Accuracy:');
n=1;
a= 1/exp(1);
b= (1-1/n)^n;
for  x = 0.0001 || x > 0.0001
   n=b;
   if (b-a) < x
       fprintf('n: %f Approximation: %.5d Actual approximation: %.5d', n,b,a)
    end
end


