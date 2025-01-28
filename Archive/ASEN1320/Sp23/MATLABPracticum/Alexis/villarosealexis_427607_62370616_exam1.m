clc, clear, clear all;

Accuracy = input('Enter Accuracy:');
if Accuracy < 0.001 
    Accuracy = input('Enter Accuracy:'); 
else 
    approx = 1/exp(Accuracy);
    actual = 1/exp(1);
    x = approx - actual;
    for i = 1:x
        if 1/exp(1) < Accuracy
            n = 1/exp(i);
            fprintf("n: .5%f",n,"Approximation: .5%f",approx, "Actual: .5%f", actual);
        end
    end 
end 
