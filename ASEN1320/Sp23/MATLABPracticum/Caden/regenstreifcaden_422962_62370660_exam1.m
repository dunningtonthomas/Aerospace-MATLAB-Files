clc; clear; close all;

%%
a = 0;
while (a < .001)
a = input("Enter accuracy:");
end

%%
n = 2;
e = 1/exp(1);
E = (1-(1/n))^n;
Z = e - E;

     while (Z < a)
         E;
         n = n+1;
     end



