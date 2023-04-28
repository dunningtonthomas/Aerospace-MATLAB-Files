clc, clear, close all; 

acc = input("Enter Accuracry:");

if acc < 0.001
    acc = input("Enter Accuracry:");
end

n = 2;
actual = (1/exp(1));
for i = 1:n
    while true

        approx = (1-1/n)^n;


        if (actual - approx < acc)
            break
        else
            n = n+1;

        end


    end
end

fprintf('n:%i Approximation:%.5f Actual:%.5f\n', n, approx, actual);




